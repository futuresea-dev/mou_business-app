import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/core/repositories/employee_repository.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class EmployeeDialogViewModel extends BaseViewModel {
  EmployeeRepository employeeRepository;
  EmployeeDao employeeDao;
  bool isEmployee;

  EmployeeDialogViewModel({
    required this.employeeRepository,
    required this.employeeDao,
    required this.isEmployee,
  });

  final employeesSubject = BehaviorSubject<List<Employee>>();
  final employeeSelectedSubject = BehaviorSubject<Employee>();

  String textSearch = "";
  Employee? employeeSelected;
  List<Employee>? employeesData;

  initData(Employee employeeSelected) async {
    employeesData = <Employee>[];
    await employeeRepository.getEmployeeList();
    employeesData = await employeeDao.getLocalEmployees();

    if (isEmployee) {
      employeesData = employeesData
          ?.where((emp) => emp.employeeConfirm != null && emp.employeeConfirm == "Y")
          .toList();
    }
    employeesSubject.add(employeesData ?? []);

    if (this.employeeSelected == null) {
      this.employeeSelected = Employee(id: 0); // TODO id is static
    }
    this.employeeSelected = employeeSelected;
    employeeSelectedSubject.add(employeeSelected);
  }

  void setContactSelected(Employee employee) {
    if (employeeSelected == null) employeeSelected = Employee(id: 0); // TODO id is static
    if (employeeSelected?.id != null && employeeSelected?.id == employee.id) {
      employeeSelected = null;
    } else {
      employeeSelected = employee;
    }
    employeeSelectedSubject.add(
      employeeSelected ?? Employee(id: 0), // TODO id is static
    );
  }

  bool checkSelected(Employee employee) {
    if (employeeSelected == null) return false;
    return employeeSelected?.id == employee.id;
  }

  search(String text) {
    List<Employee> employeesFilter;
    if (text != "") {
      print("text search $text");
      employeesFilter = employeesData
              ?.where((item) =>
                  item.contact != null &&
                  item.contact?["name"].toLowerCase().contains(text.toLowerCase()))
              .toList() ??
          [];
      print("contactsFilter ${employeesFilter.length}");
    } else {
      employeesFilter = employeesData ?? [];
    }
    this.textSearch = text;
    employeesSubject.add(employeesFilter);
  }

  Future<void> onRefresh() async {
    employeesData = null;
    employeesSubject.add(employeesData ?? []);
    await this.initData(
      this.employeeSelected ?? Employee(id: 0), // TODO id is static
    );
    search(this.textSearch);
  }

  @override
  void dispose() async {
    await employeesSubject.drain();
    employeesSubject.close();

    await employeeSelectedSubject.drain();
    employeeSelectedSubject.close();
    super.dispose();
  }
}
