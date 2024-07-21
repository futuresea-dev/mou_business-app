import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/core/models/employee.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:rxdart/rxdart.dart';

class AddChildTaskViewModel extends BaseViewModel {
  final EmployeeDao employeeDao;

  AddChildTaskViewModel({required this.employeeDao});

  var commentController = TextEditingController();
  var commentFocusNode = FocusNode();

  final titleController = TextEditingController();
  final titleFocusNode = FocusNode();

  final employeeSubject = BehaviorSubject<String>();
  final startDateHourSubject = BehaviorSubject<String>();
  final endDateHourSubject = BehaviorSubject<String>();

  DateTime? startDateHour;
  DateTime? endDateHour;

  List<EmployeeDetail>? employeesDetail;
  List<Employee>? employees;

  void initData(Task? task) {
    if (task != null) {
      // field Title
      titleController.text = task.title;

      // field Start date - End date
      DateTime startDate = DateTime.parse(task.startDate ?? "");
      DateTime? endDate = DateTime.tryParse(task.endDate ?? "");
      setDate(startDate.day, startDate.month, startDate.year, endDate?.day ?? 0,
          endDate?.month ?? 0, endDate?.year ?? 0);

      // field Description
      commentController.text = task.comment ?? "";

      // field Tag someone
      setEmployeeDetails(
          task.employees?.map((e) => e as EmployeeDetail).toList() ?? <EmployeeDetail>[]);
    }
  }

  void setDate(
    int startDay,
    int startMonth,
    int startYear,
    int endDay,
    int endMonth,
    int endYear,
  ) {
    startDateHour = DateTime(startYear, startMonth, startDay);

    String startDateHourString =
        DateFormat(AppConstants.dateFormat).format(startDateHour ?? DateTime.now()).toString();

    startDateHourSubject.add(startDateHourString);
    if (endDay == 0 ||
        endMonth == 0 ||
        endYear == 0 ||
        (startDay == endDay && startMonth == endMonth && startYear == endYear)) {
      endDateHour = null;
      endDateHourSubject.add("");
    } else {
      endDateHour = DateTime(endYear, endMonth, endDay);
      String endDateHourString =
          DateFormat(AppConstants.dateFormat).format(endDateHour ?? DateTime.now()).toString();

      endDateHourSubject.add(endDateHourString);
    }
  }

  void setEmployeeDetails(List<EmployeeDetail> employees) {
    this.employeesDetail = employees;
    this.employees = this
        .employeesDetail
        ?.map((e) => Employee(id: e.id ?? 0, contact: {"name": e.name}))
        .toList();
    if (this.employeesDetail != null) {
      var employeeNames = this.employeesDetail?.map((e) => e.name).toList();
      var employeeNameJoin = employeeNames?.join(", ");
      employeeSubject.add(employeeNameJoin ?? "");
    }
  }

  void setEmployees(List<Employee> employees) {
    this.employeesDetail =
        employees.map((e) => EmployeeDetail(id: e.id, name: e.contact?["name"])).toList();
    this.employees = employees;
    if (this.employeesDetail != null) {
      var employeeNames = this.employeesDetail?.map((e) => e.name).toList();
      var employeeNameJoin = employeeNames?.join(", ");
      employeeSubject.add(employeeNameJoin ?? "");
    }
  }

  bool get validate {
    DateTime dateNow = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime statTimeShort =
        DateTime(startDateHour?.year ?? 0, startDateHour?.month ?? 0, startDateHour?.day ?? 0);
    if (titleController.text.trim().isEmpty) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputTitle));
      return false;
    } else if (employeesDetail?.isEmpty ?? true) {
      showSnackBar(allTranslations.text(AppLanguages.validateAddTagSomeone));
      return false;
    } else if (startDateHourSubject.valueOrNull == null ||
        (startDateHourSubject.valueOrNull != null &&
            startDateHourSubject.valueOrNull != null &&
            startDateHourSubject.valueOrNull.toString().isEmpty)) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputStartDate));
      return false;
    } else if (startDateHourSubject.value != "" &&
        endDateHourSubject.value != "" &&
        (startDateHour!.compareTo(endDateHour ?? DateTime.now()) >= 0)) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputStartDateSmallerEndDate));
      return false;
    } else if (statTimeShort.difference(dateNow).inDays < 0) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputStartDateGreaterEqualCurrentDate));
      return false;
    }
    return true;
  }

  Task getTask(Task? task) {
    DateFormat dateFormat = DateFormat(AppConstants.dateFormatUpload);
    return Task(
      id: task?.id ?? 0,
      startDate: dateFormat.format(startDateHour ?? DateTime.now()),
      endDate: endDateHour != null ? dateFormat.format(endDateHour ?? DateTime.now()) : null ?? "",
      comment: commentController.text,
      employees: employeesDetail ?? [],
      title: titleController.text,
    );
  }

  void clearData() {
    titleController.clear();
    startDateHourSubject.add('');
    startDateHour = null;
    endDateHourSubject.add('');
    endDateHour = null;
    commentController.clear();
    employeeSubject.add('');
    employeesDetail = [];
    employees = [];
  }

  @override
  void dispose() async {
    await startDateHourSubject.drain();
    startDateHourSubject.close();

    await endDateHourSubject.drain();
    endDateHourSubject.close();

    await employeeSubject.drain();
    employeeSubject.close();

    super.dispose();
  }
}
