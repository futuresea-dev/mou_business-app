import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mou_business_app/core/models/task_detail.dart';
import 'package:mou_business_app/core/repositories/project_repository.dart';
import 'package:mou_business_app/core/responses/project_detail/project_detail_response.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:rxdart/rxdart.dart';

class ProjectDetailViewModel extends BaseViewModel {
  final ProjectRepository projectRepository;
  final int projectId;

  var projectDetailSubject = BehaviorSubject<ProjectDetailResponse>();
  var hiddenProjectInfoSubject = BehaviorSubject<bool>();
  var isShowDescriptionSubject = BehaviorSubject<bool>();
  final indexShowTaskAddSubject = BehaviorSubject<int>();

  ProjectDetailViewModel({
    required this.projectRepository,
    required this.projectId,
  });

  void initData() async {
    setLoading(true);
    var resource = await projectRepository.getProjectDetail(projectId);
    if (resource.isSuccess) {
      var data = resource.data;
      projectDetailSubject.add(data!);
      hiddenProjectInfoSubject.add(false);
      print(resource);
    } else {
      projectDetailSubject.add(ProjectDetailResponse());
    }
    setLoading(false);
  }

  String getProjectDate(List<TaskDetail> tasks) {
    String result = "";
    var startDateHour = "";
    var endDateHour = "";

    if (tasks.length > 1) {
      final taskFirst = tasks.first;
      startDateHour = taskFirst.startDate ?? "";

      final taskLast = tasks.last;
      endDateHour = taskLast.endDate ?? "";
    } else if (tasks.length == 1) {
      var task = tasks.first;
      startDateHour = task.startDate ?? "";
      endDateHour = task.endDate ?? "";
    } else {
      return "";
    }

    var startDate = DateTime.parse(startDateHour);
    var startDateString = DateFormat("dd/MM/yy").format(startDate).toString();

    result = startDateString;
    if (endDateHour != "") {
      var endDate = DateTime.parse(endDateHour);
      var endDateString = DateFormat("dd/MM/yy").format(endDate).toString();
      result += " - " + endDateString;
    }
    return result;
  }

  String getTeams(List<EmployeeResponsible> teams) {
    String result = "";
    if ((teams.length <= 0)) return result;

    var lstTeam = teams.map<String>((employee) => employee.name ?? "").toList();
    result = lstTeam.join(", ");

    return result;
  }

  Color getStatusColor(String status) {
    Color result;
    switch (status) {
      case TaskStatus.WAITING:
        result = Color(0xffbabdc8);
        break;
      case TaskStatus.IN_PROGRESS:
        result = Color(0xfff2ea61);
        break;
      case TaskStatus.DONE:
        result = Color(0xff6dab6c);
        break;
      case TaskStatus.NOT_DONE:
        result = Color(0xffeb6265);
        break;
      default:
        // Handle the case where the status doesn't match any of the predefined values
        result = Colors.black; // For example, you can assign a default color
        break;
    }
    return result;
  }

  void showHiddenProjectInfo() {
    var isHidden = hiddenProjectInfoSubject.valueOrNull ?? false;
    hiddenProjectInfoSubject.add(!isHidden);
  }

  void showHiddenDescription() {
    var isHidden = isShowDescriptionSubject.valueOrNull ?? false;
    isShowDescriptionSubject.add(!isHidden);
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void showTaskForm({int? index}) {
    this.indexShowTaskAddSubject.add(index ?? -1);
  }

  @override
  void dispose() async {
    await projectDetailSubject.drain();
    projectDetailSubject.close();

    await hiddenProjectInfoSubject.drain();
    hiddenProjectInfoSubject.close();

    await isShowDescriptionSubject.drain();
    isShowDescriptionSubject.close();

    await indexShowTaskAddSubject.drain();
    indexShowTaskAddSubject.close();

    super.dispose();
  }
}
