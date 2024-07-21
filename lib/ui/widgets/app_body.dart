import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mou_business_app/utils/app_colors.dart';

class AppBody extends StatelessWidget {
  final Widget child;
  final Color statusBarColor;
  final Color systemNavigationBarColor;

  const AppBody({
    super.key,
    required this.child,
    this.statusBarColor = Colors.white,
    this.systemNavigationBarColor = AppColors.bgColor2,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        top: false,
        bottom: !Platform.isIOS,
        child: child,
      ),
    );
  }
}
