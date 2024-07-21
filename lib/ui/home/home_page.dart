import 'package:flutter/material.dart' hide MenuBar;
import 'package:mou_business_app/constants/constants.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/home/home_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_header.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final bool openCalendar;

  const HomePage({super.key, required this.openCalendar});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      viewModel: HomeViewModel(
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
      ),
      onViewModelReady: (viewModel) => viewModel.init(openCalendar),
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: StreamBuilder<bool>(
          stream: viewModel.showUISubject,
          builder: (context, snapshot) {
            final bool showUI = snapshot.data ?? false;
            if (!showUI)
              return Container(
                color: AppColors.bgColor,
                constraints: BoxConstraints.expand(),
              );
            return StreamBuilder<bool>(
              stream: viewModel.loadingSubject,
              builder: (context, snapshot) {
                final bool loading = snapshot.data ?? false;
                return LoadingFullScreen(
                  loading: loading,
                  child: Scaffold(
                    key: viewModel.scaffoldKey,
                    body: AppBody(
                      child: AppContent(
                        headerBuilder: (_) => AppHeader(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Image.asset(
                              AppImages.add_header,
                              height: 50,
                            ),
                          ),
                        ),
                        childBuilder: (hasInternet) =>
                            _buildContent(context, viewModel, hasInternet),
                        menuBar: const AppMenuBar(),
                        headerImage: AssetImage(AppImages.bgTopHeaderNewRoster),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, HomeViewModel viewModel, bool hasInternet) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      height: size.height - 93,
      width: size.width,
      child: hasInternet
          ? ListView(
              padding: const EdgeInsets.symmetric(vertical: 35),
              children: <Widget>[
                _buildBtnAddProject(context),
                const SizedBox(height: 43),
                _buildBtnAddTask(context),
                const SizedBox(height: 43),
                _buildBtnAddRoster(context),
                const SizedBox(height: 43),
                _buildBtnAddEmployee(context, viewModel),
              ],
            )
          : const SizedBox(),
    );
  }

  Widget _buildBtnAddTask(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routers.ADD_TASK);
      },
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'imageTask',
            child: Image.asset(
              AppImages.icAddTask,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            allTranslations.text(AppLanguages.task).toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              color: Constants.grayPrimaryText,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBtnAddProject(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routers.ADD_PROJECT),
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'imageProject',
            child: Image.asset(
              AppImages.icAddProject,
              height: 58,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            allTranslations.text(AppLanguages.project).toUpperCase(),
            style: TextStyle(
                fontSize: 18, color: Constants.grayPrimaryText, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _buildBtnAddEmployee(BuildContext context, HomeViewModel viewModel) {
    return InkWell(
      onTap: viewModel.onAddEmployee,
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'imageEmployee',
            child: Image.asset(
              AppImages.icAddEmployee,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            allTranslations.text(AppLanguages.employees).toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              color: Constants.grayPrimaryText,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  _buildBtnAddRoster(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routers.ADD_ROSTER),
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'imageRoster',
            child: Image.asset(
              AppImages.icRoster,
              width: 58,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            allTranslations.text(AppLanguages.roster).toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              color: Constants.grayPrimaryText,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
