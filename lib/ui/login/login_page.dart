import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mou_business_app/core/models/country_phone_code.dart';
import 'package:mou_business_app/helpers/common_helper.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/login/login_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/country_phone_code_dialog.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final Map<String, dynamic>? message;

  const LoginPage({super.key, required this.message});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      viewModel: LoginViewModel(
        authRepository: Provider.of(context),
        service: Provider.of(context),
      ),
      onViewModelReady: (viewModel) => _viewModel = viewModel..init(widget.message),
      builder: (context, viewModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: viewModel.scaffoldKey,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.bgLogin),
                  fit: BoxFit.fill,
                ),
              ),
              child: _buildBody(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            children: <Widget>[
              const Spacer(flex: 15),
              Image.asset(
                AppImages.logoLogin,
                width: 280,
                fit: BoxFit.cover,
              ),
              const Spacer(flex: 8),
              _buildInputPhone(context),
              const Spacer(flex: 1),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            children: <Widget>[
              const Spacer(flex: 1),
              _buildButtonLogin(context),
              const Spacer(flex: 325),
              _buildChangeNumberButton(),
              const Spacer(flex: 9),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildChangeNumberButton() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routers.SEND_EMAIL),
      child: SizedBox(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            allTranslations.text(AppLanguages.changeNumber),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputPhone(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 210),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            allTranslations.text(AppLanguages.phoneNumber),
            style: TextStyle(
              fontSize: 16,
              color: AppColors.header,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              _buildButtonPhoneCode(context),
              const SizedBox(width: 5),
              Expanded(
                child: Center(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: AppColors.normal,
                      height: 1,
                    ),
                    keyboardType: TextInputType.phone,
                    controller: _viewModel.phoneNumberController,
                    onSubmitted: (_) => _viewModel.onPressedLogin(),
                    decoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: Platform.isIOS ? 1 : 0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButtonPhoneCode(BuildContext context) {
    return InkWell(
      splashColor: Colors.black,
      onTap: () => _showPhoneCodeDialog(context),
      child: StreamBuilder<CountryPhoneCode>(
        stream: _viewModel.phoneCodeSubject,
        builder: (context, snapshot) {
          final phoneCode = snapshot.data;

          return Row(
            children: <Widget>[
              SizedBox(
                height: 22,
                child: Image.asset(
                  phoneCode != null
                      ? CommonHelper.getFlagPath(phoneCode.code.toLowerCase())
                      : AppImages.flagUSA,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                phoneCode != null ? phoneCode.dialCode : "+1",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.normal,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildButtonLogin(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _viewModel.loadingSubject,
      builder: (context, loadingSnapshot) {
        bool isLoading = loadingSnapshot.data ?? false;
        return Column(
          children: [
            SizedBox(height: isLoading ? 15 : 25),
            StreamBuilder<String>(
              stream: _viewModel.phoneNumberSubject,
              builder: (context, snapshot) {
                final String phoneText = snapshot.data ?? '';
                return isLoading
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: LottieBuilder.asset(
                          AppImages.animLoginLoading,
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                          repeat: true,
                        ),
                      )
                    : InkWell(
                        onTap: phoneText.isNotEmpty ? _viewModel.onPressedLogin : null,
                        borderRadius: BorderRadius.circular(35),
                        child: Image.asset(
                          AppImages.btnActive,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      );
              },
            ),
          ],
        );
      },
    );
  }

  void _showPhoneCodeDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => SizedBox(),
      context: context,
      transitionBuilder: (context, animation1, animation2, widget) {
        return Transform.scale(
          scale: animation1.value,
          child: Opacity(
            opacity: animation1.value,
            child: WillPopScope(
              onWillPop: () async => false,
              child: CountryPhoneCodeDialog(
                phoneCodeCallBack: _viewModel.changePhoneCode,
                title: allTranslations.text(AppLanguages.phoneCodes),
                isPhoneCode: false,
              ),
            ),
          ),
        );
      },
    );
  }
}
