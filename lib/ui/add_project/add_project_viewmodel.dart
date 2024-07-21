import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/core/models/employee.dart';
import 'package:mou_business_app/core/repositories/employee_repository.dart';
import 'package:mou_business_app/core/repositories/project_repository.dart';
import 'package:mou_business_app/core/requests/add_project_request.dart';
import 'package:mou_business_app/core/requests/edit_project_request.dart';
import 'package:mou_business_app/core/requests/edit_task_request.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:rxdart/rxdart.dart';

class AddProjectViewModel extends BaseViewModel {
  final ProjectRepository projectRepository;
  final EmployeeDao employeeDao;
  final EmployeeRepository employeeRepository;
  final int projectId;

  AddProjectViewModel({
    required this.projectRepository,
    required this.employeeRepository,
    required this.employeeDao,
    required this.projectId,
  });

  int totalDeny = 0;

  final titleController = TextEditingController();
  final titleFocusNode = FocusNode();

  final scopeController = TextEditingController();
  final scopeFocusNode = FocusNode();

  final clientController = TextEditingController();
  final clientFocusNode = FocusNode();

  final teamsSubject = BehaviorSubject<String>();
  final tasksSubject = BehaviorSubject<List<Task>>();
  final tagResponsibleSubject = BehaviorSubject<String>();

  final selectedTaskSubject = BehaviorSubject<Task?>();

  /// this one is for animating text filed image Project
  bool _isTypingTitle = false;

  bool get isTypingTitle => _isTypingTitle;

  set isTypingTitle(bool value) {
    _isTypingTitle = value;
    notifyListeners();
  }

  /// this one is for animating text filed image Scope
  bool _isTypingScope = false;

  bool get isTypingScope => _isTypingScope;

  set isTypingScope(bool value) {
    _isTypingScope = value;
    notifyListeners();
  }

  /// this one is for animating text filed image Client
  bool _isTypingClient = false;

  bool get isTypingClient => _isTypingClient;

  set isTypingClient(bool value) {
    _isTypingClient = value;
    notifyListeners();
  }

  Employee? tagResponsible;
  List<Employee> teams = [];
  List<Task> tasks = [];
  List<Employee> employees = [];

  void initData() async {
    try {
      if (projectId != 0) {
        setLoading(true);
        var resource = await projectRepository.getProjectDetail(projectId);
        if (resource.isSuccess) {
          var projectDetail = resource.data;
          totalDeny = projectDetail?.totalDeny ?? 0;
          titleController.text = projectDetail?.title ?? '';
          _isTypingTitle = titleController.text.isNotEmpty;
          scopeController.text = projectDetail?.description ?? '';
          _isTypingScope = scopeController.text.isNotEmpty;
          clientController.text = projectDetail?.client ?? '';
          _isTypingClient = clientController.text.isNotEmpty;
          notifyListeners();

          List<Employee> employeesLocal = await employeeDao.getLocalEmployees();
          if (employeesLocal.isEmpty) {
            final response = await employeeRepository.getEmployeeList();
            if (response.isSuccess) {
              employeesLocal = response.data?.data ?? [];
            }
          }
          employees = employeesLocal;

          if (projectDetail?.employeeResponsible != null && employeesLocal.isNotEmpty) {
            /// Get RESPONSIBLE field
            var employeeResponsible = projectDetail?.employeeResponsible;
            var responsibleId = employeeResponsible?.id ?? -1;
            if (responsibleId != -1) {
              tagResponsible = employeesLocal.firstWhereOrNull((e) => e.id == responsibleId);
              tagResponsibleSubject.add(employeeResponsible?.name ?? '');
            }

            /// Get TEAM field
            var teamsResponseId = projectDetail?.teams?.map<int>((e) => e.id ?? 0).toList();
            teams = employeesLocal
                .where((element) => teamsResponseId?.contains(element.id) ?? false)
                .toList();
            var teamsString = teams.map<String>((e) => e.contact?['name']).toList();
            var employeesString = '';
            if (teamsString.isNotEmpty) {
              employeesString = teamsString.join(', ');
            }
            teamsSubject.add(employeesString);
          }

          if (projectDetail?.tasks?.isNotEmpty ?? false) {
            for (var taskDetail in projectDetail?.tasks ?? []) {
              var task = Task(
                id: taskDetail.id ?? 0,
                title: taskDetail.title ?? '',
                employees: (taskDetail.employees != null ? taskDetail.employees : null) ?? [],
                startDate: taskDetail.startDate ?? '',
                endDate: taskDetail.endDate ?? '',
                comment: taskDetail.comment ?? '',
              );
              tasks.add(task);
            }
            tasksSubject.add(tasks);
          }
        } else {
          showSnackBar(resource.message ?? '');
        }
        setLoading(false);
      }
    } catch (ex) {
      setLoading(false);
      print(ex);
    }
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void setTagResponsible(Employee employee) {
    this.tagResponsible = employee;
    if (this.tagResponsible != null) {
      tagResponsibleSubject.add(employee.contact?['name'] ?? '');
    } else {
      tagResponsibleSubject.add('');
    }
  }

  void setTeam(List<EmployeeDetail> employeeDetails, {bool isRemove = false}) {
    if (isRemove) {
      this
          .teams
          .removeWhere((element) => employeeDetails.map((e) => e.id).toList().contains(element.id));
    } else {
      List<Employee> employees = [];
      employeeDetails.forEach((element) {
        if (!this.teams.map((e) => e.id).toList().contains(element.id)) {
          employees.add(Employee(id: element.id ?? 0, employeeName: element.name));
        }
      });
      this.teams.addAll(employees);
    }
    List<String> employeeNames =
        this.teams.map((e) => e.employeeName ?? e.contact?['name'].toString() ?? '').toList();
    teamsSubject.add(employeeNames.isNotEmpty ? employeeNames.join(', ') : '');
  }

  bool get validate {
    if (titleController.text.trim().isEmpty) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputProjectTitle));
      return false;
    } else if (clientController.text.trim().isEmpty) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputClient));
      return false;
    } else if (tagResponsible == null) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseSelectTahResponsible));
      return false;
    } else if (tasks.isEmpty) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseCreateTaskProject));
      return false;
    }
    return true;
  }

  void addOrUpdateTaskOfProject(Task task) async {
    FocusScope.of(context).unfocus();
    setLoading(true);
    List<EmployeeDetail> employeeDetails =
        task.employees?.map((e) => e as EmployeeDetail).toList() ?? [];
    if (task.id == 0) {
      if (projectId == 0) {
        // Case: new project - new task
        Task? selectedTask = selectedTaskSubject.value;
        if (selectedTask != null) {
          // Case: update
          var indexItem = tasks.indexOf(selectedTask);
          var taskUpdate = selectedTask.copyWith(
            title: task.title,
            comment: Value(task.comment),
            employees: Value(task.employees),
            startDate: Value(task.startDate),
            endDate: Value(task.endDate),
          );
          tasks.insert(indexItem, taskUpdate);
          tasks.remove(selectedTask);
        } else {
          // Case: create
          tasks.add(task);
        }
        setTeam(employeeDetails);
        tasksSubject.add(tasks);
      } else {
        // Case: update project - new task
        List<int> employeeIDs = <int>[];
        if (task.employees?.isNotEmpty ?? false) {
          employeeIDs = task.employees!.map((e) => (e as EmployeeDetail).id ?? 0).toList();
        }
        var taskRequest = EditTaskRequest(
          title: task.title,
          comment: task.comment,
          startDate: task.startDate,
          endDate: task.endDate,
          employees: employeeIDs,
        );
        var resource = await projectRepository.addTaskOfProject(projectId, taskRequest);
        if (resource.isSuccess) {
          tasks.add(task);
          tasksSubject.add(tasks);
          setTeam(employeeDetails);
        } else {
          showSnackBar(resource.message ?? '');
        }
      }
    } else {
      if (projectId != 0) {
        // Case: update project - update task
        var employeeIDs = <int>[];
        if (task.employees?.isNotEmpty ?? false) {
          employeeIDs = task.employees!.map((e) => (e as EmployeeDetail).id ?? 0).toList();
        }
        var editTaskRequest = EditTaskRequest(
          title: task.title,
          comment: task.comment,
          startDate: task.startDate,
          endDate: task.endDate,
          employees: employeeIDs,
        );
        var resource =
            await projectRepository.editTaskOfProject(projectId, task.id, editTaskRequest);
        if (resource.isSuccess) {
          var taskFilter = tasks.firstWhereOrNull((element) => element.id == task.id);
          if (taskFilter != null) {
            tasks.remove(taskFilter);
            tasks.add(task);
            tasksSubject.add(tasks);
          }
          setTeam(employeeDetails);
        } else {
          showSnackBar(resource.message ?? '');
        }
      }
    }
    setLoading(false);
    selectedTaskSubject.add(null);
  }

  Future<void> deleteTask(Task task) async {
    List<Task> tasks = tasksSubject.value;
    int taskId = task.id;
    List<EmployeeDetail> employeeDetails =
        task.employees?.map((e) => e as EmployeeDetail).toList() ?? [];
    if (taskId == 0) {
      // Case: task when create project
      setTeam(employeeDetails, isRemove: true);
      tasks.remove(task);
      tasksSubject.add(tasks);
    } else {
      // Case: task when update project
      Resource<dynamic> resource = await projectRepository.deleteTaskOfProject(projectId, taskId);

      if (resource.isSuccess) {
        setTeam(employeeDetails, isRemove: true);
        tasks.removeWhere((task) => task.id == taskId);
        tasksSubject.add(tasks);
        showSnackBar(
          allTranslations.text(AppLanguages.taskDeletedSuccessfully),
          isError: false,
        );
      } else {
        showSnackBar(resource.message ?? '');
      }
    }
  }

  void createProject() async {
    try {
      FocusScope.of(context).unfocus();
      setLoading(true);
      if (validate) {
        var title = titleController.text;
        var description = scopeController.text;
        var client = clientController.text;

        var tagResponsible = this.tagResponsible != null ? this.tagResponsible?.id : 0;
        var lstTeams = this.teams.map((e) => e.id).toList();

        Resource<dynamic> resource;
        if (this.projectId != 0) {
          /// Edit project
          var editProjectRequest = EditProjectRequest(
            title: title,
            description: description,
            client: client,
            employeeResponsibleId: tagResponsible ?? 0,
            teams: lstTeams,
          );
          resource = await projectRepository.editProject(projectId, editProjectRequest);
        } else {
          /// Add project
          var addProjectRequest = AddProjectRequest(
            title: title,
            description: description,
            client: client,
            employeeResponsibleId: tagResponsible ?? 0,
            teams: lstTeams,
            tasks: tasks,
          );
          resource = await projectRepository.addProject(addProjectRequest);
        }

        //Return result
        if (resource.isSuccess) {
          Navigator.pop(context);
          showSnackBar(
            allTranslations.text(this.projectId != 0
                ? AppLanguages.projectUpdatedSuccessful
                : AppLanguages.projectAddSuccessful),
            isError: false,
          );
        } else {
          showSnackBar(resource.message ?? '');
        }
      }
      setLoading(false);
    } catch (e) {
      setLoading(false);
      showSnackBar(e.toString());
    }
  }

  @override
  void dispose() async {
    titleController.dispose();
    titleFocusNode.dispose();
    scopeController.dispose();
    scopeFocusNode.dispose();
    await teamsSubject.drain();
    teamsSubject.close();
    await tagResponsibleSubject.drain();
    tagResponsibleSubject.close();
    await tasksSubject.drain();
    tasksSubject.close();
    await selectedTaskSubject.drain();
    selectedTaskSubject.close();
    super.dispose();
  }
}
