import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart' hide MenuBar;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/employee/employee_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_header.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/ui/widgets/slidable/app_slidable.dart';
import 'package:mou_business_app/ui/widgets/widget_image_network.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:mou_business_app/utils/types/slidable_action_type.dart';
import 'package:provider/provider.dart';

class EmployeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<EmployeeViewModel>(
      viewModel: EmployeeViewModel(
        employeeRepository: Provider.of(context),
        employeeDao: Provider.of(context),
        paymentsManager: Provider.of(context),
      ),
      onViewModelReady: (viewModel) => viewModel..onRefresh(),
      builder: (context, viewModel, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: viewModel.scaffoldKey,
          body: AppBody(
            child: StreamBuilder<bool>(
              stream: viewModel.loadingSubject,
              builder: (context, snapShot) {
                var loading = snapShot.data ?? false;
                return LoadingFullScreen(
                  loading: loading,
                  child: AppContent(
                    headerBuilder: (hasInternet) => _buildHeader(context, viewModel, hasInternet),
                    childBuilder: (hasInternet) => _buildContent(context, viewModel, hasInternet),
                    menuBar: const AppMenuBar(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, EmployeeViewModel viewModel, bool hasInternet) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        AppHeader(
          child: Container(
            height: 70,
            alignment: Alignment.center,
            child: IconButton(
              icon: Image.asset(AppImages.icTeamHeader),
              iconSize: 50,
              padding: const EdgeInsets.only(bottom: 22),
              onPressed: () => AppUtils.openLink(AppConstants.leadershipScopeLink),
            ),
          ),
        ),
        if (hasInternet)
          InkWell(
            onTap: viewModel.addEmployee,
            child: Image.asset(
              AppImages.icAdd_appBar,
              width: MediaQuery.of(context).size.width * 0.24,
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, EmployeeViewModel viewModel, bool hasInternet) {
    final employeeDao = Provider.of<EmployeeDao>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: StreamBuilder<bool>(
        stream: viewModel.loadingEmployeeSubject,
        builder: (context, snapshot) {
          final bool loading = snapshot.data ?? false;
          if (loading) {
            return Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.menuBar,
                size: 40,
              ),
            );
          }
          return StreamBuilder<List<Employee>>(
            stream: employeeDao.watchAllEmployees(),
            builder: (context, snapshot) {
              List<Employee> employees = snapshot.data ?? [];

              return RefreshIndicator(
                onRefresh: viewModel.onRefresh,
                child: employees.isNotEmpty
                    ? AnimationList(
                        duration: AppConstants.ANIMATION_LIST_DURATION,
                        reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        children: employees
                            .map((e) => _buildCell(
                                  context,
                                  viewModel,
                                  e,
                                  employees.indexOf(e),
                                  hasInternet,
                                ))
                            .toList(),
                      )
                    : Center(
                        child: Text(
                          allTranslations.text(AppLanguages.noData),
                          style: TextStyle(
                            fontSize: AppFontSize.nameList,
                            color: AppColors.normal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCell(
    BuildContext context,
    EmployeeViewModel viewModel,
    Employee employee,
    int index,
    bool hasInternet,
  ) {
    var avatar = employee.contact != null ? (employee.contact?["avatar"]) as String? : "";
    var name = employee.contact != null ? (employee.contact?["name"]) : "";
    var roleName = employee.roleName;
    var status = employee.employeeConfirm;
    final tooltipKey = GlobalKey();

    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routers.EDIT_EMPLOYEE, arguments: employee),
      child: AppSlidable<SlidableActionType>(
        key: ValueKey(index),
        enabled: hasInternet,
        actions: [
          SlidableActionType.EDIT,
          SlidableActionType.DELETE,
        ],
        onActionPressed: (type) {
          return switch (type) {
            SlidableActionType.EXPORT => null,
            SlidableActionType.EDIT => Navigator.pushNamed(
                context,
                Routers.EDIT_EMPLOYEE,
                arguments: employee,
              ),
            SlidableActionType.DELETE => viewModel.deleteEmployee(employee),
            SlidableActionType.ACCEPT => null,
            SlidableActionType.DENY => null,
          };
        },
        margin: const EdgeInsets.fromLTRB(28, 0, 28, 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(9)),
          ),
          child: Row(
            children: [
              WidgetImageNetwork(
                url: avatar ?? '',
                height: 35,
                width: 56,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: AppFontSize.textButton,
                        fontWeight: FontWeight.w500,
                        color: AppColors.normal,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      roleName ?? "",
                      style: TextStyle(
                        fontSize: AppFontSize.textButton,
                        fontWeight: FontWeight.normal,
                        color: AppColors.header,
                      ),
                    )
                  ],
                ),
              ),
              if (status != "Y")
                GestureDetector(
                  onTap: () {
                    final dynamic tooltip = tooltipKey.currentState;
                    tooltip.ensureTooltipVisible();
                  },
                  child: Tooltip(
                    key: tooltipKey,
                    message: viewModel.getMessageTooltip(status ?? ""),
                    padding: const EdgeInsets.all(10),
                    showDuration: const Duration(hours: 1),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: Colors.black12),
                    ),
                    textStyle: TextStyle(color: AppColors.normal),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.info,
                      color: viewModel.setStatusColor(status ?? "W"),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
