import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/country_phone_code.dart';
import 'package:mou_business_app/core/repositories/auth_repository.dart';
import 'package:mou_business_app/core/requests/change_phone_request.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/verification_code/verification_code_dialog.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:rxdart/rxdart.dart';

class ChangeNumberViewModel extends BaseViewModel {
  final newPhoneController = TextEditingController();
  final activeSubject = BehaviorSubject<bool>();
  final dialCodeSubject = BehaviorSubject<CountryPhoneCode?>();
  final dialCodesSubject = BehaviorSubject<List<CountryPhoneCode>>();

  final AuthRepository authRepository;

  ChangeNumberViewModel(this.authRepository);

  Future<void> fetchData(String? code) async {
    dialCodesSubject.add(AppUtils.appCountryCodes);
    dialCodeSubject
        .add(AppUtils.appCountryCodes.firstWhereOrNull((e) => e.code.toLowerCase() == 'us') ??
            CountryPhoneCode(
              name: 'United States',
              dialCode: '+1',
              code: 'US',
            ));
  }

  void onNewPhoneChanged(String text) {
    activeSubject.add(text.isNotEmpty);
  }

  void onSubmitPressed(ChangeNumberRequest request) async {
    FocusScope.of(context).unfocus();
    String phone = newPhoneController.text;
    if (phone.startsWith("0")) {
      phone = phone.replaceFirst("0", "");
    }
    final String dialCode = dialCodeSubject.value?.dialCode ?? "+1";
    final result = await _showSmsCodeInputDialog(
      request: request,
      dialCode: dialCode,
      phone: phone,
    );

    if (result is String) {
      showSnackBar(result);
    }
  }

  Future<dynamic> _showSmsCodeInputDialog({
    required ChangeNumberRequest request,
    required String dialCode,
    required String phone,
  }) =>
      showGeneralDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.3),
        barrierDismissible: false,
        barrierLabel: "",
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, _, __) => VerificationCodeDialog(
          dialCode: dialCode,
          phoneNumber: phone,
          verifyType: VerifyType.CHANGE_PHONE,
          changeNumberRequest: request.copyWith(
            phoneNumber: phone,
            dialCode: dialCode,
          ),
        ),
      );

  @override
  void dispose() {
    activeSubject.close();
    activeSubject.close();
    dialCodeSubject.close();
    dialCodeSubject.close();
    dialCodesSubject.close();
    dialCodesSubject.close();
    newPhoneController.dispose();
    super.dispose();
  }

  void changeDialCode(CountryPhoneCode phoneCode) {
    dialCodeSubject.add(phoneCode);
  }
}
