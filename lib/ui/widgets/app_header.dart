import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mou_business_app/constants/constants.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.appBarHeight,
      width: double.maxFinite,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top - (Platform.isIOS ? 16 : 0)),
      alignment: Alignment.center,
      child: child,
    );
  }
}
