import 'package:flutter/services.dart';

class RegExInputFormatter implements TextInputFormatter {
  final RegExp _regExp;

  RegExInputFormatter._(this._regExp);

  factory RegExInputFormatter.withRegex(String regexString) {
    try {
      final regex = RegExp(regexString);
      return RegExInputFormatter._(regex);
    } catch (e) {
      // Something not right with regex string.
      assert(false, e.toString());
      return RegExInputFormatter._(RegExp(r'^.*$'));
    }
  }

  factory RegExInputFormatter.onlyNumber() {
    try {
      final regex = RegExp('^\$|^([0-9][0-9]{0,})(\\[0-9]{0,})?\$');
      return RegExInputFormatter._(regex);
    } catch (e) {
      // Something not right with regex string.
      assert(false, e.toString());
      return RegExInputFormatter._(RegExp(r'^.*$'));
    }
  }

  factory RegExInputFormatter.phoneNumber() {
    try {
      final regex = RegExp('^\$|^([1-9][0-9]{0,})(\\[0-9]{0,})?\$');
      return RegExInputFormatter._(regex);
    } catch (e) {
      // Something not right with regex string.
      assert(false, e.toString());
      return RegExInputFormatter._(RegExp(r'^.*$'));
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = _isValid(oldValue.text);
    final newValueValid = _isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }

  bool _isValid(String value) {
    try {
      final matches = _regExp.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}
