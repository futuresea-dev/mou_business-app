import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/range_date_picker/range_date/range_date_picker_viewmodel.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class RangeDatePicker extends StatelessWidget {
  final double height;
  final String title;
  final bool isStartDate;
  final int day;
  final int month;
  final int year;
  final Function(int day, int month, int year)? onCallBack;

  RangeDatePicker(
    this.height,
    this.title,
    this.isStartDate,
    this.day,
    this.month,
    this.year,
    this.onCallBack,
  );

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RangeDatePickerViewModel>(
      viewModel: RangeDatePickerViewModel(),
      onViewModelReady: (viewModel) => viewModel
        ..initData(
          day: day,
          month: month,
          year: year,
        ),
      builder: (context, viewModel, child) => StreamBuilder<bool>(
        stream: viewModel.isEnableEndDate,
        builder: (context, snapshot) {
          bool isEnabled = snapshot.data ?? true;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isStartDate)
                Container(
                  height: 30,
                  padding: const EdgeInsets.only(left: 7),
                  child: IconButton(
                    onPressed: () {
                      onCallBack?.call(
                        isEnabled ? 0 : viewModel.day,
                        isEnabled ? 0 : viewModel.month,
                        isEnabled ? 0 : viewModel.year,
                      );
                      viewModel.isEnableEndDate.add(!isEnabled);
                    },
                    icon: Transform.scale(
                      scale: isEnabled ? 1.1 : 1,
                      child: Transform.rotate(
                        angle: isEnabled ? 0 : 45 * 3.141592653589793 / 180,
                        child: Image.asset(AppImages.icClose),
                      ),
                    ),
                  ),
                ),
              IgnorePointer(
                ignoring: !isEnabled,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildDay(context, viewModel, isEnabled),
                    const SizedBox(width: 15),
                    _buildMonth(context, viewModel, isEnabled),
                    const SizedBox(width: 15),
                    _buildYear(context, viewModel, isEnabled)
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDay(BuildContext context, RangeDatePickerViewModel viewModel,
      bool isEnabled) {
    return Column(
      children: <Widget>[
        Text(
          allTranslations.text(AppLanguages.day),
          style: TextStyle(
            fontSize: AppFontSize.textDatePicker,
            color: AppColors.normal,
          ),
        ),
        SizedBox(
          height: height - 60,
          width: 60,
          child: CupertinoPicker(
            scrollController:
                FixedExtentScrollController(initialItem: viewModel.day - 1),
            itemExtent: 30,
            backgroundColor: AppColors.bgColor,
            onSelectedItemChanged: (int index) {
              viewModel.setDay(viewModel.days[index]);
              onCallBack?.call(viewModel.day, viewModel.month, viewModel.year);
            },
            children: List<Widget>.generate(
              viewModel.days.length,
              (int index) {
                return Center(
                  child: Text(
                    "${viewModel.days[index]}",
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: isEnabled
                          ? AppColors.normal
                          : AppColors.textPlaceHolder,
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

  Widget _buildMonth(BuildContext context, RangeDatePickerViewModel viewModel,
      bool isEnabled) {
    return Column(
      children: <Widget>[
        Text(
          allTranslations.text(AppLanguages.month),
          style: TextStyle(
              fontSize: AppFontSize.textDatePicker, color: AppColors.normal),
        ),
        SizedBox(
          height: height - 60,
          width: 60,
          child: CupertinoPicker(
            scrollController:
                FixedExtentScrollController(initialItem: viewModel.month - 1),
            itemExtent: 30,
            backgroundColor: AppColors.bgColor,
            onSelectedItemChanged: (int index) {
              viewModel.setMonth(viewModel.months[index]);
              viewModel.changeMonths();
              onCallBack?.call(viewModel.day, viewModel.month, viewModel.year);
            },
            children: List<Widget>.generate(
              viewModel.months.length,
              (int index) {
                return Center(
                  child: Text(
                    "${viewModel.months[index]}",
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: isEnabled
                          ? AppColors.normal
                          : AppColors.textPlaceHolder,
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

  Widget _buildYear(BuildContext context, RangeDatePickerViewModel viewModel,
      bool isEnabled) {
    return Column(
      children: <Widget>[
        Text(
          allTranslations.text(AppLanguages.year),
          style: TextStyle(
            fontSize: AppFontSize.textDatePicker,
            color: AppColors.normal,
          ),
        ),
        SizedBox(
          height: height - 60,
          width: 60,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem:
                  viewModel.year == 0 ? 0 : viewModel.getIndexYearOfList(),
            ),
            itemExtent: 30,
            backgroundColor: AppColors.bgColor,
            onSelectedItemChanged: (int index) {
              viewModel.setYear(viewModel.years[index]);
              onCallBack?.call(viewModel.day, viewModel.month, viewModel.year);
            },
            children:
                List<Widget>.generate(viewModel.years.length, (int index) {
              return Center(
                child: Text(
                  "${viewModel.years[index]}",
                  style: TextStyle(
                    fontSize: AppFontSize.textDatePicker,
                    color: isEnabled
                        ? AppColors.normal
                        : AppColors.textPlaceHolder,
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
