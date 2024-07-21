import 'package:collection/collection.dart';
import 'package:mou_business_app/core/models/gender.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class CommonHelper {
  static String convertPhoneNumber(String phoneNumber, {String code = "+84"}) {
    if (phoneNumber.isEmpty) return phoneNumber;
    if (phoneNumber.startsWith("0")) {
      phoneNumber = phoneNumber.replaceFirst("0", "");
    }
    if (phoneNumber.startsWith("${code}0")) {
      phoneNumber = phoneNumber.replaceFirst("${code}0", "");
    }
    if (phoneNumber.startsWith("$code")) {
      phoneNumber = phoneNumber.replaceFirst("$code", "");
    }
    return "$code$phoneNumber";
  }

  static String getFlagPath(String countryCode) {
    return "assets/flags/${countryCode.toLowerCase()}.png";
  }

  static List<Gender> getGenders() {
    return [
      Gender(type: 0, name: allTranslations.text(AppLanguages.female)),
      Gender(type: 1, name: allTranslations.text(AppLanguages.male)),
    ];
  }

  static String getNameGender(int type) {
    final genders = getGenders();
    var gender = genders.firstWhereOrNull((gender) => gender.type == type);
    return gender?.name ?? '';
  }

  static bool regEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static Map<String, dynamic> encodeMap(Map<String, dynamic> map) {
    map.forEach((key, value) {
      if (value is DateTime) {
        map[key] = value.toString();
      }
    });
    return map;
  }

  static double bytesToMB(int fileSizeInBytes) {
    // Convert the bytes to Kilobytes (1 KB = 1024 Bytes)
    double fileSizeInKB = fileSizeInBytes / 1024;
    // Convert the KB to MegaBytes (1 MB = 1024 KBytes)
    double fileSizeInMB = fileSizeInKB / 1024;
    return fileSizeInMB;
  }
}
