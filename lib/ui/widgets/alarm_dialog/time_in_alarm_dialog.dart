import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/time_in_alarm.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/alarm_dialog/time_in_alarm_dialog_viewmodel.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';

class TimeInAlarmDialog extends StatelessWidget {
  final double? height;
  final List<TimeInAlarm>? itemsSelected;
  final Function(List<TimeInAlarm> timesInAlarm)? onCallBack;

  TimeInAlarmDialog({this.height, this.itemsSelected, this.onCallBack});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TimeInAlarmDialogViewModel>(
      viewModel: TimeInAlarmDialogViewModel(timeInAlarmsSelected: this.itemsSelected ?? []),
      onViewModelReady: (viewModel) => viewModel..initData(),
      builder: (context, viewModel, child) {
        return Container(
          height: height,
          child: StreamBuilder<bool>(
            stream: viewModel.isChangedSubject,
            builder: (context, snapShot) {
              final List<TimeInAlarm> alarms = viewModel.timeInAlarms ?? [];
              return AnimationList(
                duration: AppConstants.ANIMATION_LIST_DURATION,
                reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
                children: alarms.map((e) => _buildItem(e, context, viewModel)).toList(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildItem(TimeInAlarm alarm, BuildContext context, TimeInAlarmDialogViewModel viewModel) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(left: 35),
      title: Text(
        alarm.name ?? "",
        style: TextStyle(
          fontSize: AppFontSize.textDatePicker,
          color: AppColors.normal,
          fontWeight: viewModel.checkExist(alarm) ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        viewModel.setDaysInWeekSelected(alarm);
        this.onCallBack!(viewModel.timeInAlarmsSelected);
      },
    );
  }
}
