import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/core/repositories/employee_repository.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class EmployeeListDialogViewModel extends BaseViewModel {
  final EmployeeRepository employeeRepository;
  final EmployeeDao employeeDao;
  final bool isEmployee;
  final bool isMulti;

  EmployeeListDialogViewModel({
    required this.employeeRepository,
    required this.employeeDao,
    required this.isEmployee,
    required this.isMulti,
  });

  var employeesSubject = BehaviorSubject<List<Employee>>();
  var employeesSelectedSubject = BehaviorSubject<List<Employee>>();

  String textSearch = "";
  List<Employee> employeesSelected = [];
  List<Employee> employeesData = [];

  initData(List<Employee> employeesSelected) async {
    employeesData = <Employee>[];
    await employeeRepository.getEmployeeList();
    employeesData = await employeeDao.getLocalEmployees();
    if (isEmployee) {
      employeesData = employeesData
          .where((e) => e.employeeConfirm != null && e.employeeConfirm == "Y")
          .toList();
    }
    employeesSubject.add(employeesData);
    this.employeesSelected = employeesSelected;
    employeesSelectedSubject.add(employeesSelected);
  }

  List<Employee> getEmployeeList() {
    return employeesData;
  }

  void setEmployeeSelected(Employee employee) {
    int isExist = -1;
    if (employeesSelected.isEmpty) {
      employeesSelected = <Employee>[];
    } else {
      isExist = employeesSelected.indexWhere((item) => item.id == employee.id);
    }

    if (isExist != -1) {
      if (isMulti) {
        employeesSelected.removeWhere((item) => item.id == employee.id);
      } else {
        employeesSelected.clear();
      }
    } else {
      if (!isMulti) employeesSelected.clear();
      employeesSelected.add(employee);
    }
    employeesSelectedSubject.add(employeesSelected);
  }

  bool checkSelected(Employee employee) {
    if (employeesSelected.isEmpty) return false;
    return employeesSelected.lastIndexWhere((item) => item.id == employee.id) != -1;
  }

  search(String text) async {
    print("text search $text");
    List<Employee> employeesFilter;
    if (text != "") {
      if (employeesData.isEmpty) {
        employeesData = await employeeDao.getLocalEmployees();
      }
      employeesFilter = employeesData
          .where((item) =>
              item.contact?["name"] != null &&
              item.contact?["name"].toLowerCase().contains(text.toLowerCase()))
          .toList();
      print("contactsFilter ${employeesFilter.length}");
    } else {
      if (employeesData.isEmpty) {
        employeesData = await employeeDao.getLocalEmployees();
      }
      employeesFilter = employeesData;
    }
    this.textSearch = text;
    employeesSubject.add(employeesFilter);
  }

  Future<void> onRefresh() async {
    employeesData = [];
    employeesSubject.add(employeesData);
    await this.initData(this.employeesSelected);
    search(this.textSearch);
  }

  @override
  void dispose() async {
    await employeesSubject.drain();
    employeesSubject.close();

    await employeesSelectedSubject.drain();
    employeesSelectedSubject.close();
    super.dispose();
  }
}
