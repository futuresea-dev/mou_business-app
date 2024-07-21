import 'package:date_utilities/date_utilities.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class RangeDatePickerViewModel extends BaseViewModel {
  RangeDatePickerViewModel();

  var daysSubject = BehaviorSubject<List<int>>();
  var isEnableEndDate = BehaviorSubject<bool>();

  FixedExtentScrollController? dayController;

  late int day, month, year;
  List<int> days = <int>[];
  List<int> months = <int>[];
  List<int> years = <int>[];

  void initData({
    required int day,
    required int month,
    required int year,
  }) {
    DateTime now = DateTime.now();
    this.day = day == 0 ? now.day : day;
    this.month = month == 0 ? now.month : month;
    this.year = year == 0 ? now.year : year;
    isEnableEndDate.add(day != 0 && month != 0 && year != 0);

    this.addDays();
    this.addMonth();
    this.addYear();

    dayController = FixedExtentScrollController(initialItem: this.day - 1);
  }

  void addDays() {
    var dateUtility = DateUtilities();
    int? daysInMonth = dateUtility.daysInMonth(month, year);
    for (int i = 1; i <= (daysInMonth ?? 0); i++) {
      days.add(i);
    }
    daysSubject.add(days);
  }

  void addMonth() {
    for (int i = 1; i <= 12; i++) {
      months.add(i);
    }
  }

  void addYear() {
    for (int i = 0; i <= 5; i++) {
      years.add(DateTime.now().year + i);
    }
  }

  int getIndexYearOfList() {
    return years.indexOf(this.year);
  }

  void setDay(int day) {
    this.day = day;
  }

  void setMonth(int month) {
    this.month = month;
  }

  void setYear(int year) {
    this.year = year;
  }

  void changeMonths() {
    var dateUtility = DateUtilities();
    int? daysInMonth = dateUtility.daysInMonth(month, year);

    //Kiểm tra nếu số ngày tháng trước đó lớn hơn số ngày tháng được chọn
    //thì reset lại về ngày 1
    if (days.length > (daysInMonth ?? 0)) {
      if (day > (daysInMonth ?? 0)) {
        day = 1;
        dayController?.animateToItem(
          day - 1,
          duration: Duration(microseconds: 20),
          curve: Curves.bounceIn,
        );
      }
    }
    days.clear();
    daysSubject.add(days);
    for (int i = 1; i <= (daysInMonth ?? 0); i++) {
      days.add(i);
    }

    daysSubject.add(days);
  }

  @override
  void dispose() async {
    await isEnableEndDate.drain();
    isEnableEndDate.close();
    await daysSubject.drain();
    daysSubject.close();
    super.dispose();
  }
}
