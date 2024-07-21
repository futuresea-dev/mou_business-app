import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/country_phone_code.dart';
import 'package:mou_business_app/core/repositories/auth_repository.dart';
import 'package:mou_business_app/core/requests/company_request.dart';
import 'package:mou_business_app/helpers/file_size.dart';
import 'package:mou_business_app/helpers/image_helper.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:rxdart/rxdart.dart';

class RegisterProfileViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  RegisterProfileViewModel(this.authRepository);

  var nameFocusNode = FocusNode();
  var nameController = TextEditingController();

  var emailFocusNode = FocusNode();
  var emailController = TextEditingController();

  var cityFocusNode = FocusNode();
  var cityController = TextEditingController();

  final countrySubject = BehaviorSubject<CountryPhoneCode?>();
  final logoLoadingSubject = BehaviorSubject<bool>();
  final logoFileSubject = BehaviorSubject<File?>();
  final finishBackgroundSubject = BehaviorSubject<bool>();

  void changeCountry(CountryPhoneCode phoneCode) {
    countrySubject.add(phoneCode);
  }

  onSelectPhoto(File? file) async {
    if (file != null) {
      logoLoadingSubject.add(true);
      final width = MediaQuery.sizeOf(context).width;
      File fileCrop =
          await ImageHelper.cropImage(file, (width - 80).round().toInt(), width.round().toInt());
      logoFileSubject.add(fileCrop);
      logoLoadingSubject.add(false);
      changeFinishBackground();
    }
  }

  onFinish() async {
    FocusScope.of(context).unfocus();
    if (validate()) {
      this.setLoading(true);
      var userRequest = CompanyRequest(
        name: nameController.text,
        email: emailController.text,
        logo: logoFileSubject.value,
        countryCode: countrySubject.valueOrNull?.code ?? "",
        city: cityController.text,
      );
      var length = await logoFileSubject.valueOrNull?.length();
      var fileSize = fileSizeMB(length);
      print("fileSize : $fileSize");
      if (fileSize <= 20) {
        final result = await authRepository.registerCompany(userRequest);
        if (result.isSuccess) {
          Navigator.popUntil(context, (router) => router.isFirst);
          Navigator.pushReplacementNamed(context, Routers.ONBOARDING);
        } else {
          showSnackBar(result.message ?? "");
        }
      } else {
        showSnackBar(allTranslations.text(AppLanguages.fileAvatarCannotLargeSize));
      }
      this.setLoading(false);
    }
  }

  bool validate() {
    if (logoFileSubject.value == null) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseChooseAvatar));
      return false;
    } else if (nameController.text.isEmpty ||
        (nameController.text.isNotEmpty && nameController.text.trim() == "")) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputName));
      return false;
    } else if (emailController.text.isEmpty ||
        (emailController.text.isNotEmpty && emailController.text.trim() == "")) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputEmail));
      return false;
    } else if (countrySubject.value == null) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseChooseCountry));
      return false;
    } else if (cityController.text.isEmpty ||
        (cityController.text.isNotEmpty && cityController.text.trim() == "")) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputCity));
      return false;
    }
    return true;
  }

  changeFinishBackground() {
    File? logo = logoFileSubject.valueOrNull;
    String name = nameController.text;
    String email = emailController.text;
    CountryPhoneCode? countryPhoneCode = countrySubject.valueOrNull;
    String city = cityController.text;
    if (logo == null ||
        countryPhoneCode == null ||
        name.trim().isEmpty ||
        email.trim().isEmpty ||
        city.trim().isEmpty) {
      finishBackgroundSubject.add(false);
      return;
    }
    finishBackgroundSubject.add(true);
    return;
  }

  @override
  void dispose() {
    authRepository.cancel();

    countrySubject.close();
    logoFileSubject.close();
    logoLoadingSubject.close();
    finishBackgroundSubject.close();

    nameController.dispose();
    emailController.dispose();
    cityController.dispose();

    super.dispose();
  }
}
