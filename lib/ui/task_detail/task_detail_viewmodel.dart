import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/core/models/day_in_week.dart';
import 'package:mou_business_app/core/models/employee.dart';
import 'package:mou_business_app/core/repositories/project_repository.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:rxdart/rxdart.dart';

class TaskDetailViewModel extends BaseViewModel {
  final ProjectRepository projectRepository;
  final EmployeeDao employeeDao;

  TaskDetailViewModel({
    required this.projectRepository,
    required this.employeeDao,
  });

  final commentSubject = BehaviorSubject<String?>();
  final employeeSubject = BehaviorSubject<String?>();
  final startDateSubject = BehaviorSubject<String?>();
  final endDateSubject = BehaviorSubject<String?>();

  DateTime? startDateHour;
  DateTime? endDateHour;
  bool isUseEndDate = false;

  List<DayInWeek> daysInWeek = [];
  List<EmployeeDetail> employeesDetail = [];
  List<Employee> employees = [];

  void initData(int taskId) {
    setLoading(true);
    projectRepository.getTaskDetail(taskId).then((resource) async {
      if (resource.isSuccess) {
        final data = resource.data;
        commentSubject.add(data?.comment);
        startDateSubject.add(data?.startDate);
        endDateSubject.add(data?.endDate);

        setEmployeeDetails(data?.employees ?? []);

        int startDay =
            int.tryParse(data?.startDate?.substring(8, 10) ?? "1") ?? 1;
        int startMonth =
            int.tryParse(data?.startDate?.substring(5, 7) ?? "1") ?? 1;
        int startYear = int.tryParse(
                data?.startDate?.substring(0, 4) ?? "${DateTime.now().year}") ??
            DateTime.now().year;
        int endDay = 0;
        int endMonth = 0;
        int endYear = 0;
        if (data?.endDate != "") {
          endDay = int.tryParse(data?.endDate?.substring(8, 10) ?? "1") ?? 1;
          endMonth = int.tryParse(data?.endDate?.substring(5, 7) ?? "1") ?? 1;
          endYear = int.tryParse(
                  data?.endDate?.substring(0, 4) ?? "${DateTime.now().year}") ??
              DateTime.now().year;
          isUseEndDate = true;
        }
        setDate(startDay, startMonth, startYear, endDay, endMonth, endYear,
            isUseEndDate);
      } else {
        showSnackBar(resource.message);
      }
      setLoading(false);
    }).catchError((Object error) {
      setLoading(false);
      showSnackBar(error.toString());
    });
  }

  void setDate(int startDay, int startMonth, int startYear, int endDay,
      int endMonth, int endYear, bool isUseEndDate) {
    this.isUseEndDate = isUseEndDate;
    startDateHour = DateTime(startYear, startMonth, startDay);
    endDateHour = DateTime(endYear, endMonth, endDay);

    var startDateHourString = DateFormat(AppConstants.dateFormat)
        .format(startDateHour ?? DateTime.now())
        .toString();
    var endDateHourString = DateFormat(AppConstants.dateFormat)
        .format(endDateHour ?? DateTime.now())
        .toString();

    if (!this.isUseEndDate) {
      startDateSubject.add("$startDateHourString");
      endDateHour = null;
      endDateSubject.add("");
    } else {
      if (startDay == endDay &&
          startMonth == endMonth &&
          startYear == endYear) {
        startDateSubject.add("$startDateHourString");
        endDateHour = null;
        endDateSubject.add("");
      } else {
        startDateSubject.add("$startDateHourString");
        endDateSubject.add("$endDateHourString");
      }
    }
  }

  void setEmployeeDetails(List<EmployeeDetail> employees) {
    this.employeesDetail = employees;
    this.employees = this
        .employeesDetail
        .map((e) => Employee(id: e.id!, contact: {"name": e.name}))
        .toList();

    var employeeNames = this.employeesDetail.map((e) => e.name).toList();
    var employeeNameJoin = employeeNames.join(", ");
    employeeSubject.add(employeeNameJoin);
  }

  void setEmployees(List<Employee> employees) {
    this.employeesDetail = employees
        .map((e) => EmployeeDetail(id: e.id, name: e.contact?["name"]))
        .toList();
    this.employees = employees;

    var employeeNames = this.employeesDetail.map((e) => e.name).toList();
    var employeeNameJoin = employeeNames.join(", ");
    employeeSubject.add(employeeNameJoin);
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    commentSubject.drain();
    commentSubject.close();

    startDateSubject.drain();
    startDateSubject.close();

    endDateSubject.drain();
    endDateSubject.close();

    employeeSubject.drain();
    employeeSubject.close();

    super.dispose();
  }
}
