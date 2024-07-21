// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mou_business_app/core/models/country_phone_code.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_apis.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppUtils {
  static List<CountryPhoneCode> appCountryCodes = [];

  static String convertDateTime(
    String dateString, {
    String format = "dd/MM/yyyy",
    String defaultValue = "",
  }) {
    if (dateString != null) {
      try {
        var date = DateTime.parse(dateString);
        return DateFormat(format).format(date);
      } on Exception {}
    }
    return defaultValue;
  }

  static DateTime? convertStringToDateTime(
    String dateString, {
    bool split = false,
  }) {
    if (dateString.isNotEmpty) {
      final value = split ? dateString.split(" ")[0] : dateString;
      return DateTime.parse(value);
    }
    return null;
  }

  static String convertDateStringToHour(
    String dateString, {
    String format = "HH:mm",
    String defaultValue = "",
  }) {
    if (dateString.isNotEmpty) {
      try {
        var date = DateTime.parse(dateString);
        return DateFormat(format).format(date);
      } on Exception {}
    }
    return defaultValue;
  }

  static String convertDayToHour(
    DateTime dateTime, {
    String format = "HH:mm",
    String defaultValue = "",
  }) {
    if (dateTime != null) {
      return DateFormat(format).format(dateTime);
    }
    return defaultValue;
  }

  static String convertDayToString(
    DateTime dateTime, {
    String format = "dd/MM/yyyy",
    String defaultValue = "",
  }) {
    if (dateTime != null) {
      return DateFormat(format).format(dateTime);
    }
    return defaultValue;
  }

  static DateTime? clearTime(DateTime? dateTime) {
    if (dateTime == null) return null;
    final date = DateFormat("yyyy-MM-dd").format(dateTime);
    return DateTime.parse(date);
  }

  static String convertBetweenDateTimeToDateTime({
    required DateTime startDateTime,
    DateTime? endDateTime,
  }) {
    DateFormat timeFormat = DateFormat("HH:mm");
    DateFormat dateFormat = DateFormat("dd/MM");
    final startDate = clearTime(startDateTime);
    final endDate = clearTime(endDateTime);

    final String startTime = timeFormat.format(startDateTime);
    final String endTime = endDateTime == null ? '' : timeFormat.format(endDateTime);

    if (startDate == endDate) {
      if (startTime == endTime || endTime.isEmpty) {
        return '$startTime ${dateFormat.format(startDateTime)}';
      } else {
        return '$startTime - $endTime ${dateFormat.format(startDateTime)}';
      }
    } else {
      if (endDateTime == null) {
        return '$startTime ${dateFormat.format(startDateTime)}';
      } else {
        return '$startTime ${dateFormat.format(startDateTime)} - $endTime ${dateFormat.format(endDateTime)}';
      }
    }
  }

  static String convertBetweenTimeToTime({
    required DateTime startDateTime,
    DateTime? endDateTime,
  }) {
    final timeFormat = DateFormat("HH:mm");
    final String startTime = timeFormat.format(startDateTime);
    final String endTime = endDateTime == null ? '' : timeFormat.format(endDateTime);
    if (startTime == endTime || endTime.isEmpty) {
      return startTime;
    } else {
      return '$startTime $endTime';
    }
  }

  static String convertBetweenDateToDate({
    required DateTime startDateTime,
    DateTime? endDateTime,
  }) {
    final dateFormat = DateFormat("dd/MM");
    final String startDate = dateFormat.format(startDateTime);
    final String endDate = endDateTime == null ? '' : dateFormat.format(endDateTime);
    if (startDate == endDate || endDate.isEmpty) {
      return startDate;
    } else {
      return '$startDate $endDate';
    }
  }

  static int countDays(DateTime first, DateTime second) {
    if (first != null && second != null) {
      return DateTime(second.year, second.month, second.day)
          .difference(DateTime(first.year, first.month, first.day))
          .inDays;
    }
    return 0;
  }

  static String getMonth(DateTime dateTime, {int? maxLength}) {
    if (dateTime == null) return "";
    List<String> months = [
      allTranslations.text(AppLanguages.january),
      allTranslations.text(AppLanguages.february),
      allTranslations.text(AppLanguages.march),
      allTranslations.text(AppLanguages.april),
      allTranslations.text(AppLanguages.may),
      allTranslations.text(AppLanguages.june),
      allTranslations.text(AppLanguages.july),
      allTranslations.text(AppLanguages.august),
      allTranslations.text(AppLanguages.september),
      allTranslations.text(AppLanguages.october),
      allTranslations.text(AppLanguages.november),
      allTranslations.text(AppLanguages.december),
    ];
    final month = months[dateTime.month - 1];
    if (month != null && maxLength != null && month.length > maxLength) {
      return month.substring(0, maxLength);
    }
    return month;
  }

  static bool isEmptyString(String? string) {
    return (string?.length ?? 0) <= 0;
  }

  static DateTime? convertString2DateTime(String? dateTime,
      {String format = "yyyy-MM-ddTHH:mm:ss.SSSZ"}) {
    if (dateTime == null) return null;
    return DateFormat(format).parse(dateTime);
  }

  static DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday));
  }

  static DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday - 1));
  }

  static String firstUpperCase(String value) {
    String text = value.toLowerCase();
    return text[0].toUpperCase() + text.substring(1);
  }

  static void openLink(String link) async {
    try {
      await launchUrlString(
        link,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static Color getStatusColor(String status) {
    switch (status) {
      case TaskStatus.WAITING:
        return const Color(0xffedebea);
      case TaskStatus.IN_PROGRESS:
        return const Color(0xfffefbc7);
      case TaskStatus.DONE:
        return const Color(0xffd6eac7);
      case TaskStatus.NOT_DONE:
        return const Color(0xfffde3e3);
      default:
        return const Color(0xffedebea);
    }
  }

  static Color convertToColor(String colorHex) {
    var hexColor = colorHex.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    }
    return Colors.transparent;
  }

  static String getFullImageUrl(String? image) {
    if (image == null) return "";
    if (image.startsWith("http")) return image;
    return "${AppApis.domainAPI}$image";
  }
}
