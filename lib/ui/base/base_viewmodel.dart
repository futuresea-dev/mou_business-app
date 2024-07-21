import 'package:flutter/material.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BuildContext? _context;

  BuildContext get context => _context!;

  setContext(BuildContext value) {
    _context = value;
    loadingSubject.value = false;
  }

  final loadingSubject = BehaviorSubject<bool>();
  final errorSubject = BehaviorSubject<String>();

  void setLoading(bool loading) {
    loadingSubject.add(loading);
  }

  void setError(String message) {
    errorSubject.add(message);
  }

  bool get isLoading => loadingSubject.valueOrNull ?? false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void showSnackBar(String? message, {Color? backgroundColor, bool isError = true}) {
    if (message == null || message.isEmpty) return;
    var snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor ?? (isError 
          ? AppColors.slidableRed.withOpacity(0.8)
          : AppColors.slidableGreen.withOpacity(0.8)),
    );
    try {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print("Show Snack Bar Error:: $e");
    }
  }

  @override
  void dispose() {
    loadingSubject.close();
    errorSubject.close();
    super.dispose();
  }
}
