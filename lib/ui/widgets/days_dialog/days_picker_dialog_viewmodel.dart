import 'package:mou_business_app/core/models/day_in_week.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class DaysPickerDialogViewModel extends BaseViewModel {
  List<DayInWeek>? daysInWeek;
  List<DayInWeek> daysInWeekSelected;

  final isChangedSubject = BehaviorSubject<bool>();

  DaysPickerDialogViewModel({required this.daysInWeekSelected});

  void initData() {
    daysInWeek = dayInWeekData;
  }

  bool checkExist(DayInWeek item) {
    if (daysInWeekSelected.isNotEmpty) {
      return daysInWeekSelected
              .indexWhere((dayInWeek) => dayInWeek.id == item.id) !=
          -1;
    }
    return false;
  }

  void setDaysInWeekSelected(DayInWeek? item) {
    if (item != null) {
      if (daysInWeekSelected.isNotEmpty) {
        var isExist = daysInWeekSelected
                .indexWhere((dayInWeek) => dayInWeek.id == item.id) !=
            -1;
        if (isExist) {
          daysInWeekSelected
              .removeWhere((dayInWeek) => dayInWeek.id == item.id);
        } else {
          daysInWeekSelected.add(item);
        }
      } else {
        daysInWeekSelected = <DayInWeek>[];
        daysInWeekSelected.add(item);
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
