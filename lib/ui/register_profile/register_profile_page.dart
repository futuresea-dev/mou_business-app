import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/country_phone_code.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/choose_photo_dialog.dart';
import 'package:mou_business_app/ui/widgets/country_phone_code_dialog.dart';
import 'package:mou_business_app/ui/widgets/input_text_field.dart';
import 'package:mou_business_app/ui/widgets/input_text_field_container.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_globals.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'register_profile_viewmodel.dart';

class RegisterProfilePage extends StatelessWidget {
  const RegisterProfilePage();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RegisterProfileViewModel>(
      viewModel: RegisterProfileViewModel(Provider.of(context)),
      onViewModelReady: (viewModel) => viewModel,
      builder: (context, viewModel, child) {
        return StreamBuilder<bool>(
          stream: viewModel.loadingSubject,
          builder: (context, snapshot) {
            bool isLoading = snapshot.data ?? false;
            return LoadingFullScreen(
              loading: isLoading,
              child: Scaffold(
                //resizeToAvoidBottomPadding: false,
                key: viewModel.scaffoldKey,
                body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: SingleChildScrollView(
                    child: _buildBody(context, viewModel),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, RegisterProfileViewModel viewModel) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(AppImages.bgRegister), fit: BoxFit.fill),
      ),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 40, left: 5),
              child: IconButton(
                onPressed: () => AppGlobals.logout(context),
                icon: Image.asset(
                  AppImages.icClose,
                  height: 15,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: <Widget>[
                _buildAvatar(context, viewModel),
                const SizedBox(height: 20),
                _buildInputName(context, viewModel),
                const SizedBox(height: 20),
                _buildInputEmail(context, viewModel),
                const SizedBox(height: 20),
                _buildInputCountry(context, viewModel),
                const SizedBox(height: 20),
                _buildInputCity(context, viewModel),
                const SizedBox(height: 35),
                _buildButtonFinish(context, viewModel),
                const SizedBox(height: 20)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, RegisterProfileViewModel viewModel) {
    final width = MediaQuery.sizeOf(context).width;
    final widthContainer = width - 100;
    final heightContainer = widthContainer / 4 * 2.5;
    return InkWell(
      onTap: () {
        _showChoosePhotoDialog(context, viewModel);
        viewModel.changeFinishBackground();
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          StreamBuilder<File?>(
            stream: viewModel.logoFileSubject,
            builder: (context, snapshot) {
              File? avatar = snapshot.data;
              return Container(
                width: widthContainer,
                height: heightContainer,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2), blurRadius: 4, offset: Offset(2, 5))
                    ]),
                child: avatar != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          avatar,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            AppImages.icAdd,
                            width: 27,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
              );
            },
          ),
          StreamBuilder<bool>(
            stream: viewModel.logoLoadingSubject,
            builder: (context, snapShot) {
              bool loading = snapShot.data ?? false;
              if (loading) {
                return LoadingAnimationWidget.staggeredDotsWave(color: AppColors.menuBar, size: 40);
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildInputName(BuildContext context, RegisterProfileViewModel viewModel) {
    return InputTextFieldContainer(
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: InputTextField(
          initFocusNode: viewModel.nameFocusNode,
          controller: viewModel.nameController,
          hintText: allTranslations.text(AppLanguages.name),
          inputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          fontSize: AppFontSize.subQuestion,
          onSaved: (_) => viewModel.changeFinishBackground(),
          onChanged: (_) => viewModel.changeFinishBackground(),
          onSubmitted: (_) => viewModel.changeFinishBackground(),
        ),
      ),
    );
  }

  Widget _buildInputEmail(BuildContext context, RegisterProfileViewModel viewModel) {
    return InputTextFieldContainer(
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: InputTextField(
          initFocusNode: viewModel.emailFocusNode,
          controller: viewModel.emailController,
          hintText: allTranslations.text(AppLanguages.email),
          inputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          fontSize: AppFontSize.subQuestion,
          onSaved: (_) => viewModel.changeFinishBackground(),
          onChanged: (_) => viewModel.changeFinishBackground(),
          onSubmitted: (_) => viewModel.changeFinishBackground(),
        ),
      ),
    );
  }

  Widget _buildInputCountry(BuildContext context, RegisterProfileViewModel viewModel) {
    return InkWell(
      onTap: () {
        _showCountryDialog(context, viewModel);
        viewModel.changeFinishBackground();
      },
      child: InputTextFieldContainer(
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: StreamBuilder<CountryPhoneCode?>(
            stream: viewModel.countrySubject,
            builder: (context, snapShot) {
              var country = snapShot.data;
              if (snapShot.hasData) {
                return Text(
                  country?.name ?? "",
                  style: TextStyle(
                    fontSize: AppFontSize.textButton,
                    color: AppColors.normal,
                  ),
                );
              } else {
                return Text(
                  allTranslations.text(AppLanguages.country),
                  style: TextStyle(
                    fontSize: AppFontSize.textButton,
                    color: AppColors.textPlaceHolder,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInputCity(BuildContext context, RegisterProfileViewModel viewModel) {
    return InputTextFieldContainer(
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: InputTextField(
          initFocusNode: viewModel.cityFocusNode,
          controller: viewModel.cityController,
          hintText: allTranslations.text(AppLanguages.city),
          inputType: TextInputType.text,
          textInputAction: TextInputAction.done,
          fontSize: AppFontSize.subQuestion,
          onSaved: (_) => viewModel.changeFinishBackground(),
          onChanged: (_) => viewModel.changeFinishBackground(),
          onSubmitted: (_) => viewModel.changeFinishBackground(),
        ),
      ),
    );
  }

  Widget _buildButtonFinish(BuildContext context, RegisterProfileViewModel viewModel) {
    return StreamBuilder<bool>(
      stream: viewModel.finishBackgroundSubject,
      builder: (context, snapshot) {
        final isEnable = snapshot.data ?? false;
        return InkWell(
            onTap: isEnable ? viewModel.onFinish : null,
            child: Image.asset(
              AppImages.btnActive,
              width: 60,
            ));
      },
    );
  }

  void _showCountryDialog(BuildContext context, RegisterProfileViewModel viewModel) {
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return SizedBox();
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

  void _showChoosePhotoDialog(BuildContext context, RegisterProfileViewModel viewModel) {
    bool loading = viewModel.logoLoadingSubject.valueOrNull ?? false;
    if (!loading) {
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
}
