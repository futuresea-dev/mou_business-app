import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class ValidatorsHelper {
  static validateNullWithKey(String key) {
    return (value) {
      if (value == null || value.length == 0) {
        return allTranslations.text(key);
      }
      return null;
    };
  }

  static validateName() {
    return validateNullWithKey(AppLanguages.validateName);
  }

  static validatePhone() {
    return validateNullWithKey(AppLanguages.validatePhone);
  }

  static validatePhoto() {
    return validateNullWithKey(AppLanguages.validatePhoto);
  }

  static String validateEmail(value) {
    final RegExp regex = RegExp(AppConstants.patternEmail);
    final String email = value?.trim() ?? '';
    if (value == null || value.isEmpty) {
      return allTranslations.text(AppLanguages.validateEmail);
    } else if (regex.hasMatch(email)) {
      return "";
    } else {
      return allTranslations.text(AppLanguages.validateEmailError);
    }
  }
}
