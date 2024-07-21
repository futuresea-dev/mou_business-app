import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mou_business_app/core/requests/change_phone_request.dart';
import 'package:mou_business_app/helpers/reg_ex_input_formatter.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/verification_code/verification_code_viewmodel.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerificationCodeDialog extends StatefulWidget {
  final VerifyType verifyType;
  final String dialCode;
  final String phoneNumber;
  final ChangeNumberRequest? changeNumberRequest;

  VerificationCodeDialog({
    super.key,
    required this.phoneNumber,
    required this.dialCode,
    required this.verifyType,
    this.changeNumberRequest,
  });

  @override
  State<VerificationCodeDialog> createState() => _VerificationCodeDialogState();
}

class _VerificationCodeDialogState extends State<VerificationCodeDialog> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<VerificationCodeViewModel>(
      viewModel: VerificationCodeViewModel(
        service: Provider.of(context),
        userRepository: Provider.of(context),
        authRepository: Provider.of(context),
        dialCode: widget.dialCode,
        phone: widget.phoneNumber,
        verifyType: widget.verifyType,
        changeNumberRequest: widget.changeNumberRequest,
      ),
      onViewModelReady: (viewModel) => viewModel..verifyPhone(),
      builder: (context, viewModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: viewModel.scaffoldKey,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.bgVerifyCode),
                fit: BoxFit.fill,
              ),
            ),
            child: _buildBody(context, viewModel),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, VerificationCodeViewModel viewModel) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Image.asset(
                    AppImages.icClose,
                    width: 16,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      allTranslations.text(AppLanguages.code).toUpperCase(),
                      style: TextStyle(
                        color: AppColors.header,
                        fontFamily: AppConstants.fontQuickSand,
                        fontSize: AppFontSize.textTitlePage,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const SizedBox(width: 16),
                )
              ],
            ),
          ),
          const Spacer(flex: 3),
          _buildInputCodeArea(context, viewModel),
          const Spacer(flex: 5),
        ],
      ),
    );
  }

  Widget _buildInputCodeArea(BuildContext context, VerificationCodeViewModel viewModel) {
    return StreamBuilder<bool>(
      stream: viewModel.loadingSubject,
      builder: (context, loadingSnapshot) {
        bool isLoading = loadingSnapshot.data ?? false;
        return Column(
          children: <Widget>[
            Text(
              allTranslations.text(AppLanguages.pleaseEnterVerifyCode),
              style: TextStyle(
                fontSize: AppFontSize.textQuestion,
                fontFamily: AppConstants.fontQuickSand,
                fontWeight: FontWeight.normal,
                color: AppColors.normal,
              ),
            ),
            const SizedBox(height: 55),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                textStyle: TextStyle(
                  color: AppColors.normal,
                  fontSize: AppFontSize.textQuestion,
                  fontFamily: AppConstants.fontQuickSand,
                  fontWeight: FontWeight.bold,
                ),
                obscureText: false,
                inputFormatters: [RegExInputFormatter.onlyNumber()],
                keyboardType: TextInputType.number,
                animationType: AnimationType.none,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 42,
                  activeColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  disabledColor: Colors.white,
                  activeBoxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  inActiveBoxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                controller: viewModel.pinCodeController,
                onChanged: viewModel.onTextChanged,
              ),
            ),
            StreamBuilder<bool>(
              stream: viewModel.isAcceptSubject,
              builder: (context, snapshot) {
                final bool enable = snapshot.data ?? false;
                return isLoading
                    ? Padding(
                        padding: EdgeInsets.only(right: 10, top: 48),
                        child: LottieBuilder.asset(
                          AppImages.animLoginLoading,
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                          repeat: true,
                        ),
                      )
                    : StreamBuilder<bool>(
                        stream: viewModel.showAnimDone,
                        builder: (context, doneSnapshot) {
                          bool showAnimDone = doneSnapshot.data ?? false;
                          return showAnimDone
                              ? Padding(
                                  padding: EdgeInsets.only(right: 2, top: 32),
                                  child: LottieBuilder.asset(
                                    AppImages.animLoginDone,
                                    height: 144,
                                    width: 144,
                                    fit: BoxFit.cover,
                                    repeat: true,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(top: 52),
                                  child: InkWell(
                                    onTap: enable ? viewModel.onPressRegisterCode : null,
                                    borderRadius: BorderRadius.circular(35),
                                    child: Image.asset(
                                      AppImages.btnActive,
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                        },
                      );
              },
            ),
          ],
        );
      },
    );
  }
}
