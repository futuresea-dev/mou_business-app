import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/converter/creator_converter.dart';
import 'package:mou_business_app/core/models/time_in_alarm.dart';
import 'package:mou_business_app/core/models/user.dart';
import 'package:mou_business_app/core/repositories/event_repository.dart';
import 'package:mou_business_app/core/services/wifi_service.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/helpers/send_notification_local.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/widgets/slidable/app_slidable.dart';
import 'package:mou_business_app/ui/widgets/widget_image_network.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_shared.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:mou_business_app/utils/types/slidable_action_type.dart';
import 'package:mou_business_app/utils/types/work_status.dart';

class ProjectItem extends StatefulWidget {
  final Event event;
  final EventRepository eventRepository;
  final void Function(String message, {bool isError})? showSnackBar;
  final Function(bool isLoading)? onExport;
  final VoidCallback? onRefreshCount;
  final VoidCallback? onRefreshList;
  final bool showInEventPage;
  final bool showInWorkPage;
  final VoidCallback? onExportPressed;

  const ProjectItem({
    super.key,
    required this.event,
    required this.eventRepository,
    required this.showSnackBar,
    this.onExport,
    this.onRefreshCount,
    this.onRefreshList,
    this.showInEventPage = false,
    this.showInWorkPage = false,
    this.onExportPressed,
  });

  @override
  _ProjectItemState createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  DateTime get startDate =>
      AppUtils.convertStringToDateTime(widget.event.startDate ?? '') ?? DateTime.now();

  DateTime? get endDate => AppUtils.convertStringToDateTime(widget.event.endDate ?? '');

  DateTime get projectStartDate =>
      AppUtils.convertStringToDateTime(widget.event.projectStartDate ?? '') ?? DateTime.now();

  DateTime? get projectEndDate =>
      AppUtils.convertStringToDateTime(widget.event.projectEndDate ?? '');

  bool get hasEndDate =>
      endDate != null &&
      (DateTime(startDate.year, startDate.month, startDate.day) !=
          DateTime(endDate!.year, endDate!.month, endDate!.day));

  bool get isFinished => endDate != null && DateTime.now().isAfter(endDate!);

  bool get waitingToConfirm => widget.event.waitingToConfirm ?? false;

  bool get isWaiting =>
      widget.event.status == TaskStatus.WAITING || startDate.isAfter(DateTime.now());

  bool get isInProgress => widget.event.status == TaskStatus.IN_PROGRESS;

  bool get isDenied => widget.event.status == 'N';
  final ValueNotifier<bool> _isCreator = ValueNotifier(true);
  String alarmToolTip = "";

  bool get isCalendarPage => !widget.showInEventPage && !widget.showInWorkPage;

  @override
  void initState() {
    super.initState();
    _getIsCreator();
    _getAlarmTime();
  }

  _getIsCreator() async {
    if (widget.event.creator != null) {
      final creator = CreatorConverter().fromSql(jsonEncode(widget.event.creator));
      _isCreator.value = creator.id == await AppShared.getUserID();
    }
  }

  _getAlarmTime() {
    if (timeInAlarmData.isNotEmpty && widget.event.alarm != null) {
      var lstAlarm = widget.event.alarm?.split(";");
      if (lstAlarm != null && lstAlarm.length > 0) {
        var timeInAlarmLocal = <TimeInAlarm>[];
        for (int i = 0; i < lstAlarm.length; i++) {
          var timeInAlarmExist =
              timeInAlarmData.firstWhereOrNull((item) => item.value == lstAlarm[i]);
          if (timeInAlarmExist != null) {
            timeInAlarmLocal.add(timeInAlarmExist);
          }
        }
        alarmToolTip = timeInAlarmLocal.map<String>((item) => item.name ?? "").toList().join("; ");
      }
    }
  }

  Widget dateLabel({bool isStartDate = true}) {
    String date = (isStartDate ? widget.event.startDate : widget.event.endDate) ?? '';
    return Container(
      padding: EdgeInsets.fromLTRB(isStartDate ? 15 : 18, 5, 15, 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFCBCBCB),
            Color(0xFF838280),
          ],
        ),
      ),
      child: Text(
        "${AppUtils.convertDayToString(
          AppUtils.convertStringToDateTime(date) ?? DateTime.now(),
          format: "dd/MM EEE",
        )}",
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<User> users = widget.event.users?.map((e) => User.fromJson(e)).toList() ?? [];
    String status = widget.event.status ?? '';
    Color statusColor = AppUtils.getStatusColor(status);
    WorkStatus? workStatus = widget.event.workStatus;
    if (status.isEmpty && workStatus != null) {
      statusColor = workStatus.gradientColor;
    }

    return StreamBuilder<ConnectivityResult>(
      stream: WifiService.wifiSubject,
      builder: (context, snapshot) {
        bool hasInternet = snapshot.hasData && snapshot.data != ConnectivityResult.none;

        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
          child: Bounceable(
            onTap: () {},
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topLeft,
              children: [
                SvgPicture.asset(AppImages.icProjectSVG),
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topLeft,
                    children: [
                      if (!isCalendarPage)
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Row(
                              children: List.generate(hasEndDate ? 2 : 1, (index) {
                                return Align(
                                  widthFactor: index == 0 ? 1 : 0.8,
                                  child: dateLabel(isStartDate: index == 0),
                                );
                              }),
                            ),
                            dateLabel(),
                          ],
                        ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _isCreator,
                        builder: (context, isCreator, child) {
                          final List<SlidableActionType> types = [
                            if (widget.showInWorkPage) SlidableActionType.EXPORT,
                            if (isCreator && !isFinished && (isWaiting || isInProgress || isDenied))
                              SlidableActionType.EDIT,
                            if (isCreator) SlidableActionType.DELETE,
                            if (isWaiting || isInProgress) ...[
                              SlidableActionType.ACCEPT,
                              SlidableActionType.DENY,
                            ],
                          ];

                          return AppSlidable<SlidableActionType>(
                            key: ValueKey(widget.event.id),
                            enabled: hasInternet && (!waitingToConfirm || isCreator),
                            actions: types,
                            onActionPressed: (type) {
                              return switch (type) {
                                SlidableActionType.EXPORT => widget.onExportPressed?.call(),
                                SlidableActionType.EDIT => _onEditProject(),
                                SlidableActionType.DELETE => _onDeletePressed(context),
                                SlidableActionType.ACCEPT => _onDoneTask(),
                                SlidableActionType.DENY => _onLeavePressed(context),
                              };
                            },
                            margin: EdgeInsets.only(top: !isCalendarPage ? 28 : 0),
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(9),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        statusColor,
                                        Colors.white,
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      WidgetImageNetwork(
                                        url: AppUtils.getFullImageUrl(widget.event.companyPhoto),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          widget.event.projectName ?? '',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: AppColors.normal,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      if (widget.event.scopeName?.isNotEmpty ??
                                                          false) ...[
                                                        const SizedBox(width: 8),
                                                        Tooltip(
                                                          key: ValueKey('scope ${widget.event.id}'),
                                                          message: widget.event.scopeName,
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 16, vertical: 10),
                                                          showDuration: const Duration(seconds: 3),
                                                          verticalOffset: 12,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.9),
                                                            borderRadius: BorderRadius.circular(9),
                                                            border: Border.all(
                                                                color: AppColors.textPlaceHolder),
                                                          ),
                                                          textStyle:
                                                              TextStyle(color: AppColors.normal),
                                                          margin: const EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                          child: Image.asset(
                                                            AppImages.icScope,
                                                            width: 15,
                                                            color: AppColors.normal,
                                                          ),
                                                          triggerMode: TooltipTriggerMode.tap,
                                                        ),
                                                      ],
                                                      if (waitingToConfirm && isCalendarPage)
                                                        SizedBox(width: 84),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  AppUtils.convertBetweenDateToDate(
                                                    startDateTime: projectStartDate,
                                                    endDateTime: projectEndDate == null ||
                                                            projectEndDate!
                                                                    .difference(projectStartDate)
                                                                    .inDays ==
                                                                0
                                                        ? null
                                                        : projectEndDate,
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: AppColors.normal,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    widget.event.title ?? '',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: AppColors.textHint,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                if (isCalendarPage)
                                                  Text(
                                                    AppUtils.convertBetweenDateToDate(
                                                      startDateTime: startDate,
                                                      endDateTime: endDate,
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: AppColors.textHint,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            if ((widget.event.clientName?.isNotEmpty ?? false) ||
                                                (widget.event.comment?.isNotEmpty ?? false)) ...[
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  if (widget.event.clientName?.isNotEmpty ??
                                                      false) ...[
                                                    SizedBox(
                                                      width: 20,
                                                      child: Center(
                                                        child: Image.asset(
                                                          AppImages.icAddClient,
                                                          width: 13,
                                                          color: AppColors.textHint,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                      widget.event.clientName ?? '',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: const Color(0xFFB1B1B1),
                                                      ),
                                                    ),
                                                  ],
                                                  const Spacer(),
                                                  if (widget.event.comment?.isNotEmpty ?? false)
                                                    Tooltip(
                                                      key: ValueKey('comment ${widget.event.id}'),
                                                      message: widget.event.comment,
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 16, vertical: 10),
                                                      showDuration: const Duration(seconds: 3),
                                                      verticalOffset: 12,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.9),
                                                        borderRadius: BorderRadius.circular(9),
                                                        border: Border.all(
                                                            color: AppColors.textPlaceHolder),
                                                      ),
                                                      textStyle: TextStyle(color: AppColors.normal),
                                                      margin: const EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      child: Image.asset(
                                                        AppImages.icCommentActive,
                                                        color: const Color(0xFF919090),
                                                        width: 28,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      triggerMode: TooltipTriggerMode.tap,
                                                    ),
                                                ],
                                              ),
                                            ],
                                            if (widget.event.leaderName?.isNotEmpty ?? false) ...[
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    AppImages.icAddTagResponsible,
                                                    width: 20,
                                                    color: AppColors.textHint,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Expanded(
                                                    child: Text(
                                                      widget.event.leaderName ?? '',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: const Color(0xFFB1B1B1),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            if (users.isNotEmpty)
                                              SizedBox(
                                                height: 41,
                                                child: ListView.separated(
                                                  padding: const EdgeInsets.only(top: 10),
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: users.length,
                                                  separatorBuilder: (context, index) =>
                                                      const SizedBox(width: 8),
                                                  itemBuilder: (context, index) {
                                                    User user = users[index];
                                                    String? avatar = user.avatar;
                                                    bool isAccepted = user.isAccepted ?? false;

                                                    return Stack(
                                                      children: [
                                                        WidgetImageNetwork(url: avatar ?? ''),
                                                        if (!isAccepted)
                                                          Positioned.fill(
                                                            child: DecoratedBox(
                                                              decoration: BoxDecoration(
                                                                color: AppColors.slidableRed
                                                                    .withOpacity(.5),
                                                                borderRadius:
                                                                    BorderRadius.circular(5),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (!isCreator && waitingToConfirm)
                                  Positioned(
                                    top: isCalendarPage ? 14 : 41,
                                    right: 16,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () => _onDenyPressed(context),
                                          child: Image.asset(AppImages.icDeny, width: 16),
                                        ),
                                        const SizedBox(width: 24),
                                        GestureDetector(
                                          onTap: _onAcceptTask,
                                          child: Image.asset(AppImages.icAcceptG, width: 26),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onDenyPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Text(
          allTranslations.text(AppLanguages.denyTaskProjectWarning),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              allTranslations.text(AppLanguages.cancel),
              style: TextStyle(color: AppColors.slidableRed),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _onDenyTask();
            },
            child: Text(
              allTranslations.text(AppLanguages.yes),
              style: TextStyle(color: AppColors.slidableGreen),
            ),
          ),
        ],
      ),
    );
  }

  _onDenyTask() async {
    final resource = await widget.eventRepository.denyEvent(widget.event.id);
    if (resource.isSuccess) {
      widget.showSnackBar?.call(
        allTranslations.text(AppLanguages.denyTaskProjectSuccessful),
        isError: false,
      );
      widget.onRefreshCount?.call();
    } else {
      widget.showSnackBar?.call(resource.message ?? "");
    }
  }

  _onAcceptTask() async {
    final resource = await widget.eventRepository.confirmEvent(widget.event.id);
    if (resource.isSuccess) {
      // Đăng ký sự kiên vào thiết bị
      SendNotificationLocal.registerNotificationLocal(widget.event);
      widget.showSnackBar?.call(
        allTranslations.text(AppLanguages.confirmTaskProjectSuccessful),
        isError: false,
      );
      widget.onRefreshCount?.call();
    } else {
      widget.showSnackBar?.call(resource.message ?? "");
    }
  }

  void _onLeavePressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Text(
          allTranslations.text(AppLanguages.leaveTaskProjectWarning),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              allTranslations.text(AppLanguages.cancel),
              style: TextStyle(color: AppColors.slidableRed),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _onLeaveTask();
            },
            child: Text(
              allTranslations.text(AppLanguages.yes),
              style: TextStyle(color: AppColors.slidableGreen),
            ),
          ),
        ],
      ),
    );
  }

  _onLeaveTask() async {
    final resource = await widget.eventRepository.leaveEvent(widget.event.id);
    // final resource = await widget.eventRepository.deleteEvent(widget.event.id);
    if (resource.isSuccess) {
      //Hủy đăng ký thông báo sư kiên ở thiết bị
      SendNotificationLocal.removeEventRegisterFromDevice(widget.event);
      widget.showSnackBar?.call(
        allTranslations.text(AppLanguages.leaveTaskProjectSuccessful),
        isError: false,
      );
      widget.onRefreshCount?.call();
    } else {
      widget.showSnackBar?.call(resource.message ?? "");
    }
  }

  _onDoneTask() async {
    final resource = await widget.eventRepository.confirmDoneTask(widget.event.id);
    if (resource.isSuccess) {
      widget.showSnackBar?.call(
        allTranslations.text(AppLanguages.doneTaskProjectSuccessful),
        isError: false,
      );
      widget.onRefreshCount?.call();
    } else {
      widget.showSnackBar?.call(resource.message ?? "");
    }
  }

  _onEditProject() async {
    await Navigator.pushNamed(
      context,
      Routers.ADD_PROJECT,
      arguments: widget.event.projectId,
    );
    widget.onRefreshCount?.call();
    widget.onRefreshList?.call();
  }

  void _onDeletePressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Text(
          allTranslations.text(AppLanguages.deleteTaskOfProjectWarning),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              allTranslations.text(AppLanguages.cancel),
              style: TextStyle(color: AppColors.slidableRed),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _onDeleteTask();
            },
            child: Text(
              allTranslations.text(AppLanguages.yes),
              style: TextStyle(color: AppColors.slidableGreen),
            ),
          ),
        ],
      ),
    );
  }

  _onDeleteTask() async {
    final resource = await widget.eventRepository.deleteEvent(widget.event.id);
    if (resource.isSuccess) {
      widget.showSnackBar?.call(
        allTranslations.text(AppLanguages.deleteTaskOfProjectSuccess),
        isError: false,
      );
      widget.onRefreshCount?.call();
    } else {
      widget.showSnackBar?.call(resource.message ?? "");
    }
  }
}
