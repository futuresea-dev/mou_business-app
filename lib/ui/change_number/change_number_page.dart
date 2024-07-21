import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/country_phone_code.dart';
import 'package:mou_business_app/core/requests/change_phone_request.dart';
import 'package:mou_business_app/helpers/common_helper.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/country_phone_code_dialog.dart';
import 'package:mou_business_app/ui/widgets/expanded_child_scroll_view.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:provider/provider.dart';

import 'change_number_viewmodel.dart';

class ChangeNumberPage extends StatelessWidget {
  final ChangeNumberRequest request;

  ChangeNumberPage({required this.request});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChangeNumberViewModel>(
      viewModel: ChangeNumberViewModel(Provider.of(context)),
      onViewModelReady: (viewModel) => viewModel..fetchData(request.dialCode),
      builder: (context, viewModel, child) {
        return StreamBuilder<bool>(
          stream: viewModel.loadingSubject,
          builder: (context, snapshot) {
            final bool isLoading = snapshot.data ?? false;
            return LoadingFullScreen(
              loading: isLoading,
              child: Scaffold(
                key: viewModel.scaffoldKey,
                body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.bgRegister),
                        fit: BoxFit.fill,
                      ),
                    ),
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

  Widget _buildBody(BuildContext context, ChangeNumberViewModel viewModel) {
    return ExpandedChildScrollView(
      child: Column(
        children: <Widget>[
          _buildBackButton(context),
          _buildTitle(),
          Expanded(flex: 290, child: SizedBox(height: 24)),
          _buildDescription(),
          Expanded(flex: 105, child: SizedBox(height: 24)),
          _buildInputTitle(allTranslations.text(AppLanguages.from)),
          SizedBox(height: 4),
          _buildInputPhone(viewModel),
          SizedBox(height: 30),
          _buildInputTitle(allTranslations.text(AppLanguages.to)),
          SizedBox(height: 4),
          _buildInputNewPhone(viewModel),
          Expanded(flex: 90, child: SizedBox(height: 24)),
          _buildButtonNext(viewModel),
          Expanded(flex: 389, child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 40),
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: RotationTransition(
          turns: new AlwaysStoppedAnimation(180 / 360),
          child: Image.asset(AppImages.icArrowNext, width: 12),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      allTranslations.text(AppLanguages.changeNumber).toUpperCase(),
      style: TextStyle(
        color: AppColors.normal,
        fontSize: AppFontSize.textTitlePage,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            allTranslations.text(AppLanguages.pleaseEnterNewNumber),
            style: TextStyle(
              color: AppColors.normal,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 14),
          Text(
            allTranslations.text(AppLanguages.weWillSendAVerificationCodeToYou),
            style: TextStyle(
              color: AppColors.textHint,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(fontSize: 14, color: AppColors.textHint),
        ),
      ),
    );
  }

  Widget _buildInputPhone(ChangeNumberViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 27),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xffe1e1e1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15.0,
            offset: Offset(0, 11),
          )
        ],
      ),
      child: Row(
        children: [
          _buildDialCode(viewModel),
          SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              style: TextStyle(fontSize: 14),
              initialValue: request.phoneNumber,
              keyboardType: TextInputType.phone,
              onChanged: viewModel.onNewPhoneChanged,
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: allTranslations.text(AppLanguages.number),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputNewPhone(ChangeNumberViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 27),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15.0,
            offset: Offset(0, 11),
          )
        ],
      ),
      child: Row(
        children: [
          _buildNewDialCode(viewModel),
          SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              style: TextStyle(fontSize: 14),
              keyboardType: TextInputType.phone,
              controller: viewModel.newPhoneController,
              onChanged: viewModel.onNewPhoneChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: allTranslations.text(AppLanguages.number),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewDialCode(ChangeNumberViewModel viewModel) {
    return StreamBuilder<CountryPhoneCode?>(
      stream: viewModel.dialCodeSubject,
      builder: (context, snapshot) {
        final phoneCode = snapshot.data;
        return InkWell(
          splashColor: Colors.black,
          onTap: () => _showDialog(context, viewModel),
          child: Container(
            child: Row(
              children: <Widget>[
                Image.asset(
                  phoneCode != null
                      ? CommonHelper.getFlagPath(phoneCode.code.toLowerCase())
                      : AppImages.flagUSA,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 5),
                Text(
                  phoneCode?.dialCode ?? "+1",
                  style: TextStyle(fontSize: 14, color: Color(0xff8b8986)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonNext(ChangeNumberViewModel viewModel) {
    return StreamBuilder<bool>(
      stream: viewModel.activeSubject,
      builder: (context, snapshot) {
        final bool isActive = snapshot.data ?? false;
        return InkWell(
          onTap: isActive ? () => viewModel.onSubmitPressed(request) : null,
          child: Container(
            width: 160,
            constraints: BoxConstraints(minHeight: 32),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    isActive ? AssetImage(AppImages.btnActive) : AssetImage(AppImages.btnUnActive),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              AppUtils.firstUpperCase(allTranslations.text(AppLanguages.done)),
              style: TextStyle(
                color: Colors.black,
                fontSize: AppFontSize.textButton,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _showDialog(BuildContext context, ChangeNumberViewModel viewModel) {
    return showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => SizedBox(),
      context: context,
      transitionBuilder: (context, animation1, animation2, widget) {
        return Transform.scale(
          scale: animation1.value,
          child: Opacity(
            opacity: animation1.value,
            child: WillPopScope(
              onWillPop: () => Future.value(false),
              child: CountryPhoneCodeDialog(
                phoneCodeCallBack: viewModel.changeDialCode,
                title: allTranslations.text(AppLanguages.phoneCodes),
                isPhoneCode: false,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialCode(ChangeNumberViewModel viewModel) {
    return StreamBuilder<List<CountryPhoneCode>>(
      stream: viewModel.dialCodesSubject,
      builder: (context, snapshot) {
        final List<CountryPhoneCode> dialCodes = snapshot.data ?? [];
        if (dialCodes.isEmpty) return SizedBox();
        final CountryPhoneCode? dialCode = dialCodes.firstWhereOrNull(
            (element) => request.dialCode.isNotEmpty && element.dialCode == request.dialCode);
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              CommonHelper.getFlagPath(dialCode?.code != null ? dialCode!.code.toLowerCase() : ''),
              fit: BoxFit.cover,
            ),
            SizedBox(width: 5),
            Text(
              dialCode?.dialCode ?? "+1",
              style: TextStyle(fontSize: 14, color: Color(0xff8b8986)),
            )
          ],
        );
      },
    );
  }
}
