import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class TimeInAlarm {
  String? name;
  String? value;

  TimeInAlarm({this.name, this.value});
}

const fiveMinute = "5m";
const tenMinute = "10m";
const thirtyMinute = "30m";
const oneHour = "1h";
const oneDay = "1d";
const oneWeek = "1w";

final timeInAlarmData = [
  TimeInAlarm(
      name: "5 ${allTranslations.text(AppLanguages.minutes).toLowerCase()}",
      value: "5m"),
  TimeInAlarm(
      name: "10 ${allTranslations.text(AppLanguages.minutes).toLowerCase()}",
      value: "10m"),
  TimeInAlarm(
      name: "30 ${allTranslations.text(AppLanguages.minutes).toLowerCase()}",
      value: "30m"),
  TimeInAlarm(
      name: "1 ${allTranslations.text(AppLanguages.hour).toLowerCase()}",
      value: "1h"),
  TimeInAlarm(
      name: "1 ${allTranslations.text(AppLanguages.day).toLowerCase()}",
      value: "1d"),
  TimeInAlarm(
      name: "1 ${allTranslations.text(AppLanguages.week).toLowerCase()}",
      value: "1w")
];
