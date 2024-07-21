import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mou_business_app/ui/widgets/slidable/app_slidable_action.dart';

class AppSlidableActionType {
  double? get iconSize => null;

  String get iconPath => '';

  Color get backgroundColor => Colors.transparent;
}

class AppSlidable<T extends AppSlidableActionType> extends StatelessWidget {
  final List<T> actions;
  final bool enabled;
  final ValueChanged<T>? onActionPressed;
  final Widget child;
  final EdgeInsets? margin;

  const AppSlidable({
    super.key,
    this.actions = const [],
    this.enabled = true,
    this.onActionPressed,
    required this.child,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(2, 5),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: actions.firstOrNull?.backgroundColor,
          ),
          child: Slidable(
            key: key,
            enabled: enabled,
            endActionPane: actions.isNotEmpty
                ? ActionPane(
                    key: key,
                    motion: const DrawerMotion(),
                    extentRatio: actions.length * 60 / MediaQuery.of(context).size.width,
                    children: List.generate(actions.length, (index) {
                      final T type = actions[index];
                      final T? nextType = index < actions.length - 1 ? actions[index + 1] : null;
                      return AppSlidableAction(
                        actionType: type,
                        secondaryColor: nextType?.backgroundColor,
                        onPressed: (context) => onActionPressed?.call(type),
                      );
                    }).toList(),
                  )
                : null,
            child: child,
          ),
        ),
      ),
    );
  }
}
