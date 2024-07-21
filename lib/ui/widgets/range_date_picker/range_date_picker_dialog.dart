import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/range_date_picker/range_date/range_date_picker.dart';
import 'package:mou_business_app/ui/widgets/range_date_picker/range_date_picker_dialog_viewmodel.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class RangeDatePickerDialog extends StatelessWidget {
  final double? height;
  final int? startDay;
  final int? startMonth;
  final int? startYear;
  final int? endDay;
  final int? endMonth;
  final int? endYear;
  final Function(
    int startDay,
    int startMonth,
    int startYear,
    int endDay,
    int endMonth,
    int endYear,
  ) onCallBack;

  RangeDatePickerDialog({
    this.height = 150,
    this.startDay = 0,
    this.startMonth = 0,
    this.startYear = 0,
    this.endDay = 0,
    this.endMonth = 0,
    this.endYear = 0,
    required this.onCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RangeDatePickerDialogViewModel>(
      viewModel: RangeDatePickerDialogViewModel(),
      onViewModelReady: (viewModel) => viewModel.initData(
        startDay: startDay,
        startMonth: startMonth,
        startYear: startYear,
        endDay: endDay,
        endMonth: endMonth,
        endYear: endYear,
      ),
      builder: (context, viewModel, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RangeDatePicker(
              (height ?? 1) / 2,
              allTranslations.text(AppLanguages.start),
              true,
              startDay ?? 0,
              startMonth ?? 0,
              startYear ?? 0,
              (day, month, year) {
                viewModel.setStartDay(day);
                viewModel.setStartMonth(month);
                viewModel.setStartYear(year);
                onCallBack(
                  viewModel.startDay ?? 0,
                  viewModel.startMonth ?? 0,
                  viewModel.startYear ?? 0,
                  viewModel.endDay ?? 0,
                  viewModel.endMonth ?? 0,
                  viewModel.endYear ?? 0,
                );
              },
            ),
            const SizedBox(height: 12),
            RangeDatePicker(
              (height ?? 0) / 2,
              allTranslations.text(AppLanguages.end),
              false,
              endDay ?? 0,
              endMonth ?? 0,
              endYear ?? 0,
              (day, month, year) {
                viewModel.setEndDay(day);
                viewModel.setEndMonth(month);
                viewModel.setEndYear(year);
                onCallBack(
                  viewModel.startDay ?? 0,
                  viewModel.startMonth ?? 0,
                  viewModel.startYear ?? 0,
                  viewModel.endDay ?? 0,
                  viewModel.endMonth ?? 0,
                  viewModel.endYear ?? 0,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
