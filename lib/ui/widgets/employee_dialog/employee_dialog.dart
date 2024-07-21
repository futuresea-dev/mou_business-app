import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'employee_dialog_viewmodel.dart';

class EmployeeDialog extends StatelessWidget {
  final Employee? employeeSelected;
  final Function(Employee employee)? onCallBack;
  final bool isEmployee;

  EmployeeDialog({
    this.employeeSelected,
    this.onCallBack,
    this.isEmployee = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBody(
      statusBarColor: AppColors.bgColor,
      systemNavigationBarColor: AppColors.bgColor,
      child: BaseWidget<EmployeeDialogViewModel>(
        viewModel: EmployeeDialogViewModel(
          employeeRepository: Provider.of(context),
          employeeDao: Provider.of(context),
          isEmployee: isEmployee,
        ),
        onViewModelReady: (viewModel) => viewModel..initData(employeeSelected ?? Employee(id: 0)),
        builder: (context, viewModel, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: AppColors.bgColor,
              padding: const EdgeInsets.only(left: 30, right: 10, top: 50),
              child: Column(
                children: <Widget>[
                  _buildHeader(context, viewModel),
                  _buildBody(context, viewModel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, EmployeeDialogViewModel viewModel) {
    return Expanded(
      child: StreamBuilder<List<Employee>>(
        stream: viewModel.employeesSubject,
        builder: (context, snapShot) {
          var data = snapShot.data;
          if (data == null) {
            return Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: LoadingAnimationWidget.staggeredDotsWave(color: AppColors.menuBar, size: 40),
            );
          } else {
            if (data.isEmpty) {
              return const SizedBox();
            } else {
              return RefreshIndicator(
                color: AppColors.normal,
                backgroundColor: Colors.white,
                onRefresh: viewModel.onRefresh,
                child: AnimationList(
                  duration: AppConstants.ANIMATION_LIST_DURATION,
                  reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
                  children: data.map((e) => _buildItem(e, viewModel)).toList(),
                ),
              );
            }
          }
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, EmployeeDialogViewModel viewModel) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: AppColors.textPlaceHolder, width: 1.0),
            ),
            child: Container(
              height: 35,
              color: AppColors.bgColor,
              padding: const EdgeInsets.only(left: 17),
              child: TextField(
                style: TextStyle(fontSize: AppFontSize.textDatePicker, color: AppColors.normal),
                decoration: InputDecoration(
                  hintText: allTranslations.text(AppLanguages.searchInputText),
                  suffixIcon: Icon(Icons.search),
                  isDense: true,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: AppFontSize.textQuestion,
                    color: AppColors.bgColor,
                  ),
                ),
                onChanged: viewModel.search,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            this.onCallBack!(
              viewModel.employeeSelected ?? Employee(id: 0), // TODO id is static
            );
            Navigator.of(context).pop();
          },
          icon: Image.asset(
            AppImages.icAccept,
            height: 14,
            width: 23.5,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  Widget _buildItem(Employee employee, EmployeeDialogViewModel viewModel) {
    final Map<String, dynamic> contact = employee.contact ?? {};
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0),
      leading: Container(
        height: 41,
        width: 65,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: contact["avatar"] != null
              ? DecorationImage(
                  image: NetworkImage(contact["avatar"]),
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
      title: StreamBuilder<Employee>(
        stream: viewModel.employeeSelectedSubject,
        builder: (context, snapShot) {
          final String name = contact["name"] ?? "";
          return Text(
            name,
            style: TextStyle(
              color: AppColors.normal,
              fontSize: AppFontSize.nameList,
              fontWeight: viewModel.checkSelected(employee) ? FontWeight.bold : FontWeight.normal,
            ),
          );
        },
      ),
      onTap: () => viewModel.setContactSelected(employee),
    );
  }
}
