import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/company.dart';
import 'package:mou_business_app/core/models/country_phone_code.dart';
import 'package:mou_business_app/core/models/gender.dart';
import 'package:mou_business_app/core/repositories/user_repository.dart';
import 'package:mou_business_app/core/requests/company_request.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/helpers/common_helper.dart';
import 'package:mou_business_app/helpers/push_notification_helper.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/ui/edit_profile/components/select_working_days_sheet.dart';
import 'package:mou_business_app/utils/app_globals.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_shared.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileViewModel extends BaseViewModel {
  final UserRepository userRepository;

  EditProfileViewModel({required this.userRepository});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var cityController = TextEditingController();
  var addressController = TextEditingController();

  var isEditingSubject = BehaviorSubject<bool>();
  var countrySubject = BehaviorSubject<CountryPhoneCode>();
  var cityAndCountrySubject = BehaviorSubject<String>();
  var avatarLoadingSubject = BehaviorSubject<bool>();
  var avatarFileSubject = BehaviorSubject<File>();
  var selectedWorkingDays = BehaviorSubject<List<WeekDay>>();

  List<Gender> genders = CommonHelper.getGenders();

  Future<void> init() async {
    var profileInfo = await AppShared.getUser();
    selectedWorkingDays.add(profileInfo.company?.convertedWorkingDays ?? []);
    setCityAndCountry(profileInfo.company);
  }

  onChangeEditing() async {
    FocusScope.of(context).unfocus();
    setLoading(true);
    var isEditing = isEditingSubject.valueOrNull ?? false;
    if (!isEditing || isEditingSubject.valueOrNull == null) {
      var profileInfo = await AppShared.getUser();
      if (profileInfo.company != null) {
        nameController.text = profileInfo.company?.name ?? "";
        emailController.text = profileInfo.company?.email ?? "";
        cityController.text = profileInfo.company?.city ?? "";
        addressController.text = profileInfo.company?.address ?? "";
        this.setCityAndCountry(profileInfo.company);
      }
      isEditingSubject.add(!isEditing);
    } else {
      if (validate()) {
        var companyRequest = CompanyRequest(
          name: nameController.text,
          email: emailController.text,
          countryCode: countrySubject.valueOrNull?.code ?? "",
          city: cityController.text,
          address: addressController.text,
        );

        var result = await userRepository.updateProfileCompany(companyRequest);
        if (result.isSuccess) {
          showSnackBar(
            allTranslations.text(AppLanguages.profileUpdatedSuccess),
            isError: false,
          );
          var profileInfo = await AppShared.getUser();
          this.setCityAndCountry(profileInfo.company);
        } else {
          showSnackBar(result.message ?? "");
        }
        isEditingSubject.add(!isEditing);
      }
    }
    setLoading(false);
  }

  void setCityAndCountry(Company? company) {
    if (company != null) {
      String cityAndCountry = company.city ?? "";
      if (company.countryCode != null) {
        var countryInfo = AppUtils.appCountryCodes.firstWhereOrNull(
            (item) => item.code.toLowerCase() == company.countryCode?.toLowerCase());
        if (countryInfo != null) {
          countrySubject.add(countryInfo); // Add countryInfo to some subject
          cityAndCountry += countryInfo.name.isNotEmpty
              ? ", ${countryInfo.name}"
              : ""; // Concatenate country name to cityAndCountry
        }
      }
      cityAndCountrySubject.add(cityAndCountry); // Add cityAndCountry to some subject
    }
  }

  bool validate() {
    if (nameController.text.trim().isEmpty) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputName));
      return false;
    } else if (emailController.text.trim().isEmpty) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputEmail));
      return false;
    } else if (!CommonHelper.regEmail(emailController.text)) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseValidEmail));
      return false;
    } else if (countrySubject.valueOrNull == null) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseChooseCountry));
      return false;
    } else if (cityController.text.trim().isEmpty) {
      showSnackBar(allTranslations.text(AppLanguages.pleaseInputCity));
      return false;
    }
    return true;
  }

  onSelectPhoto(File file) async {
    avatarLoadingSubject.add(true);
    print("Start crop");
    var response = await userRepository.updateLogo(file);
    if (response.isSuccess) {
      avatarFileSubject.add(file);
      showSnackBar(
        allTranslations.text(AppLanguages.avatarUpdatedSuccess),
        isError: false,
      );
    } else {
      showSnackBar(response.message ?? "");
    }
    avatarLoadingSubject.add(false);
  }

  void changeCountry(CountryPhoneCode phoneCode) {
    countrySubject.add(phoneCode);
  }

  Future<void> deleteAccount() async {
    showDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text(allTranslations.text(AppLanguages.deleteAccount).toUpperCase()),
          content: Text(allTranslations.text(AppLanguages.deleteAccountConfirm)),
          actions: <Widget>[
            TextButton(
              child: Text(
                allTranslations.text(AppLanguages.cancel).toUpperCase(),
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(allTranslations.text(AppLanguages.ok).toUpperCase()),
              onPressed: () async {
                Navigator.pop(context);
                setLoading(true);
                final deleteAccountResource = await userRepository.deleteAccount();

                if (deleteAccountResource.isSuccess) {
                  PushNotificationHelper.getToken().then((firebaseToken) async {
                    try {
                      await userRepository.deleteFCMToken(firebaseToken);
                    } catch (e) {
                      print("Error: $e");
                    } finally {
                      setLoading(false);
                      showSnackBar(
                        allTranslations.text(AppLanguages.accountDeletedSuccessfully),
                        isError: false,
                      );
                      await AppGlobals.logout(context);
                    }
                  });
                } else {
                  showSnackBar(deleteAccountResource.message ?? "");
                  setLoading(false);
                }
              },
            )
          ],
        );
      },
    );
  }

  void selectWorkingDays() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (_) => SelectWorkingDaysSheet(selectedWorkingDays: selectedWorkingDays),
    ).then((_) async {
      setLoading(true);
      List<int> workingDays = selectedWorkingDays.value
          .map((e) => e == WeekDay.Sunday ? 7 : WeekDay.values.indexOf(e))
          .toList();

      Resource<dynamic> resource = await userRepository.updateWorkingDays(workingDays);
      setLoading(false);

      if (resource.isSuccess) {
        showSnackBar(
          allTranslations.text(AppLanguages.updateWorkingDaysSuccess),
          isError: false,
        );
      } else {
        showSnackBar(resource.message ?? "");
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    cityController.dispose();
    addressController.dispose();

    cityAndCountrySubject.drain();
    cityAndCountrySubject.close();

    avatarFileSubject.drain();
    avatarFileSubject.close();

    avatarLoadingSubject.drain();
    avatarLoadingSubject.close();

    countrySubject.drain();
    countrySubject.close();

    isEditingSubject.drain();
    isEditingSubject.close();

    selectedWorkingDays.drain();
    selectedWorkingDays.close();

    userRepository.cancel();
    super.dispose();
  }
}
