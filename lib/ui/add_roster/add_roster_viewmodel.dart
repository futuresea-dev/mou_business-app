import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/models/employee.dart';
import 'package:mou_business_app/core/models/employee_model.dart';
import 'package:mou_business_app/core/repositories/roster_repository.dart';
import 'package:mou_business_app/core/requests/add_or_update_roster_request.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:rxdart/rxdart.dart';

class AddRosterViewModel extends BaseViewModel {
  final RosterRepository repository;

  AddRosterViewModel(this.repository);

  final employeeSubject = BehaviorSubject<String>();
  final startDateHourSubject = BehaviorSubject<String>();
  final endDateHourSubject = BehaviorSubject<String>();
  final shopSubject = BehaviorSubject<Shop?>();

  final isTypingTagSomeOne = BehaviorSubject<bool?>();
  final isTypingDate = BehaviorSubject<bool?>();

  DateTime? startDateHour;
  DateTime? endDateHour;
  bool isUseEndDate = false;

  Roster? _roster;
  final ValueNotifier<int> totalDeny = ValueNotifier(0);
  EmployeeDetail? employeeDetail;
  Employee? employee;

  void init(int? rosterId) async {
    if (rosterId != null) {
      final response = await repository.getRosterDetail(rosterId);
      if (response.isSuccess) {
        _roster = response.data;
      } else {
        showSnackBar(response.message ?? '');
      }
    }
    if (_roster != null) {
      totalDeny.value = _roster!.totalDeny ?? 0;
      final employeeJson = _roster!.employee;
      if (employeeJson != null) {
        EmployeeModel employee = EmployeeModel.fromJson(employeeJson);
        employeeSubject.add(employee.employeeName);
        employeeDetail = EmployeeDetail(
          id: employee.id,
          name: employee.employeeName,
        );
        isTypingTagSomeOne.add(true);
      }
      isTypingDate.add(_roster!.startTime.isNotEmpty);
      shopSubject.add(_roster!.store != null ? Shop.fromJson(_roster!.store!) : null);
      startDateHourSubject.add(AppUtils.convertDateTime(
        _roster!.startTime,
        format: 'dd/MM/yyyy HH:mm',
      ));

      startDateHour = AppUtils.convertStringToDateTime(_roster!.startTime);
      endDateHourSubject.add(
        AppUtils.convertDateTime(
          _roster!.endTime,
          format: 'dd/MM/yyyy HH:mm',
        ),
      );
      endDateHour = AppUtils.convertStringToDateTime(_roster!.endTime);
    }
  }

  void setDate(
    int startDay,
    int startMonth,
    int startYear,
    int endDay,
    int endMonth,
    int endYear,
    int startHour,
    int startMinute,
    int endHour,
    int endMinute,
  ) {
    DateTime startDateHour = DateTime(startYear, startMonth, startDay, startHour, startMinute);
    DateTime endDateHour = DateTime(endYear, endMonth, endDay, endHour, endMinute);

    var startDateHourString =
        DateFormat(AppConstants.dateHourFormatAddProject).format(startDateHour).toString();
    var endDateHourString =
        DateFormat(AppConstants.dateHourFormatAddProject).format(endDateHour).toString();

    startDateHourSubject.add('$startDateHourString');
    endDateHourSubject.add('$endDateHourString');

    request.startTime =
        DateFormat(AppConstants.dateHourFormatAddProject).format(startDateHour).toString();
    request.endTime =
        DateFormat(AppConstants.dateHourFormatAddProject).format(endDateHour).toString();
  }

  void setDateHour(int startHour, int startMinute, int startDay, int startMonth, int startYear,
      int endHour, int endMinute, int endDay, int endMonth, int endYear, bool isUseEndDate) {
    isUseEndDate = isUseEndDate;
    startDateHour = DateTime(startYear, startMonth, startDay, startHour, startMinute);
    endDateHour = DateTime(endYear, endMonth, endDay, endHour, endMinute);

    var startDateHourString =
        DateFormat(AppConstants.dateFormat).format(startDateHour ?? DateTime.now()).toString();
    var endDateHourString =
        DateFormat(AppConstants.dateFormat).format(endDateHour ?? DateTime.now()).toString();
    var startHourMinute = DateFormat(AppConstants.hourMinuteFormat)
        .format(startDateHour ?? DateTime.now())
        .toString();
    var endHourMinute =
        DateFormat(AppConstants.hourMinuteFormat).format(endDateHour ?? DateTime.now()).toString();

    if (!isUseEndDate) {
      startDateHourSubject.add('$startDateHourString $startHourMinute');
      endDateHour = null;
      endDateHourSubject.add('');
    } else {
      if (startDay == endDay && startMonth == endMonth && startYear == endYear) {
        print('$endHourMinute');
        startDateHourSubject.add('$startDateHourString $startHourMinute - $endHourMinute');
        endDateHourSubject.add('');
      } else {
        startDateHourSubject.add('$startDateHourString $startHourMinute');
        endDateHourSubject.add('$endDateHourString $endHourMinute');
      }
    }
  }

  void setEmployee(List<Employee> employees) {
    if (employees.isNotEmpty) {
      Employee e = employees.first;
      employeeDetail = EmployeeDetail(id: e.id, name: e.contact?['name']);
      employee = e;
      employeeSubject.add(employeeDetail?.name ?? '');
    }
  }

  bool get validate {
    if (employeeDetail == null) {
      showSnackBar(allTranslations.text(AppLanguages.validateAddTagSomeone));
      return false;
    } else if (startDateHourSubject.valueOrNull == null ||
        (startDateHourSubject.valueOrNull != null &&
            startDateHourSubject.valueOrNull.toString().isEmpty)) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputStartDate));
      return false;
    } else if (startDateHour != null &&
        endDateHour != null &&
        startDateHour!.isAfter(endDateHour!)) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputStartDateSmallerEndDate));
      return false;
    } else if (startDateHour != null && startDateHour!.isBefore(DateTime.now())) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputStartDateGreaterCurrentDate));
      return false;
    } else if (shopSubject.valueOrNull == null) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputStore));
      return false;
    }
    return true;
  }

  void updateShopSelected(Shop? shop) => shopSubject.add(shop);

  @override
  void dispose() {
    startDateHourSubject.drain();
    startDateHourSubject.close();

    endDateHourSubject.drain();
    endDateHourSubject.close();

    employeeSubject.drain();
    employeeSubject.close();

    totalDeny.dispose();

    super.dispose();
  }

  AddOrUpdateRosterRequest request = AddOrUpdateRosterRequest();

  void addRoster() {
    FocusScope.of(context).unfocus();
    if (validate) {
      request.companyEmployeeId = employeeDetail?.id;
      request.startTime = DateFormat(AppConstants.dateHourFormatAddRoster)
          .format(startDateHour ?? DateTime.now())
          .toString();
      request.endTime = DateFormat(AppConstants.dateHourFormatAddRoster)
          .format(endDateHour ?? DateTime.now())
          .toString();
      request.storeId = shopSubject.valueOrNull?.id;

      setLoading(true);
      (_roster != null
              ? repository.updateRoster(_roster!.id, request)
              : repository.addRoster(request))
          .then((resource) {
        if (resource.isSuccess) {
          Navigator.pop(context);
          showSnackBar(
              allTranslations.text(_roster != null
                  ? AppLanguages.rosterUpdatedSuccessfully
                  : AppLanguages.rosterAddedSuccessfully),
              isError: false);
        } else {
          showSnackBar(resource.message ?? '');
        }
        setLoading(false);
      }).catchError((Object error) {
        setLoading(false);
        showSnackBar(error.toString());
      });
    }
  }
}
