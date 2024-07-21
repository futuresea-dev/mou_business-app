import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/date_hour_picker/date_hour/date_hour_picker_viewmodel.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class DateHourPicker extends StatelessWidget {
  final double height;
  final String title;
  final bool isFirst;
  final int hour;
  final int minute;
  final int day;
  final int month;
  final int year;
  final Function(int hour, int minute, int day, int month, int year, bool isUse)? onCallBack;

  DateHourPicker(
    this.height,
    this.title,
    this.isFirst,
    this.hour,
    this.minute,
    this.day,
    this.month,
    this.year,
    this.onCallBack,
  );

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DateHourPickerViewModel>(
      viewModel: DateHourPickerViewModel(),
      onViewModelReady: (viewModel) => viewModel.initData(
        hour: hour,
        minute: minute,
        day: day,
        month: month,
        year: year,
      ),
      builder: (context, viewModel, child) => Container(
        alignment: Alignment.center,
        height: height,
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildDay(context, viewModel),
            _buildMonth(context, viewModel),
            _buildYear(context, viewModel),
            _buildHour(context, viewModel),
            _buildMinute(context, viewModel)
          ],
        ),
      ),
    );
  }

  Widget _buildHour(BuildContext context, DateHourPickerViewModel viewModel) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        Container(
          alignment: Alignment.bottomCenter,
          height: 30,
          child: Text(
            allTranslations.text(AppLanguages.hour),
            style: TextStyle(
              fontSize: AppFontSize.textDatePicker,
              color: AppColors.normal,
            ),
          ),
        ),
        SizedBox(
          height: height - 60,
          width: 60,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: viewModel.hour),
            itemExtent: 30,
            backgroundColor: Colors.transparent,
            onSelectedItemChanged: (int index) {
              viewModel.setHour(viewModel.hours[index]);
              onCallBack?.call(
                viewModel.hour,
                viewModel.minute,
                viewModel.day,
                viewModel.month,
                viewModel.year,
                viewModel.isUse,
              );
            },
            children: List<Widget>.generate(
              viewModel.hours.length,
              (int index) {
                return Center(
                  child: Text(
                    "${viewModel.hours[index]}",
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: AppColors.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMinute(BuildContext context, DateHourPickerViewModel viewModel) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        Container(
          alignment: Alignment.bottomCenter,
          height: 30,
          child: Text(
            allTranslations.text(AppLanguages.minute),
            style: TextStyle(fontSize: AppFontSize.textDatePicker, color: AppColors.normal),
          ),
        ),
        SizedBox(
          height: height - 60,
          width: 60,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: viewModel.minute),
            itemExtent: 30,
            backgroundColor: Colors.transparent,
            onSelectedItemChanged: (int index) {
              viewModel.setMinute(viewModel.minutes[index]);
              onCallBack?.call(
                viewModel.hour,
                viewModel.minute,
                viewModel.day,
                viewModel.month,
                viewModel.year,
                viewModel.isUse,
              );
            },
            children: List<Widget>.generate(
              viewModel.minutes.length,
              (int index) {
                return Center(
                  child: Text(
                    "${viewModel.minutes[index]}",
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: AppColors.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDay(BuildContext context, DateHourPickerViewModel viewModel) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        Container(
          alignment: Alignment.bottomCenter,
          height: 30,
          child: Text(
            allTranslations.text(AppLanguages.day),
            style: TextStyle(
              fontSize: AppFontSize.textDatePicker,
              color: AppColors.normal,
            ),
          ),
        ),
        StreamBuilder<List<int>>(
          stream: viewModel.daysStream,
          builder: (context, snapShot) {
            List<int> days = snapShot.data ?? viewModel.days;
            return SizedBox(
              height: height - 60,
              width: 60,
              child: CupertinoPicker(
                scrollController: viewModel.dayController,
                itemExtent: 30,
                backgroundColor: Colors.transparent,
                onSelectedItemChanged: (int index) {
                  viewModel.setDay(viewModel.days[index]);
                  onCallBack?.call(
                    viewModel.hour,
                    viewModel.minute,
                    viewModel.days[index],
                    viewModel.month,
                    viewModel.year,
                    viewModel.isUse,
                  );
                },
                children: List<Widget>.generate(
                  days.length,
                  (int index) {
                    return Center(
                      child: Text(
                        "${days[index]}",
                        style: TextStyle(
                          fontSize: AppFontSize.textDatePicker,
                          color: AppColors.normal,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildMonth(BuildContext context, DateHourPickerViewModel viewModel) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        Container(
          alignment: Alignment.bottomCenter,
          height: 30,
          child: Text(
            allTranslations.text(AppLanguages.month),
            style: TextStyle(
              fontSize: AppFontSize.textDatePicker,
              color: AppColors.normal,
            ),
          ),
        ),
        SizedBox(
          height: height - 60,
          width: 60,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: viewModel.month - 1),
            itemExtent: 30,
            backgroundColor: Colors.transparent,
            onSelectedItemChanged: (int index) {
              viewModel.setMonth(viewModel.months[index]);
              viewModel.changeMonths();
              onCallBack?.call(
                viewModel.hour,
                viewModel.minute,
                viewModel.day,
                viewModel.month,
                viewModel.year,
                viewModel.isUse,
              );
            },
            children: List<Widget>.generate(
              viewModel.months.length,
              (int index) {
                return Center(
                  child: Text(
                    "${viewModel.months[index]}",
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: AppColors.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildYear(BuildContext context, DateHourPickerViewModel viewModel) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomLeft,
          height: 30,
          child: Text(
            title,
            style: TextStyle(
              fontSize: AppFontSize.datePickerValueUnSelect,
              color: AppColors.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          height: 30,
          child: Text(
            allTranslations.text(AppLanguages.year),
            style: TextStyle(
              fontSize: AppFontSize.textDatePicker,
              color: AppColors.normal,
            ),
          ),
        ),
        SizedBox(
          height: height - 60,
          width: 60,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
                initialItem: viewModel.year == 0 ? 0 : viewModel.getIndexYearOfList()),
            itemExtent: 30,
            backgroundColor: Colors.transparent,
            onSelectedItemChanged: (int index) {
              viewModel.setYear(viewModel.years[index]);
              onCallBack?.call(
                viewModel.hour,
                viewModel.minute,
                viewModel.day,
                viewModel.month,
                viewModel.year,
                viewModel.isUse,
              );
            },
            children: List<Widget>.generate(
              viewModel.years.length,
              (int index) {
                return Center(
                  child: Text(
                    "${viewModel.years[index]}",
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: AppColors.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
