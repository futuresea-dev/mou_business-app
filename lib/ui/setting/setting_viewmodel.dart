import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/repositories/user_repository.dart';
import 'package:mou_business_app/helpers/push_notification_helper.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/managers/payments_manager.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_globals.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingViewModel extends BaseViewModel {
  String languageSelected = "en";

  final UserRepository userRepository;
  final PaymentsManager paymentsManager;

  SettingViewModel(this.userRepository, this.paymentsManager);

  @override
  void dispose() {
    userRepository.cancel();
    super.dispose();
  }

  init() {
    languageSelected = allTranslations.currentLanguage.toString();
  }

  updateLanguage(String code) async {
    Navigator.pop(context);
    if (code == this.languageSelected) return;
    setLoading(true);
    final resource = await userRepository.updateSetting(languageCode: code);
    if (resource.isSuccess) {
      await allTranslations.setNewLanguage(code);
      this.languageSelected = code;
    } else {
      showSnackBar(resource.message ?? "");
    }
    setLoading(false);
  }

  void onDonate() async {
    if (await canLaunchUrlString(AppConstants.linkDonate)) {
      await launchUrlString(AppConstants.linkDonate);
    } else {
      print(AppConstants.linkDonate);
    }
  }

  void onMouLink() async {
    if (await canLaunchUrlString(AppConstants.linkAbout)) {
      await launchUrlString(AppConstants.linkAbout);
    } else {
      print(AppConstants.linkAbout);
    }
  }

  void onLogout() {
    PushNotificationHelper.getToken().then((firebaseToken) async {
      final resource = await userRepository.deleteFCMToken(firebaseToken);
      if (resource.isSuccess) {
        await AppGlobals.logout(context);
      } else {
        showSnackBar(resource.message ?? "");
      }
    });
  }
}
