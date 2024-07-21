import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class ExpandedChildScrollView extends StatelessWidget {
  final Widget child;
  final bool? primary;
  final bool? reverse;
  final Axis? scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final DragStartBehavior? dragStartBehavior;
  final ScrollBehavior? scrollBehavior;
  final bool Function(ScrollNotification scrollNotification)? onNotification;

  const ExpandedChildScrollView({
    Key? key,
    required this.child,
    this.primary,
    this.reverse,
    this.scrollDirection,
    this.physics,
    this.padding,
    this.controller,
    this.dragStartBehavior,
    this.scrollBehavior,
    this.onNotification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: scrollBehavior ?? ScrollBehavior(),
      child: NotificationListener<ScrollNotification>(
        onNotification: onNotification,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              key: key,
              padding: padding,
              physics: physics,
              primary: primary,
              reverse: reverse ?? false,
              controller: controller,
              scrollDirection: scrollDirection ?? Axis.vertical,
              dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraint.maxHeight,
                ),
                child: IntrinsicHeight(child: child),
              ),
            );
          },
        ),
      ),
    );
  }
}
