import 'package:flutter/material.dart';

class InputTextFieldContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  InputTextFieldContainer({
    required this.child,
    this.width = double.maxFinite,
    this.height = 46,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(2,5)
          )
        ]
      ),
      child: this.child,
    );
  }
}
