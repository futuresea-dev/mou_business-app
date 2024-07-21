import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/repositories/employee_repository.dart';
import 'package:mou_business_app/core/requests/add_employee_request.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:rxdart/rxdart.dart';

class AddEmployeeViewModel extends BaseViewModel {
  final EmployeeRepository employeeRepository;
  final Employee? employee;

  AddEmployeeViewModel({
    required this.employeeRepository,
    this.employee,
  });

  var employeeRoleController = TextEditingController();
  var employeeRoleFocusNode = FocusNode();

  final toggleAccessBusinessSubject = BehaviorSubject<bool>();
  final togglePermissionAddTaskSubject = BehaviorSubject<bool>();
  final togglePermissionAddProjectSubject = BehaviorSubject<bool>();
  final togglePermissionAddEmployeeSubject = BehaviorSubject<bool>();
  final togglePermissionAddRosterSubject = BehaviorSubject<bool>();
  final contactSubject = BehaviorSubject<String>();

  Contact? contact;

  final isTypingTagSomeOne = BehaviorSubject<bool?>();
  final isTypingRole = BehaviorSubject<bool?>();

  void initData() {
    if (employee != null) {
      contactSubject.add(employee?.contact?["name"] ?? "");
      employeeRoleController.text = employee?.roleName ?? '';

      final perBusiness = employee?.permissionAccessBusiness ?? 0;
      final perAddTask = employee?.permissionAddTask ?? 0;
      final perAddProject = employee?.permissionAddProject ?? 0;
      final perAddEmployee = employee?.permissionAddEmployee ?? 0;
      final perAddRoster = employee?.permissionAddRoster ?? 0;

      toggleAccessBusinessSubject.add(perBusiness == 1 ? true : false);
      togglePermissionAddTaskSubject.add(perAddTask == 1 ? true : false);
      togglePermissionAddProjectSubject.add(perAddProject == 1 ? true : false);
      togglePermissionAddEmployeeSubject.add(perAddEmployee == 1 ? true : false);
      togglePermissionAddRosterSubject.add(perAddRoster == 1 ? true : false);

      isTypingRole.add(employeeRoleController.text.trim().isNotEmpty);
      isTypingTagSomeOne.add(((employee?.contact?["name"] ?? "") as String).trim().isNotEmpty);
    }
  }

  void onToggleAccessBusiness() {
    var isOnAccessBusiness = toggleAccessBusinessSubject.valueOrNull ?? false;
    if (isOnAccessBusiness == true) {
      togglePermissionAddTaskSubject.add(false);
      togglePermissionAddProjectSubject.add(false);
      togglePermissionAddEmployeeSubject.add(false);
      togglePermissionAddRosterSubject.add(false);
    }
    this.toggleAccessBusinessSubject.add(!isOnAccessBusiness);
  }

  void onTogglePermissionAddTask() {
    if (this.toggleAccessBusinessSubject.valueOrNull != null &&
        this.toggleAccessBusinessSubject.valueOrNull == true) {
      var isOnPermissionAddTask = togglePermissionAddTaskSubject.valueOrNull ?? false;
      this.togglePermissionAddTaskSubject.add(!isOnPermissionAddTask);
    } else {
      showSnackBar(allTranslations.text(AppLanguages.validateSelectAccessToMouBusiness));
    }
  }

  void onTogglePermissionAddProject() {
    if (this.toggleAccessBusinessSubject.valueOrNull != null &&
        this.toggleAccessBusinessSubject.valueOrNull == true) {
      var isOnPermissionAddProject = togglePermissionAddProjectSubject.valueOrNull ?? false;
      this.togglePermissionAddProjectSubject.add(!isOnPermissionAddProject);
    } else {
      showSnackBar(allTranslations.text(AppLanguages.validateSelectAccessToMouBusiness));
    }
  }

  void onTogglePermissionAddEmployee() {
    if (this.toggleAccessBusinessSubject.valueOrNull != null &&
        this.toggleAccessBusinessSubject.valueOrNull == true) {
      var isOnPermissionAddEmployee = togglePermissionAddEmployeeSubject.valueOrNull ?? false;
      this.togglePermissionAddEmployeeSubject.add(!isOnPermissionAddEmployee);
    } else {
      showSnackBar(allTranslations.text(AppLanguages.validateSelectAccessToMouBusiness));
    }
  }

  void onTogglePermissionAddRoster() {
    if (this.toggleAccessBusinessSubject.valueOrNull != null &&
        this.toggleAccessBusinessSubject.valueOrNull == true) {
      var isOnPermissionAddRoster = togglePermissionAddRosterSubject.valueOrNull ?? false;
      this.togglePermissionAddRosterSubject.add(!isOnPermissionAddRoster);
    } else {
      showSnackBar(allTranslations.text(AppLanguages.validateSelectAccessToMouBusiness));
    }
  }

  void addEmployee() async {
    FocusScope.of(context).unfocus();
    setLoading(true);
    if (validate()) {
      var roleName = employeeRoleController.value.text;
      // var accessBusiness = toggleAccessBusinessSubject.valueOrNull == true ? 1 : 0;
      // var addTask = togglePermissionAddTaskSubject.valueOrNull == true ? 1 : 0;
      // var addEmployee = togglePermissionAddEmployeeSubject.valueOrNull == true ? 1 : 0;
      // var addRoster = togglePermissionAddRosterSubject.valueOrNull == true ? 1 : 0;
      // var addProject = togglePermissionAddProjectSubject.valueOrNull == true ? 1 : 0;

      final addEmployeeRequest = AddEmployeeRequest(
        contactId: employee == null ? -1 : contact!.id,
        roleName: roleName,
        // permissionAccessBusiness: accessBusiness,
        // permissionAddTask: accessBusiness == 1 ? addTask : 0,
        // permissionAddEmployee: accessBusiness == 1 ? addEmployee : 0,
        // permissionAddProject: accessBusiness == 1 ? addProject : 0,
        // permissionAddRoster: accessBusiness == 1 ? addRoster : 0,
      );
      
      var resource = employee != null
          ? await employeeRepository.editEmployee(addEmployeeRequest, employee!.id)
          : await employeeRepository.addEmployee(addEmployeeRequest);
      print(resource);
      if (resource.isSuccess) {
        Navigator.of(context).pop();
        showSnackBar(
          allTranslations.text(employee != null
              ? AppLanguages.employeeUpdatedSuccessfully
              : AppLanguages.employeeAddedSuccessfully),
          isError: false,
        );
      } else {
        showSnackBar(resource.message);
      }
    }
    setLoading(false);
  }

  bool validate() {
    if ((employeeRoleController.value.text.trim().isEmpty)) {
      showSnackBar(allTranslations.text(AppLanguages.validateRoleEmployee));
      return false;
    } else if (employeeRoleController.value.text.length > 255) {
      showSnackBar(allTranslations.text(AppLanguages.validateRoleEmployeeLength));
      return false;
    }
    return true;
  }

  void setContact(Contact? contact) {
    this.contact = contact;
    contactSubject.add(this.contact?.name ?? '');
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() async {
    await toggleAccessBusinessSubject.drain();
    toggleAccessBusinessSubject.close();

    await togglePermissionAddEmployeeSubject.drain();
    togglePermissionAddEmployeeSubject.close();

    await togglePermissionAddProjectSubject.drain();
    togglePermissionAddProjectSubject.close();

    await togglePermissionAddTaskSubject.drain();
    togglePermissionAddTaskSubject.close();

    await contactSubject.drain();
    contactSubject.close();

    await togglePermissionAddRosterSubject.drain();
    togglePermissionAddRosterSubject.close();

    super.dispose();
  }
}
