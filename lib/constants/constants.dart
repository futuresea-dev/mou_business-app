import 'package:flutter/material.dart';

class Constants {
  static const Color graySpecialText = Color(0xFF8A8989);

  static const Color grayPrimaryText = Color(0xFF797878);
  static const Color lightGraySecondaryText = Color(0xFFA1A1A1);
  static const Color primaryLightGrayHint = Color(0xFFC4C4C4);
  //background colors
  static const Color bgColor = Color(0xFFFBF8F3);

  //Color(0xFFDBB970);
  static const String customFontFamily = 'Quicksand';

  static const TextStyle heading7Style = TextStyle(
    color: grayPrimaryText,
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    fontFamily: customFontFamily,
  );

  static const TextStyle subheadingStyle = TextStyle(
    color: grayPrimaryText,
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
    fontFamily: customFontFamily,
  );

  static const TextStyle bodyStyle = TextStyle(
    color: grayPrimaryText,
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: customFontFamily,
  );

  static const double appBarHeight = 146;
}
