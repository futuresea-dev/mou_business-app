import 'package:flutter/material.dart' hide MenuBar;
import 'package:lottie/lottie.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/add_employee/add_employee_viewmodel.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_header.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/bottom_sheet_custom.dart';
import 'package:mou_business_app/ui/widgets/contact_dialog/contact_dialog.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:provider/provider.dart';

class AddEmployeePage extends StatelessWidget {
  final Employee? employee;

  AddEmployeePage({this.employee});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AddEmployeeViewModel>(
      viewModel: AddEmployeeViewModel(employeeRepository: Provider.of(context), employee: employee),
      onViewModelReady: (viewModel) => viewModel..initData(),
      builder: (context, viewModel, child) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          viewModel.isTypingRole.add(viewModel.employeeRoleController.text.trim().isNotEmpty);
        },
        child: Scaffold(
          key: viewModel.scaffoldKey,
          body: AppBody(
            child: StreamBuilder<bool>(
              stream: viewModel.loadingSubject,
              builder: (context, snapShot) {
                bool isLoading = snapShot.data ?? false;
                return LoadingFullScreen(
                  loading: isLoading,
                  child: AppContent(
                    headerBuilder: (hasInternet) => _buildHeader(context, viewModel, hasInternet),
                    childBuilder: (_) => _buildBody(context, viewModel),
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

  Widget _buildHeader(BuildContext context, AddEmployeeViewModel viewModel, bool hasInternet) {
    return AppHeader(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 12),
            child: IconButton(
              icon: Image.asset(AppImages.icClose, width: 16),
              onPressed: viewModel.goBack,
            ),
          ),
          const Spacer(flex: 1),
          Container(
            height: 70,
            alignment: Alignment.center,
            child: IconButton(
              icon: Hero(
                tag: 'imageEmployee',
                child: Image.asset(AppImages.icTeamHeader),
              ),
              iconSize: 50,
              padding: const EdgeInsets.only(bottom: 22),
              onPressed:
                  hasInternet ? () => AppUtils.openLink(AppConstants.leadershipScopeLink) : null,
            ),
          ),
          const Spacer(flex: 1),
          IconButton(
            iconSize: 50,
            onPressed: hasInternet ? viewModel.addEmployee : null,
            icon: hasInternet
                ? Image.asset(
                    AppImages.icAccept,
                    height: 15,
                    fit: BoxFit.fitHeight,
                  )
                : const SizedBox(height: 15),
            padding: const EdgeInsets.only(bottom: 25, right: 12),
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, AddEmployeeViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: <Widget>[
          _buildEmployeeName(context, viewModel),
          _buildEmployeeRole(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildEmployeeName(BuildContext context, AddEmployeeViewModel viewModel) {
    return Container(
      height: 65,
      child: Row(
        children: <Widget>[
          StreamBuilder<bool?>(
            stream: viewModel.isTypingTagSomeOne,
            builder: (context, snapshot) {
              bool isShowAnim = snapshot.data ?? false;
              return Container(
                alignment: Alignment.centerLeft,
                width: 40,
                child: isShowAnim
                    ? Lottie.asset(
                        AppImages.animTagSomeOne,
                        width: 24,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icTagSomeOne,
                        height: 23,
                        width: 20.5,
                        fit: BoxFit.cover,
                      ),
              );
            },
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (employee == null) {
                  _showContactsDialog(context, viewModel);
                }
              },
              child: StreamBuilder<String>(
                stream: viewModel.contactSubject,
                builder: (context, snapShot) {
                  var data = snapShot.data ?? "";
                  return Text(
                    data.isEmpty ? allTranslations.text(AppLanguages.tagSomeone) : data,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: data.isEmpty ? AppColors.textPlaceHolder : AppColors.normal,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEmployeeRole(BuildContext context, AddEmployeeViewModel viewModel) {
    return Container(
      height: 65,
      child: Row(
        children: <Widget>[
          StreamBuilder<bool?>(
            stream: viewModel.isTypingRole,
            builder: (context, snapshot) {
              final isEnableAnim = snapshot.data ?? false;
              return Container(
                alignment: Alignment.centerLeft,
                width: 40,
                child: isEnableAnim
                    ? Lottie.asset(
                        AppImages.animRole,
                        width: 28,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icEmployeeRole,
                        width: 27,
                      ),
              );
            },
          ),
          Expanded(
            child: TextFormField(
              focusNode: viewModel.employeeRoleFocusNode,
              controller: viewModel.employeeRoleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: allTranslations.text(AppLanguages.employeeRole),
                hintStyle: TextStyle(color: AppColors.textPlaceHolder),
              ),
              textInputAction: TextInputAction.done,
              style: TextStyle(
                fontSize: AppFontSize.textDatePicker,
                color: AppColors.normal,
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  viewModel.isTypingRole.add(false);
                }
              },
              onFieldSubmitted: (value) {
                viewModel.employeeRoleFocusNode.unfocus();
                viewModel.isTypingRole.add(value.trim().isNotEmpty);
              },
            ),
          )
        ],
      ),
    );
  }

  void _showContactsDialog(BuildContext context, AddEmployeeViewModel viewModel) {
    final height = MediaQuery.sizeOf(context).height;
    showModalBottomSheetCustom(
      context: context,
      builder: (context) {
        return SizedBox(
          height: height,
          child: ContactDialog(
            contactSelected: viewModel.contact,
            onCallBack: (contact) {
              viewModel.setContact(contact);
              viewModel.isTypingTagSomeOne.add(contact != null);
            },
          ),
        );
      },
    );
  }
}
