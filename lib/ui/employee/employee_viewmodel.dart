import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/core/repositories/employee_repository.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/managers/payments_manager.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:rxdart/rxdart.dart';

class EmployeeViewModel extends BaseViewModel {
  final EmployeeRepository employeeRepository;
  final EmployeeDao employeeDao;
  final PaymentsManager paymentsManager;

  EmployeeViewModel({
    required this.employeeRepository,
    required this.employeeDao,
    required this.paymentsManager,
  });

  final loadingEmployeeSubject = BehaviorSubject<bool>();

  void deleteEmployee(Employee employee) async {
    loadingSubject.add(true);
    final resource = await employeeRepository.deleteEmployee(employee.id);
    if (resource.isSuccess == true) {
      await employeeDao.deleteEmployee(employee);
      showSnackBar(
        allTranslations.text(AppLanguages.employeeDeletedSuccessfully),
        isError: false,
      );
    }
    loadingSubject.add(false);
  }

  Color setStatusColor(String status) => status == "W" ? Colors.yellow : Colors.red;

  String getMessageTooltip(String status) {
    return status == "W"
        ? allTranslations.text(AppLanguages.waitingForApproval)
        : allTranslations.text(AppLanguages.refuse);
  }

  Future<void> onRefresh() async {
    loadingEmployeeSubject.add(true);
    await employeeRepository.getEmployeeList();
    loadingEmployeeSubject.add(false);
  }

  void addEmployee() async {
    final int currentUsers = await employeeDao.getLocalEmployees().then((value) => value.length);
    final bool purchased = await paymentsManager.checkPurchased(context, currentUsers);
    if (purchased) {
      Navigator.pushNamed(context, Routers.ADD_EMPLOYEE).then((_) => onRefresh());
    }
  }

  @override
  void dispose() {
    loadingEmployeeSubject.close();
    super.dispose();
  }
}
