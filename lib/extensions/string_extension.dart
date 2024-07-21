extension StringExtensions on String {
  bool get containsDigits {
    return RegExp(r'\d').hasMatch(this);
  }
}
