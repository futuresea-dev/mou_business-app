import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/repositories/auth_repository.dart';
import 'package:mou_business_app/core/repositories/user_repository.dart';
import 'package:mou_business_app/core/requests/change_phone_request.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/core/services/firebase_service.dart';
import 'package:mou_business_app/helpers/common_helper.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_shared.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:rxdart/rxdart.dart';

class VerificationCodeViewModel extends BaseViewModel {
  final VerifyType verifyType;
  final FirebaseService service;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final String dialCode;
  final String phone;
  final ChangeNumberRequest? changeNumberRequest;

  final TextEditingController pinCodeController = TextEditingController();
  final BehaviorSubject<bool> isAcceptSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> showAnimDone = BehaviorSubject.seeded(false);

  VerificationCodeViewModel({
    required this.service,
    required this.authRepository,
    required this.userRepository,
    required this.verifyType,
    required this.dialCode,
    required this.phone,
    required this.changeNumberRequest,
  });

  void onValueCallback(String value) {
    if (value.length == 6) {
      isAcceptSubject.add(true);
    } else {
      isAcceptSubject.add(false);
    }
  }

  void onTextChanged(String value) {
    isAcceptSubject.add(value.length == 6);
  }

  void verifyPhone() {
    String phoneNumber = CommonHelper.convertPhoneNumber(phone, code: dialCode);
    service.verifyPhone(
      phoneNumber,
      _verificationCompleted,
      _verificationFailed,
    );
  }

  void _verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    setLoading(true);
    final accessToken = await service.signInWithAuthCredential(phoneAuthCredential);
    _signInByAccessToken(accessToken ?? '');
  }

  void _verificationFailed(FirebaseAuthException exception) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Icon(Icons.error_outline, size: 60, color: Colors.red),
          content: Text(
            exception.message ?? "",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Đóng dialog
                Navigator.pop(context);
                // Đóng verify phone
                Navigator.pop(context);
              },
              child: Text(allTranslations.text(AppLanguages.ok).toUpperCase()),
            )
          ],
        );
      },
    );
  }

  void onPressRegisterCode() async {
    FocusScope.of(context).unfocus();
    if (isLoading) return;
    setLoading(true);
    String pinCode = pinCodeController.text;
    if (pinCode.length == 6) {
      final accessToken = await service.getTokenByCode(pinCode);
      _signInByAccessToken(accessToken ?? '');
    } else {
      showSnackBar(allTranslations.text(AppLanguages.smsCodeIncorrect));
    }
  }

  Future<void> _signInByAccessToken(String accessToken) async {
    if (accessToken.isEmpty) {
      setLoading(false);
      showSnackBar(allTranslations.text(AppLanguages.smsCodeIncorrect));
    } else {
      await AppShared.setAccessToken(accessToken);
      switch (verifyType) {
        case VerifyType.LOGIN:
          final checkPhoneResource = await authRepository.checkExistPhone();
          if (checkPhoneResource.isSuccess) {
            final getInfoResource = await authRepository.getMeInfo();
            setLoading(false);
            showAnimDone.add(true);
            await Future.delayed(const Duration(milliseconds: 1500));
            showAnimDone.add(false);
            if (getInfoResource.isSuccess) {
              Navigator.pushNamedAndRemoveUntil(context, Routers.HOME, (route) => false);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routers.REGISTER_PROFILE,
                (route) => route.isFirst,
              );
            }
          } else if (checkPhoneResource.status == 402) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routers.REGISTER_PROFILE,
              (route) => route.isFirst,
            );
          } else {
            String message = "";
            if (checkPhoneResource.message == "NOT_PERMISSION") {
              message = allTranslations.text(AppLanguages.notPermissionLogin);
            } else {
              message = checkPhoneResource.message ?? "";
            }
            // If phone not exist then pop screen
            showSnackBar(message);
            setLoading(false);
          }
          break;
        case VerifyType.CHANGE_PHONE:
          if (changeNumberRequest == null) {
            setLoading(false);
            return;
          }
          Resource<String> resource = await authRepository.changePhone(changeNumberRequest!);
          if (resource.isSuccess) {
            final data = await authRepository.getMeInfo();
            setLoading(false);
            if (data.isSuccess) {
              showAnimDone.add(true);
              await Future.delayed(const Duration(milliseconds: 1500));
              showAnimDone.add(false);
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routers.HOME,
                (route) => false,
              );
            } else {
              showSnackBar(data.message);
            }
          } else {
            setLoading(false);
            showSnackBar(resource.message);
          }
          break;
      }
    }
  }

  @override
  void dispose() {
    isAcceptSubject.close();
    showAnimDone.close();
    super.dispose();
  }
}
