import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/models/employee_model.dart';
import 'package:mou_business_app/ui/roster/roster_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/slidable/app_slidable.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_shared.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:mou_business_app/utils/types/slidable_action_type.dart';

class RosterItem extends StatefulWidget {
  final Roster roster;
  final RosterViewModel viewModel;

  const RosterItem({
    super.key,
    required this.roster,
    required this.viewModel,
  });

  @override
  _RosterItemState createState() => _RosterItemState();
}

class _RosterItemState extends State<RosterItem> {
  final ValueNotifier<bool> isCreator = ValueNotifier(false);

  DateTime? get startDate => AppUtils.convertStringToDateTime(widget.roster.startTime);

  DateTime? get endDate => AppUtils.convertStringToDateTime(widget.roster.endTime);

  bool get hasEndDate =>
      endDate != null &&
      (DateTime(startDate!.year, startDate!.month, startDate!.day) !=
          DateTime(endDate!.year, endDate!.month, endDate!.day));

  bool get isBeforeStartDate => startDate != null && DateTime.now().isBefore(startDate!);

  @override
  void initState() {
    super.initState();
    getIsCreator();
  }

  getIsCreator() async {
    if (widget.roster.creatorId != null) {
      isCreator.value = widget.roster.creatorId == await AppShared.getUserID();
    }
  }

  Widget dateLabel({bool isStartDate = true}) {
    String date = isStartDate ? widget.roster.startTime : widget.roster.endTime;
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

  _image(EmployeeModel? employee) {
    if (employee != null && employee.employeeAvatar.isNotEmpty) {
      return NetworkImage(employee.employeeAvatar);
    }
    return AssetImage(AppImages.bgBtnLogin);
  }

  @override
  Widget build(BuildContext context) {
    EmployeeModel? employee = widget.viewModel.checkEmployee(widget.roster);
    Color colorStatus = widget.roster.status?.toUpperCase() == RosterStatusType.accept
        ? const Color(0xFFF4ECC8)
        : AppColors.colorBgRed;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topLeft,
        children: [
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
            valueListenable: isCreator,
            builder: (_, value, __) {
              return AppSlidable<SlidableActionType>(
                key: ValueKey(widget.roster.id),
                actions: [
                  if (isBeforeStartDate) SlidableActionType.EDIT,
                  SlidableActionType.DELETE,
                ],
                onActionPressed: (type) {
                  return switch (type) {
                    SlidableActionType.EXPORT => null,
                    SlidableActionType.EDIT => widget.viewModel.onEditRoster(widget.roster.id),
                    SlidableActionType.DELETE => widget.viewModel.onDeleteRoster(widget.roster.id),
                    SlidableActionType.ACCEPT => null,
                    SlidableActionType.DENY => null,
                  };
                },
                margin: const EdgeInsets.only(top: 28),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        colorStatus,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 31,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            image: _image(employee),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 60),
                              child: Text(
                                employee?.employeeName ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.colorEerieBlack,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              employee?.roleName ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.colorGrayText,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
