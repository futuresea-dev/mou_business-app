import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/day_in_week.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/days_dialog/days_picker_dialog_viewmodel.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';

class DaysPickerDialog extends StatelessWidget {
  final double? height;
  final List<DayInWeek>? itemsSelected;
  final Function(List<DayInWeek> daysInWeek)? onCallBack;

  DaysPickerDialog({this.height, this.itemsSelected, this.onCallBack});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DaysPickerDialogViewModel>(
      viewModel: DaysPickerDialogViewModel(daysInWeekSelected: itemsSelected ?? []),
      onViewModelReady: (viewModel) => viewModel..initData(),
      builder: (context, viewModel, child) {
        return Container(
          height: height,
          child: StreamBuilder<bool>(
            stream: viewModel.isChangedSubject,
            builder: (context, snapShot) {
              final List<DayInWeek> dayInWeeks = viewModel.daysInWeek ?? [];
              return AnimationList(
                duration: AppConstants.ANIMATION_LIST_DURATION,
                reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
                children: dayInWeeks.map((e) => _buildItem(e, viewModel)).toList(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildItem(DayInWeek dayInWeek, DaysPickerDialogViewModel viewModel) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(left: 35),
      title: Text(
        dayInWeek.name ?? "",
        style: TextStyle(
          fontSize: AppFontSize.textDatePicker,
          color: AppColors.normal,
          fontWeight: viewModel.checkExist(dayInWeek) ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        viewModel.setDaysInWeekSelected(dayInWeek);
        this.onCallBack!(viewModel.daysInWeekSelected);
      },
    );
  }
}
