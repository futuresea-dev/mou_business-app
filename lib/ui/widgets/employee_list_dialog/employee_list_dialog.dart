import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/employee_list_dialog/employee_list_dialog_viewmodel.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EmployeeListDialog extends StatelessWidget {
  final List<Employee>? employeesSelected;
  final Function(List<Employee> contacts)? onCallBack;
  final bool isEmployee;
  final bool isMulti;

  EmployeeListDialog({
    this.employeesSelected,
    this.onCallBack,
    this.isEmployee = false,
    this.isMulti = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBody(
      statusBarColor: AppColors.bgColor,
      systemNavigationBarColor: AppColors.bgColor,
      child: BaseWidget<EmployeeListDialogViewModel>(
        viewModel: EmployeeListDialogViewModel(
          employeeRepository: Provider.of(context),
          employeeDao: Provider.of(context),
          isEmployee: isEmployee,
          isMulti: isMulti,
        ),
        onViewModelReady: (viewModel) => viewModel..initData(employeesSelected ?? []),
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

  Widget _buildBody(BuildContext context, EmployeeListDialogViewModel viewModel) {
    return Expanded(
      child: StreamBuilder<List<Employee>>(
        stream: viewModel.employeesSubject,
        builder: (context, snapShot) {
          var data = snapShot.data ?? null;
          if (data == null) {
            return Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: LoadingAnimationWidget.staggeredDotsWave(color: AppColors.menuBar, size: 40),
            );
          } else {
            if (data.length == 0) {
              return SizedBox();
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

  Widget _buildHeader(BuildContext context, EmployeeListDialogViewModel viewModel) {
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
                    hintStyle:
                        TextStyle(fontSize: AppFontSize.textQuestion, color: AppColors.bgColor)),
                onChanged: viewModel.search,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            onCallBack!(viewModel.employeesSelected);
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

  Widget _buildItem(Employee employee, EmployeeListDialogViewModel viewModel) {
    final String name = employee.contact?["name"] ?? "";
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0),
      leading: Container(
        height: 43,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: employee.contact?["avatar"] == null
              ? null
              : DecorationImage(
                  image: NetworkImage(employee.contact?["avatar"]),
                  fit: BoxFit.cover,
                ),
        ),
      ),
      title: StreamBuilder<List<Employee>>(
        stream: viewModel.employeesSelectedSubject,
        builder: (context, snapShot) {
          return Text(
            name,
            style: TextStyle(
              fontSize: AppFontSize.nameList,
              color: AppColors.normal,
              fontWeight: viewModel.checkSelected(employee) ? FontWeight.bold : FontWeight.normal,
            ),
          );
        },
      ),
      onTap: () => viewModel.setEmployeeSelected(employee),
    );
  }
}
