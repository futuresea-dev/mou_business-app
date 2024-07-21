import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide MenuBar;
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_header.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';

import 'setting_viewmodel.dart';

class SettingPage extends StatefulWidget {
  final String routeName;

  const SettingPage({super.key, required this.routeName});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    if (widget.routeName.isNotEmpty) {
      Future.delayed(
        Duration(milliseconds: 500),
        () => Navigator.pushNamed(context, widget.routeName),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SettingViewModel>(
      viewModel: SettingViewModel(Provider.of(context), Provider.of(context)),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        key: viewModel.scaffoldKey,
        body: StreamBuilder<bool>(
          stream: viewModel.loadingSubject,
          builder: (context, snapshot) {
            return LoadingFullScreen(
              loading: snapshot.data ?? false,
              child: AppBody(
                child: AppContent(
                  menuBar: const AppMenuBar(),
                  headerBuilder: (_) => _buildHeader(viewModel),
                  childBuilder: (hasInternet) => _buildContent(viewModel, hasInternet),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(SettingViewModel viewModel) {
    return AppHeader(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 32),
        child: Image.asset(
          AppImages.icSetting_g,
          height: 45,
        ),
      ),
    );
  }

  Widget _buildContent(SettingViewModel viewModel, bool hasInternet) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 20),
      children: <Widget>[
        _buildItem(
          iconWith: 36,
          pathIcon: AppImages.icAccount,
          title: allTranslations.text(AppLanguages.accountProfile),
          onPressed: () => Navigator.pushNamed(context, Routers.EDIT_PROFILE),
        ),
        _buildItem(
          iconWith: 30,
          pathIcon: AppImages.icStore_c,
          title: allTranslations.text(AppLanguages.stores),
          onPressed: () => Navigator.pushNamed(context, Routers.STORE),
        ),
        _buildItem(
          iconWith: 34,
          pathIcon: AppImages.icLanguage,
          title: allTranslations.text(AppLanguages.language),
          onPressed: () => _showBottomSheet(viewModel),
        ),
        _buildItem(
          iconWith: 30,
          pathIcon: AppImages.icDonate,
          title: allTranslations.text(AppLanguages.donate),
          onPressed: viewModel.onDonate,
        ),
        if (hasInternet)
          _buildItem(
            iconWith: 30,
            pathIcon: AppImages.icSubscription,
            title: allTranslations.text(AppLanguages.subscription),
            onPressed: () => Navigator.pushNamed(context, Routers.SUBSCRIPTION),
          ),
        _buildItem(
          iconWith: 30,
          pathIcon: AppImages.icFeedback,
          title: allTranslations.text(AppLanguages.feedback),
          onPressed: () => Navigator.pushNamed(context, Routers.FEEDBACK),
        ),
        _buildItem(
          iconWith: 40,
          pathIcon: AppImages.icMouLink,
          title: allTranslations.text(AppLanguages.moreAbout),
          onPressed: viewModel.onMouLink,
        ),
        if (hasInternet) _buildItemLogout(viewModel),
      ],
    );
  }

  Widget _buildItemLogout(SettingViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: GestureDetector(
          onTap: () => _showDialogConfirmLogout(viewModel),
          child: Image.asset(
            AppImages.icLogout,
            height: 60,
            width: 60,
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
    required String pathIcon,
    required String title,
    double? iconWith = 46,
    VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 35),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 46,
                child: Center(
                  child: Image.asset(
                    pathIcon,
                    fit: BoxFit.scaleDown,
                    width: iconWith,
                    color: AppColors.textHint,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showBottomSheet(SettingViewModel viewModel) async {
    return showModalBottomSheet(
      backgroundColor: AppColors.bgColor,
      context: context,
      elevation: 0,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      builder: (BuildContext bc) {
        var language = viewModel.languageSelected;
        return Container(
          padding: EdgeInsets.only(top: 5, bottom: 10),
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: Text(
                  allTranslations.text(AppLanguages.english),
                  style: TextStyle(
                    color: AppColors.normal,
                    fontWeight: language == "en" ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onTap: () => viewModel.updateLanguage('en'),
                contentPadding: contentPadding,
              ),
              ListTile(
                title: Text(
                  allTranslations.text(AppLanguages.portuguese),
                  style: TextStyle(
                    color: AppColors.normal,
                    fontWeight: language == "pt" ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onTap: () => viewModel.updateLanguage('pt'),
                contentPadding: contentPadding,
              ),
              ListTile(
                title: Text(
                  allTranslations.text(AppLanguages.spanish),
                  style: TextStyle(
                    color: AppColors.normal,
                    fontWeight: language == "es" ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onTap: () => viewModel.updateLanguage('es'),
                contentPadding: contentPadding,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDialogConfirmLogout(SettingViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(allTranslations.text(AppLanguages.logout).toUpperCase()),
          content: Text(allTranslations.text(AppLanguages.doYouWantLogOut)),
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
              onPressed: viewModel.onLogout,
            )
          ],
        );
      },
    );
  }

  final contentPadding = EdgeInsets.symmetric(horizontal: 28, vertical: 0);
}
