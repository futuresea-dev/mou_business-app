import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mou_business_app/ui/widgets/slidable/app_slidable.dart';

class AppSlidableAction extends StatelessWidget {
  final AppSlidableActionType actionType;
  final SlidableActionCallback? onPressed;
  final Color? secondaryColor;

  const AppSlidableAction({
    super.key,
    required this.actionType,
    this.onPressed,
    this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      backgroundColor: secondaryColor ?? Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: actionType.backgroundColor,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(9)),
        ),
        child: SizedBox(
          width: actionType.iconSize,
          height: actionType.iconSize,
          child: actionType.iconPath.toLowerCase().endsWith('.svg')
              ? SvgPicture.asset(
                  actionType.iconPath,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                )
              : Image.asset(
                  actionType.iconPath,
                  fit: BoxFit.scaleDown,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
