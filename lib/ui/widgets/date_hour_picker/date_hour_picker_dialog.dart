import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/date_hour_picker/date_hour/date_hour_picker.dart';
import 'package:mou_business_app/ui/widgets/date_hour_picker/date_hour_picker_dialog_viewmodel.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class DateHourPickerDialog extends StatelessWidget {
  final double height;
  final int startHour;
  final int startMinute;
  final int startDay;
  final int startMonth;
  final int startYear;
  final int endHour;
  final int endMinute;
  final int endDay;
  final int endMonth;
  final int endYear;
  final Function(int startHour, int startMinute, int startDay, int startMonth, int startYear,
      int endHour, int endMinute, int endDay, int endMonth, int endYear, bool isUse)? onCallBack;

  DateHourPickerDialog({
    this.height = 150,
    this.startHour = 0,
    this.startMinute = 0,
    this.startDay = 0,
    this.startMonth = 0,
    this.startYear = 0,
    this.endHour = 0,
    this.endMinute = 0,
    this.endDay = 0,
    this.endMonth = 0,
    this.endYear = 0,
    this.onCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DateHourPickerDialogViewModel>(
      viewModel: DateHourPickerDialogViewModel(),
      onViewModelReady: (viewModel) => viewModel
        ..initData(
          startHour: this.startHour,
          startMinute: this.startMinute,
          startDay: this.startDay,
          startMonth: this.startMonth,
          startYear: this.startYear,
          endHour: this.endHour,
          endMinute: this.endMinute,
          endDay: this.endDay,
          endMonth: this.endMonth,
          endYear: this.endYear,
        ),
      builder: (context, viewModel, child) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DateHourPicker(
                this.height / 2,
                allTranslations.text(AppLanguages.start),
                true,
                this.startHour,
                this.startMinute,
                this.startDay,
                this.startMonth,
                this.startYear, (hour, minute, day, month, year, isUse) {
              viewModel.setStartHour(hour);
              viewModel.setStartMinute(minute);
              viewModel.setStartDay(day);
              viewModel.setStartMonth(month);
              viewModel.setStartYear(year);
              onCallBack!(
                viewModel.startHour ?? 0,
                viewModel.startMinute ?? 0,
                viewModel.startDay ?? 0,
                viewModel.startMonth ?? 0,
                viewModel.startYear ?? 0,
                viewModel.endHour ?? 0,
                viewModel.endMinute ?? 0,
                viewModel.endDay ?? 0,
                viewModel.endMonth ?? 0,
                viewModel.endYear ?? 0,
                viewModel.isUseDate,
              );
            }),
            const SizedBox(height: 12),
            DateHourPicker(
              this.height / 2,
              allTranslations.text(AppLanguages.end),
              false,
              this.endHour,
              this.endMinute,
              this.endDay,
              this.endMonth,
              this.endYear,
              (hour, minute, day, month, year, isUse) {
                viewModel.setEndHour(hour);
                viewModel.setEndMinute(minute);
                viewModel.setEndDay(day);
                viewModel.setEndMonth(month);
                viewModel.setEndYear(year);
                viewModel.setIsUse(isUse);
                onCallBack!(
                  viewModel.startHour ?? 0,
                  viewModel.startMinute ?? 0,
                  viewModel.startDay ?? 0,
                  viewModel.startMonth ?? 0,
                  viewModel.startYear ?? 0,
                  viewModel.endHour ?? 0,
                  viewModel.endMinute ?? 0,
                  viewModel.endDay ?? 0,
                  viewModel.endMonth ?? 0,
                  viewModel.endYear ?? 0,
                  viewModel.isUseDate,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
