import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/core/models/day_in_week.dart';
import 'package:mou_business_app/core/models/employee.dart';
import 'package:mou_business_app/core/models/task_detail.dart';
import 'package:mou_business_app/core/repositories/project_repository.dart';
import 'package:mou_business_app/core/requests/add_task_request.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:rxdart/rxdart.dart';

class AddTaskViewModel extends BaseViewModel {
  final ProjectRepository projectRepository;
  final EmployeeDao employeeDao;

  AddTaskViewModel({
    required this.projectRepository,
    required this.employeeDao,
  });

  final titleController = TextEditingController();
  final titleFocusNode = FocusNode();

  final commentController = TextEditingController();
  final commentFocusNode = FocusNode();

  final repeatSubject = BehaviorSubject<List<DayInWeek>>();

  final employeeSubject = BehaviorSubject<String>();
  final startDateHourSubject = BehaviorSubject<String>();
  final endDateHourSubject = BehaviorSubject<String>();
  final shopSubject = BehaviorSubject<Shop?>();

  /// this one is for animating text filed image
  final isTypingTaskTitle = BehaviorSubject<bool?>();
  final isTypingDate = BehaviorSubject<bool?>();
  final isTypingDescription = BehaviorSubject<bool?>();
  final isTypingTagSomeOne = BehaviorSubject<bool?>();

  DateTime? startDateHour;
  DateTime? endDateHour;

  TaskDetail? task;
  final ValueNotifier<int> totalDeny = ValueNotifier(0);
  int? statusProject;

  List<DayInWeek>? daysInWeek = [];
  List<EmployeeDetail>? employeesDetail;
  List<Employee>? employees;

  void initData(int taskId) {
    setLoading(true);
    projectRepository.getTaskDetail(taskId).then((resource) async {
      if (resource.isSuccess) {
        task = resource.data;
        totalDeny.value = task?.totalDeny ?? 0;
        titleController.text = task?.title ?? '';
        commentController.text = task?.comment ?? '';
        startDateHourSubject.add(task?.startDate ?? '');
        endDateHourSubject.add(task?.endDate ?? '');
        shopSubject.add(task?.shop);

        isTypingTaskTitle.add(titleController.text.trim().isNotEmpty);
        isTypingDate.add(task?.startDate != null);
        isTypingDescription.add(commentController.text.trim().isNotEmpty);
        isTypingTagSomeOne.add(task?.employees?.isNotEmpty);

        setEmployeeDetails(task?.employees ?? []);

        int startDay = int.parse(task?.startDate?.substring(8, 10) ?? '');
        int startMonth = int.parse(task?.startDate?.substring(5, 7) ?? '');
        int startYear = int.parse(task?.startDate?.substring(0, 4) ?? '');
        int endDay = 0;
        int endMonth = 0;
        int endYear = 0;
        if (task?.endDate != '') {
          endDay = int.parse(task?.endDate?.substring(8, 10) ?? '');
          endMonth = int.parse(task?.endDate?.substring(5, 7) ?? '');
          endYear = int.parse(task?.endDate?.substring(0, 4) ?? '');
        }
        setDate(startDay, startMonth, startYear, endDay, endMonth, endYear);
        if (task?.repeat != null) {
          List<int> listRepeat = task?.repeat?.split(';').map((e) => int.parse(e)).toList() ?? [];
          for (var item in listRepeat) {
            daysInWeek?.add(dayInWeekData[item - 1]);
          }
          repeatSubject.add(daysInWeek ?? []);
        }
      } else {
        showSnackBar(resource.message ?? "");
      }
      setLoading(false);
    }).catchError((Object error) {
      setLoading(false);
      showSnackBar(error.toString());
    });
  }

  void setDate(int startDay, int startMonth, int startYear, int endDay, int endMonth, int endYear) {
    startDateHour = DateTime(startYear, startMonth, startDay);

    String startDateHourString =
        DateFormat(AppConstants.dateFormat).format(startDateHour ?? DateTime.now()).toString();

    startDateHourSubject.add(startDateHourString);
    if (endDay == 0 ||
        endMonth == 0 ||
        endYear == 0 ||
        (startDay == endDay && startMonth == endMonth && startYear == endYear)) {
      endDateHour = null;
      endDateHourSubject.add('');
    } else {
      endDateHour = DateTime(endYear, endMonth, endDay);
      String endDateHourString =
          DateFormat(AppConstants.dateFormat).format(endDateHour ?? DateTime.now()).toString();
      endDateHourSubject.add(endDateHourString);
    }
  }

  void setDaysInWeek(List<DayInWeek> daysInWeek) {
    this.daysInWeek = daysInWeek;
    repeatSubject.add(daysInWeek);
  }

  void setEmployeeDetails(List<EmployeeDetail> employees) {
    this.employeesDetail = employees;
    this.employees = this
        .employeesDetail
        ?.map((e) => Employee(id: e.id ?? 0, contact: {'name': e.name}))
        .toList();
    if (this.employeesDetail != null) {
      var employeeNames = this.employeesDetail?.map((e) => e.name).toList();
      var employeeNameJoin = employeeNames?.join(', ');
      employeeSubject.add(employeeNameJoin ?? '');
    } else {
      employeeSubject.add('');
    }
  }

  void setEmployees(List<Employee> employees) {
    this.employeesDetail =
        employees.map((e) => EmployeeDetail(id: e.id, name: e.contact?['name'])).toList();
    this.employees = employees;
    if (this.employeesDetail != null) {
      var employeeNames = this.employeesDetail?.map((e) => e.name).toList();
      var employeeNameJoin = employeeNames?.join(', ');
      employeeSubject.add(employeeNameJoin ?? '');
    } else {
      employeeSubject.add('');
    }
  }

  void createUpdateTask() async {
    FocusScope.of(context).unfocus();
    if (validate) {
      setLoading(true);
      var employeeIDs = employeesDetail?.map((empDetail) => empDetail.id ?? 0).toList() ?? [];

      var addTaskRequest = AddTaskRequest(
        title: titleController.text,
        comment: commentController.text,
        employees: employeeIDs,
        startDate: startDateHour ?? DateTime.now(),
        endDate: endDateHour,
        storeId: shopSubject.valueOrNull?.id,
      );

      Resource<dynamic> resource;
      if (task == null) {
        resource = await projectRepository.addTask(addTaskRequest);
      } else {
        resource = await projectRepository.editTask(
          task!.id ?? 0,
          addTaskRequest,
        );
        
      }
      setLoading(false);
      if (resource.isSuccess) {
        showSnackBar(
          allTranslations.text(
            task == null
                ? AppLanguages.taskAddedSuccessfully
                : AppLanguages.taskUpdatedSuccessfully,
          ),
          isError: false,
        );
        Navigator.of(context).pop();
      } else {
        showSnackBar(resource.message ?? '');
      }
    }
  }

  bool get validate {
    if (titleController.text.trim().isEmpty) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputTitle));
      return false;
    } else if (employeesDetail == null || employeesDetail!.isEmpty) {
      showSnackBar(allTranslations.text(AppLanguages.validateAddTagSomeone));
      return false;
    } else if ((startDateHourSubject.valueOrNull?.isEmpty ?? true)) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputStartDate));
      return false;
    } else if (startDateHour != null &&
        DateTime(startDateHour!.year, startDateHour!.month, startDateHour!.day, 23, 59, 59)
            .isBefore(DateTime.now())) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputStartTimeGreaterCurrentTime));
      return false;
    } else if (startDateHour != null &&
        endDateHour != null &&
        startDateHour!.isAfter(endDateHour!)) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputStartDateSmallerEndDate));
      return false;
    } else if (shopSubject.valueOrNull == null) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputStore));
      return false;
    }
    return true;
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    titleController.dispose();
    titleFocusNode.dispose();

    commentController.dispose();
    commentFocusNode.dispose();

    startDateHourSubject.drain();
    startDateHourSubject.close();

    endDateHourSubject.drain();
    endDateHourSubject.close();

    repeatSubject.drain();
    repeatSubject.close();

    employeeSubject.drain();
    employeeSubject.close();

    totalDeny.dispose();

    super.dispose();
  }

  void updateShopSelected(Shop? shop) => shopSubject.add(shop);

  void setFocus() {
    titleFocusNode.addListener(() {
      if (!titleFocusNode.hasFocus && !(isTypingTaskTitle.valueOrNull ?? false)) {
        isTypingTaskTitle.add(titleController.text.isNotEmpty);
      }
    });

    commentFocusNode.addListener(() {
      if (!commentFocusNode.hasFocus && !(isTypingDescription.valueOrNull ?? false)) {
        isTypingDescription.add(titleController.text.isNotEmpty);
      }
    });
  }
}
