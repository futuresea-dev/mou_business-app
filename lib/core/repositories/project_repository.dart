import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/project_dao.dart';
import 'package:mou_business_app/core/databases/dao/shop_dao.dart';
import 'package:mou_business_app/core/databases/dao/task_dao.dart';
import 'package:mou_business_app/core/models/task_detail.dart';
import 'package:mou_business_app/core/network_bound_resource.dart';
import 'package:mou_business_app/core/requests/add_project_request.dart';
import 'package:mou_business_app/core/requests/add_task_request.dart';
import 'package:mou_business_app/core/requests/edit_project_request.dart';
import 'package:mou_business_app/core/requests/edit_task_request.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/core/responses/project_detail/project_detail_response.dart';
import 'package:mou_business_app/core/services/api_service.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_apis.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_shared.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectRepository {
  CancelToken _cancelToken = CancelToken();

  final ProjectDao projectDao;
  final TaskDao taskDao;
  final ShopDao shopDao;

  ProjectRepository(this.projectDao, this.taskDao, this.shopDao);

  Future<Resource<dynamic>> addTask(AddTaskRequest addTaskRequest) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<Map<String, dynamic>, Map<String, dynamic>>(
      createCall: () => APIService.addTask(companyId, addTaskRequest, _cancelToken),
      parsedData: (data) => data,
      saveCallResult: (json) async {
        final shop = Shop.fromJson(json["store"]);
        await shopDao.insertShop(shop);
        final data = Task.fromJson(json);
        await taskDao.insertTask(data.copyWith(storeId: Value(shop.id)));
      },
    );

    return resource.getAsObservable();
  }

  Future<Resource<Project>> addProject(AddProjectRequest addProjectRequest) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<Project, Project>(
      createCall: () => APIService.addProject(companyId, addProjectRequest, _cancelToken),
      parsedData: (json) => Project.fromJson(json),
      saveCallResult: (response) => projectDao.insertProject(response),
    );

    return resource.getAsObservable();
  }

  Future<Resource<ProjectDetailResponse>> getProjectDetail(int projectId) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<ProjectDetailResponse, ProjectDetailResponse>(
      createCall: () => APIService.getProjectDetail(companyId, projectId, _cancelToken),
      parsedData: (json) => ProjectDetailResponse.fromJson(json),
    );
    return resource.getAsObservable();
  }

  Future<Resource<TaskDetail>> getTaskDetail(int taskId) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<TaskDetail, TaskDetail>(
      createCall: () => APIService.getTaskDetail(companyId, taskId, _cancelToken),
      parsedData: (json) => TaskDetail.fromJson(json),
      saveCallResult: (data) async {},
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> editTask(int taskId, AddTaskRequest addTaskRequest) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.editTask(companyId, taskId, addTaskRequest, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (json) async {
        final shop = Shop.fromJson(json["store"]);
        shopDao.insertShop(shop);

        //
        json.remove("store");
        final task = Task.fromJson(json);
        var taskExist = await taskDao.getTaskById(task.id);
        if (taskExist != null) {
          var taskObj = taskExist.copyWith(title: task.title);
          await taskDao.updateTask(taskObj);
        }
      },
      loadFromDb: () async => await null,
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> addTaskOfProject(int projectId, EditTaskRequest editTaskRequest) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<dynamic, Task>(
      createCall: () =>
          APIService.addTaskOfProject(companyId, projectId, editTaskRequest, _cancelToken),
      parsedData: (json) => Task.fromJson(json),
      saveCallResult: (task) async {
        final Project? project = await projectDao.getProjectByID(projectId);
        await taskDao.updateTask(task);
        if (project != null) await projectDao.updateProject(project.copyWith(title: task.title));
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> editTaskOfProject(
      int projectId, int taskId, EditTaskRequest editTaskRequest) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<dynamic, Task>(
      createCall: () =>
          APIService.editTaskOfProject(companyId, projectId, taskId, editTaskRequest, _cancelToken),
      parsedData: (json) => Task.fromJson(json),
      saveCallResult: (data) async => await taskDao.updateTask(data),
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> deleteTaskOfProject(int projectId, int taskId) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.deleteTaskOfProject(companyId, projectId, taskId, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (c) => taskDao.deleteTaskByID(taskId),
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> deleteTask(int taskId) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.deleteTask(companyId, taskId, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (c) async {
        await taskDao.deleteTaskByID(taskId);
        await projectDao.deleteProjectByID(taskId);
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> deleteProject(int projectId) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.deleteProject(companyId, projectId, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (c) => projectDao.deleteProjectByID(projectId),
    );
    return await resource.getAsObservable();
  }

  Future<Resource<dynamic>> editProject(
    int projectId,
    EditProjectRequest editProjectRequest,
  ) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () =>
          APIService.editProject(companyId, projectId, editProjectRequest, _cancelToken),
      parsedData: (json) => {print(json)},
      saveCallResult: (response) async {
        final Project? project = await projectDao.getProjectByID(projectId);
        if (project != null) {
          await projectDao.updateProject(project.copyWith(title: editProjectRequest.title));
        }
      },
    );
    return resource.getAsObservable();
  }

  Future<String?> downloadFile(int eventId) async {
    final String downloadUrl = AppApis.domainAPI + AppApis.exportReport(eventId);
    if (await canLaunchUrl(Uri.parse(downloadUrl))) {
      final Directory? directory = Platform.isIOS
          ? await getApplicationDocumentsDirectory()
          : await getExternalStorageDirectory();
      if (directory != null && directory.existsSync()) {
        return FlutterDownloader.enqueue(
          url: downloadUrl,
          savedDir: directory.path,
          showNotification: false,
          openFileFromNotification: false,
        );
      } else {
        throw S.text(AppLanguages.couldNotCreateDirectory);
      }
    }
    throw S.text(AppLanguages.thisProjectCannotBeExported);
  }

  cancel() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }
}
