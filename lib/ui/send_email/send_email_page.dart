import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/expanded_child_scroll_view.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';

import 'send_email_viewmodel.dart';

class SendEmailPage extends StatelessWidget {
  SendEmailPage();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SendEmailViewModel>(
      viewModel: SendEmailViewModel(Provider.of(context)),
      builder: (context, viewModel, child) {
        return StreamBuilder<bool>(
          stream: viewModel.loadingSubject,
          builder: (context, snapshot) {
            final bool isLoading = snapshot.data ?? false;
            return LoadingFullScreen(
              loading: isLoading,
              child: Scaffold(
                key: viewModel.scaffoldKey,
                resizeToAvoidBottomInset: false,
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

  Widget _buildBody(BuildContext context, SendEmailViewModel viewModel) {
    return ExpandedChildScrollView(
      child: Column(
        children: [
          _buildCloseButton(context),
          SizedBox(height: 180),
          _buildDescription(),
          SizedBox(height: 40),
          _buildInputEmail(viewModel),
          SizedBox(height: 35),
          _buildButtonNext(viewModel),
          Spacer(flex: 389),
        ],
      ),
    );
  }

  Widget _buildInputEmail(SendEmailViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(2, 5)
          )
        ],
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 16, color: AppColors.normal),
        keyboardType: TextInputType.emailAddress,
        controller: viewModel.emailController,
        onChanged: viewModel.onEmailChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: allTranslations.text(AppLanguages.email),
          hintStyle: TextStyle(color: AppColors.textPlaceHolder)
        ),
      ),
    );
  }

  Widget _buildButtonNext(SendEmailViewModel viewModel) {
    return StreamBuilder<bool>(
      stream: viewModel.activeSubject,
      builder: (context, snapshot) {
        final bool isActive = snapshot.data ?? false;
        return InkWell(
          onTap: isActive ? viewModel.onSendPressed : null,
          child: Container(
            width: 160,
            height: 50,
            constraints: BoxConstraints(minHeight: 32),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: isActive
                    ? AssetImage(AppImages.btnActive)
                    : AssetImage(AppImages.btnUnActive),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            allTranslations.text(AppLanguages.pleaseEnterEmail),
            style: TextStyle(
              color: AppColors.normal,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 32),
          Text(
            allTranslations.text(AppLanguages.weWillSendAVerificationEmail),
            style: TextStyle(
              color: AppColors.normal,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 40, left:10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(AppImages.icClose, width: 16),
          ),
          Expanded(
              child: Align(
               alignment: Alignment.center,
                child: Padding(
                padding: EdgeInsets.only(right:50),
                child:Text(
                allTranslations.text(AppLanguages.changeNumber).toUpperCase(),
                style: TextStyle(
                color: AppColors.normal,
                fontSize: AppFontSize.textTitlePage,
                fontWeight: FontWeight.w500,
           ),
          ),
        ),
       ),
          )
        ],
      ),
    );
  }
}
