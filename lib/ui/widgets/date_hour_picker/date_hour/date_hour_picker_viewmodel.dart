import 'package:date_utilities/date_utilities.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class DateHourPickerViewModel extends BaseViewModel {
  DateHourPickerViewModel();

  BehaviorSubject<List<int>> daysSubject = BehaviorSubject<List<int>>();

  Stream<List<int>> get daysStream => daysSubject.stream;

  Sink<List<int>> get daysSink => daysSubject.sink;

  FixedExtentScrollController? dayController;

  late int hour, minute, day, month, year;
  bool isUse = true;
  List<int> hours = <int>[];
  List<int> minutes = <int>[];
  List<int> days = <int>[];
  List<int> months = <int>[];
  List<int> years = <int>[];

  void initData({
    required int hour,
    required int minute,
    required int day,
    required int month,
    required int year,
  }) {
    DateTime now = DateTime.now();
    this.hour = hour == 0 ? now.hour : hour;
    this.minute = minute == 0 ? now.minute : minute;
    this.day = day == 0 ? now.day : day;
    this.month = month == 0 ? now.month : month;
    this.year = year == 0 ? now.year : year;

    this.addHours();
    this.addMinutes();
    this.addDays();
    this.addMonth();
    this.addYear();

    dayController = FixedExtentScrollController(initialItem: this.day - 1);
  }

  void setIsUse() {
    this.isUse = !this.isUse;
  }

  void addHours() {
    for (int i = 0; i <= 23; i++) {
      hours.add(i);
    }
  }

  void addMinutes() {
    for (int i = 0; i <= 59; i++) {
      minutes.add(i);
    }
  }

  void addDays() {
    var dateUtility = DateUtilities();
    int? daysInMonth = dateUtility.daysInMonth(month, year);
    for (int i = 1; i <= (daysInMonth ?? 0); i++) {
      days.add(i);
    }
    daysSink.add(days);
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

  void setHour(int hour) {
    this.hour = hour;
    this.isUse = true;
  }

  void setMinute(int minute) {
    this.minute = minute;
    this.isUse = true;
  }

  void setDay(int day) {
    this.day = day;
    this.isUse = true;
  }

  void setMonth(int month) {
    this.month = month;
    this.isUse = true;
  }

  void setYear(int year) {
    this.year = year;
    this.isUse = true;
  }

  void changeMonths() {
    var dateUtility = DateUtilities();
    int daysInMonth = dateUtility.daysInMonth(month, year) ?? 1;

    //Kiểm tra nếu số ngày tháng trước đó lớn hơn số ngày tháng được chọn
    //thì reset lại về ngày 1
    if (days.length > daysInMonth) {
      if (day > daysInMonth) {
        day = 1;
        dayController?.animateToItem(
          day - 1,
          duration: Duration(microseconds: 20),
          curve: Curves.bounceIn,
        );
      }
    }
    days.clear();
    daysSink.add(days);
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(i);
    }
    daysSink.add(days);
  }

  @override
  void dispose() {
    daysSubject.drain();
    daysSubject.close();

    super.dispose();
  }
}
