import 'package:mou_business_app/ui/base/base_viewmodel.dart';

class RangeDatePickerDialogViewModel extends BaseViewModel {
  RangeDatePickerDialogViewModel();

  int? startDay, startMonth, startYear, endDay, endMonth, endYear;
  bool isUseDate = false;

  void initData({
    int? startDay,
    int? startMonth,
    int? startYear,
    int? endDay,
    int? endMonth,
    int? endYear,
  }) {
    this.startDay = startDay == 0 ? DateTime.now().day : startDay;
    this.startMonth = startMonth == 0 ? DateTime.now().month : startMonth;
    this.startYear = startYear == 0 ? DateTime.now().year : startYear;

    this.endDay = endDay;
    this.endMonth = endMonth;
    this.endYear = endYear;
  }

  void setIsUse(bool isUse) {
    this.isUseDate = isUse;
  }

  void setStartDay(int day) {
    this.startDay = day;
  }

  void setStartMonth(int month) {
    this.startMonth = month;
  }

  void setStartYear(int year) {
    this.startYear = year;
  }

  void setEndDay(int day) {
    this.endDay = day;
  }

  void setEndMonth(int month) {
    this.endMonth = month;
  }

  void setEndYear(int year) {
    this.endYear = year;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
