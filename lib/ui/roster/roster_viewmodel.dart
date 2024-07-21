import 'package:flutter/cupertino.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/models/employee_model.dart';
import 'package:mou_business_app/core/models/list_response.dart';
import 'package:mou_business_app/core/repositories/roster_repository.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/loadmore_viewmodel.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:rxdart/rxdart.dart';

class RosterViewModel extends LoadMoreViewModel<Roster> {
  final RosterRepository rosterRepository;

  RosterViewModel(this.rosterRepository);

  final focusedDaySubject = BehaviorSubject<DateTime>();
  final rostersSubject = BehaviorSubject<Map<DateTime, List<dynamic>>>();

  @override
  Future<Resource<ListResponse>> onSyncResource(int page) {
    return rosterRepository.getListRosters(
      AppUtils.convertDayToString(
        focusedDaySubject.value,
        format: AppConstants.dateFormatUpload,
      ),
      page,
    );
  }

  @override
  Future<void> onRefresh() {
    final selected = AppUtils.clearTime(focusedDaySubject.valueOrNull);
    if (selected != null) {
      final weekDay = selected.weekday % 7;
      _fetchRosters(
        selected.subtract(Duration(days: weekDay)),
        selected.add(Duration(days: 6 - weekDay)),
      );
    }
    return super.onRefresh();
  }

  void init(DateTime? selectedDay) {
    focusedDaySubject.add(selectedDay ?? DateTime.now());
    this.onRefresh();
    this.onSyncResource(1);
  }

  Future<void> _fetchRosters(DateTime fromDate, DateTime toDate) async {
    final resource =
        await rosterRepository.checkRosterDateOfMonth(fromDate, toDate);
    final rosterChecks = resource.data ?? {};
    Map<DateTime, List<dynamic>> rosters = {};
    rosterChecks
        .forEach((key, value) => rosters[DateTime.parse(key)] = [value]);
    rostersSubject.add(rosters);
  }

  void onBackPressed() {
    Navigator.popUntil(context, (router) => router.isFirst);
    Navigator.pushNamed(
      context,
      Routers.MONTH_CALENDAR,
      arguments: focusedDaySubject.valueOrNull,
    );
  }

  EmployeeModel? checkEmployee(Roster roster) {
    EmployeeModel? employee;
    if (roster.employee != null) {
      employee = EmployeeModel.fromJson(roster.employee!);
    }
    return employee;
  }

  void onDaySelected(DateTime day) {
    rosterRepository.cancel();
    focusedDaySubject.add(day);
    this.onRefresh();
  }

  void onEditRoster(int rosterId) {
    Navigator.pushNamed(
      context,
      Routers.ADD_ROSTER,
      arguments: rosterId,
    );
  }

  void onDeleteRoster(int rosterId) async {
    setLoading(true);
    rosterRepository.deleteRoster(rosterId).then((value) {
      if (value.isSuccess) {
        showSnackBar(
          allTranslations.text(AppLanguages.rosterDeletedSuccessfully),
          isError: false,
        );
      } else {
        showSnackBar(value.message ?? "");
      }
      setLoading(false);
    }).catchError((Object error) {
      setLoading(false);
      showSnackBar(error.toString());
    });
  }

  @override
  void dispose() async {
    rosterRepository.cancel();
    await focusedDaySubject.drain();
    focusedDaySubject.close();
    await rostersSubject.drain();
    rostersSubject.close();
    super.dispose();
  }
}
