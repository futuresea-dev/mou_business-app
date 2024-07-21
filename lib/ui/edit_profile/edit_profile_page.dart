import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide MenuBar;
import 'package:mou_business_app/constants/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mou_business_app/core/models/country_phone_code.dart';
import 'package:mou_business_app/core/responses/register_response.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/edit_profile/edit_profile_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/choose_photo_dialog.dart';
import 'package:mou_business_app/ui/widgets/country_phone_code_dialog.dart';
import 'package:mou_business_app/ui/widgets/input_text_field.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_shared.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<EditProfileViewModel>(
      viewModel: EditProfileViewModel(userRepository: Provider.of(context)),
      onViewModelReady: (viewModel) => viewModel..init(),
      builder: (context, viewModel, child) => StreamBuilder<bool>(
        stream: viewModel.loadingSubject,
        builder: (context, snapshot) {
          var isLoading = snapshot.data ?? false;
          return LoadingFullScreen(
            loading: isLoading,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: AppBody(
                  child: _buildContentContainer(context, viewModel),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentContainer(BuildContext context, EditProfileViewModel viewModel) {
    return AppContent(
      menuBar: const AppMenuBar(),
      childBuilder: (hasInternet) => Stack(
        children: <Widget>[
          Scaffold(
            key: viewModel.scaffoldKey,
            body: _buildContent(context, viewModel, hasInternet),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: Constants.appBarHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.bottomCenter,
                      image: AssetImage(AppImages.bgTopHeaderNew),
                    ),
                  ),
                  padding: const EdgeInsets.only(right: 8, top: 10),
                  child: StreamBuilder<bool>(
                    stream: viewModel.isEditingSubject,
                    builder: (context, snapshot) {
                      bool isEditing = snapshot.data ?? false;
                      return Row(
                        children: [
                          SizedBox(
                            height: 33,
                            child: IconButton(
                              icon: Image.asset(AppImages.icArrowBack),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          const Spacer(),
                          if (hasInternet)
                            IconButton(
                              iconSize: 50,
                              onPressed: viewModel.onChangeEditing,
                              alignment: Alignment.centerRight,
                              icon: isEditing
                                  ? Image.asset(
                                      AppImages.icAccept,
                                      height: 14,
                                      width: 23.5,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      AppImages.icEdit,
                                      height: 18,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          const SizedBox(width: 16),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    AppImages.icAccountProfile_g,
                    height: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, EditProfileViewModel viewModel, bool hasInternet) {
    return DecoratedBox(
      decoration: BoxDecoration(gradient: AppColors.bgGradient),
      child: StreamBuilder<RegisterResponse>(
        stream: AppShared.getUser().asStream(),
        builder: (context, snapShot) {
          var user = snapShot.data ?? null;
          return StreamBuilder<bool>(
            stream: viewModel.isEditingSubject,
            builder: (context, snapshot) {
              var isEditing = snapshot.data ?? false;
              return Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    _buildAvatar(context, viewModel, user ?? RegisterResponse(), isEditing),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(26, 16, 26, 100),
                        child: Column(
                          children: [
                            _buildPhoneNumber(
                              context,
                              viewModel,
                              user?.dialCode ?? "",
                              user?.phoneNumber ?? "",
                              isEditing,
                            ),
                            const SizedBox(height: 22),
                            _buildCompany(context, viewModel, user?.company?.name ?? "", isEditing),
                            SizedBox(height: isEditing ? 14 : 22),
                            _buildEmail(context, viewModel, user?.company?.email ?? "", isEditing),
                            SizedBox(height: isEditing ? 0 : 22),
                            _buildCityAndCountry(context, viewModel, isEditing),
                            SizedBox(height: !isEditing ? 0 : 22),
                            _buildCountry(context, viewModel, isEditing),
                            SizedBox(height: !isEditing ? 0 : 22),
                            _buildCity(context, viewModel, isEditing),
                            SizedBox(height: isEditing ? 14 : 22),
                            // _buildAddress(
                            //   context,
                            //   viewModel,
                            //   user?.company?.address ?? "",
                            //   isEditing,
                            // ),
                            // const SizedBox(height: 22),
                            _buildWorkingDays(viewModel, hasInternet),
                            if (isEditing) _buildDeleteAccount(viewModel),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    EditProfileViewModel viewModel,
    RegisterResponse user,
    bool isEditing,
  ) {
    return InkWell(
      onTap: () => _showChoosePhotoDialog(context, viewModel, isEditing),
      child: StreamBuilder<File>(
        stream: viewModel.avatarFileSubject,
        builder: (context, snapshot) {
          var avatarFile = snapshot.data ?? null;
          return Padding(
            padding: const EdgeInsets.only(top: 85),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(
                  AppImages.profileBg,
                  height: 310,
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 25,
                  child: Container(
                    height: 230,
                    width: MediaQuery.sizeOf(context).width - 48,
                    child: avatarFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              avatarFile,
                              fit: BoxFit.cover,
                            ),
                          )
                        : user.avatar == null
                            ? Image.asset(
                                AppImages.icAdd,
                                color: Colors.transparent,
                                width: 10,
                                fit: BoxFit.cover,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: user.company?.logo ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                  ),
                ),
                StreamBuilder<bool>(
                  stream: viewModel.avatarLoadingSubject,
                  builder: (context, snapshot) {
                    var isAvatarLoading = snapshot.data ?? false;
                    if (isAvatarLoading) {
                      return LoadingAnimationWidget.staggeredDotsWave(
                          color: AppColors.menuBar, size: 35);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                isEditing
                    ? Image.asset(
                        AppImages.icAdd,
                        color: Colors.transparent,
                        width: 25,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }

  void _showChoosePhotoDialog(
    BuildContext context,
    EditProfileViewModel viewModel,
    bool isEditing,
  ) {
    bool loading = viewModel.avatarLoadingSubject.valueOrNull ?? false;
    if (!loading && isEditing) {
      showDialog(
        context: context,
        builder: (context) => PickerPhotoDialog(
          onSelected: (file) async {
            await viewModel.onSelectPhoto(file);
          },
        ),
      );
    }
  }

  Widget _buildPhoneNumber(BuildContext context, EditProfileViewModel viewModel, String dialCode,
      String phoneNumber, bool isEditing) {
    return Row(
      children: <Widget>[
        Container(
          width: 130,
          child: Text(
            allTranslations.text(AppLanguages.loginNumber),
            style: TextStyle(
              fontSize: AppFontSize.textButton,
              fontWeight: FontWeight.bold,
              color: AppColors.normal,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: isEditing ? Alignment.centerLeft : Alignment.centerRight,
            child: Text(
              "$dialCode$phoneNumber",
              style: TextStyle(
                fontSize: AppFontSize.textQuestion,
                fontWeight: FontWeight.w500,
                color: AppColors.textTitleProfile,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCompany(
    BuildContext context,
    EditProfileViewModel viewModel,
    String company,
    bool isEditing,
  ) {
    var companyTrans = allTranslations.text(AppLanguages.company);
    return Row(
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            "$companyTrans",
            style: TextStyle(
              fontSize: AppFontSize.textButton,
              fontWeight: FontWeight.bold,
              color: AppColors.normal,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                isEditing
                    ? InputTextField(
                        controller: viewModel.nameController,
                        hintText: allTranslations.text(AppLanguages.name),
                        inputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        fontSize: AppFontSize.textQuestion,
                        onSubmitted: (text) {},
                        isDense: true,
                      )
                    : Text(
                        "$company",
                        style: TextStyle(
                          fontSize: AppFontSize.textQuestion,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textTitleProfile,
                        ),
                      ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEmail(
    BuildContext context,
    EditProfileViewModel viewModel,
    String email,
    bool isEditing,
  ) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          width: 130,
          child: Text(
            allTranslations.text(AppLanguages.eMail),
            style: TextStyle(
              fontSize: AppFontSize.textButton,
              fontWeight: FontWeight.bold,
              color: AppColors.normal,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                if (isEditing) {}
              },
              child: Column(
                crossAxisAlignment: isEditing ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: <Widget>[
                  isEditing
                      ? InputTextField(
                          controller: viewModel.emailController,
                          hintText: allTranslations.text(AppLanguages.email),
                          inputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          fontSize: AppFontSize.textQuestion,
                          isDense: true,
                          onSubmitted: (text) {},
                        )
                      : Text(
                          "$email",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppFontSize.textQuestion,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTitleProfile,
                          ),
                        ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCityAndCountry(
      BuildContext context, EditProfileViewModel viewModel, bool isEditing) {
    return isEditing
        ? SizedBox()
        : Row(
            children: <Widget>[
              Container(
                width: 130,
                child: Text(
                  allTranslations.text(AppLanguages.cityAndCountry),
                  style: TextStyle(
                      fontSize: AppFontSize.textButton,
                      fontWeight: FontWeight.bold,
                      color: AppColors.normal),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: StreamBuilder<String>(
                    stream: viewModel.cityAndCountrySubject,
                    builder: (context, snapShot) {
                      var fullAddress = snapShot.data ?? "";
                      return Text(
                        "$fullAddress",
                        style: TextStyle(
                          fontSize: AppFontSize.textQuestion,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textTitleProfile,
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
  }

  Widget _buildCountry(BuildContext context, EditProfileViewModel viewModel, bool isEditing) {
    var countryTrans = allTranslations.text(AppLanguages.country);
    return !isEditing
        ? SizedBox()
        : Row(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                width: 130,
                child: Text(
                  "${countryTrans[0].toUpperCase()}${countryTrans.substring(1)}",
                  style: TextStyle(
                    fontSize: AppFontSize.textButton,
                    fontWeight: FontWeight.bold,
                    color: AppColors.normal,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (isEditing) {
                      _showCountryDialog(context, viewModel);
                    }
                  },
                  child: Column(
                    crossAxisAlignment:
                        isEditing ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                    children: <Widget>[
                      StreamBuilder<CountryPhoneCode>(
                        stream: viewModel.countrySubject,
                        builder: (context, snapshot) {
                          var country = snapshot.data ?? null;
                          return Text(
                            country?.name ?? "",
                            style: TextStyle(
                                fontSize: AppFontSize.textQuestion,
                                color: isEditing ? AppColors.normal : AppColors.normal),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
  }

  void _showCountryDialog(BuildContext context, EditProfileViewModel viewModel) {
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox();
      },
      context: context,
      transitionBuilder: (context, animation1, animation2, widget) {
        return Transform.scale(
          scale: animation1.value,
          child: Opacity(
            opacity: animation1.value,
            child: WillPopScope(
              onWillPop: () async => false,
              child: CountryPhoneCodeDialog(
                phoneCodeCallBack: viewModel.changeCountry,
                isPhoneCode: false,
                title: allTranslations.text(AppLanguages.countries),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCity(BuildContext context, EditProfileViewModel viewModel, bool isEditing) {
    var cityTrans = allTranslations.text(AppLanguages.city);
    return !isEditing
        ? SizedBox()
        : Row(
            children: <Widget>[
              Container(
                width: 130,
                child: Text(
                  "${cityTrans[0].toUpperCase()}${cityTrans.substring(1)}",
                  style: TextStyle(
                    fontSize: AppFontSize.textButton,
                    fontWeight: FontWeight.bold,
                    color: AppColors.normal,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        InputTextField(
                          controller: viewModel.cityController,
                          hintText: allTranslations.text(AppLanguages.city),
                          inputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          fontSize: AppFontSize.textQuestion,
                          isDense: true,
                          onSubmitted: (text) {},
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
  }

  Widget _buildWorkingDays(EditProfileViewModel viewModel, bool hasInternet) {
    return StreamBuilder<List<WeekDay>>(
      stream: viewModel.selectedWorkingDays,
      builder: (context, snapshot) {
        List<WeekDay> selectedDays = snapshot.data ?? [];

        return InkWell(
          onTap: hasInternet ? viewModel.selectWorkingDays : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                allTranslations.text(AppLanguages.workingDays),
                style: TextStyle(
                  fontSize: AppFontSize.textButton,
                  fontWeight: FontWeight.bold,
                  color: AppColors.normal,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(WeekDay.values.length, (index) {
                  WeekDay day = WeekDay.values[index];
                  bool isSelected = selectedDays.contains(day);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        day.name[0],
                        style: TextStyle(
                          fontSize: AppFontSize.textButton,
                          fontWeight: FontWeight.bold,
                          color: AppColors.normal,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: isSelected ? Colors.black38 : Colors.black12),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 4,
                                offset: Offset(2, 5)),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDeleteAccount(EditProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: OutlinedButton(
        onPressed: viewModel.deleteAccount,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          side: BorderSide.none,
          minimumSize: Size(170, 40),
          backgroundColor: AppColors.slidableRed,
        ),
        child: Text(
          allTranslations.text(AppLanguages.deleteAccount),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
