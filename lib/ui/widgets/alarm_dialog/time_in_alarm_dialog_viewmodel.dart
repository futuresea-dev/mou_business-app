import 'package:mou_business_app/core/models/time_in_alarm.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class TimeInAlarmDialogViewModel extends BaseViewModel {
  List<TimeInAlarm> timeInAlarmsSelected;
  List<TimeInAlarm>? timeInAlarms;

  final isChangedSubject = BehaviorSubject<bool>();

  TimeInAlarmDialogViewModel({required this.timeInAlarmsSelected});

  void initData() {
    timeInAlarms = timeInAlarmData;
  }

  bool checkExist(TimeInAlarm item) {
    if (timeInAlarmsSelected.isNotEmpty) {
      return timeInAlarmsSelected
              .indexWhere((timeInAlarm) => timeInAlarm.value == item.value) !=
          -1;
    }
    return false;
  }

  void setDaysInWeekSelected(TimeInAlarm? item) {
    if (item != null) {
      if (timeInAlarmsSelected.isNotEmpty) {
        var isExist = timeInAlarmsSelected
                .indexWhere((dayInWeek) => dayInWeek.value == item.value) !=
            -1;
        if (isExist) {
          timeInAlarmsSelected
              .removeWhere((dayInWeek) => dayInWeek.value == item.value);
        } else {
          timeInAlarmsSelected.add(item);
        }
      } else {
        timeInAlarmsSelected = <TimeInAlarm>[];
        timeInAlarmsSelected.add(item);
      }
      isChangedSubject.add(true);
    }
  }

  @override
  void dispose() {
    isChangedSubject.drain();
    isChangedSubject.close();
    super.dispose();
  }
}
