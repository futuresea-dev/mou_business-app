// import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
// import 'package:mou_business_app/core/databases/dao/contact_dao.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/core/models/list_response.dart';
import 'package:mou_business_app/core/network_bound_resource.dart';
import 'package:mou_business_app/core/requests/add_employee_request.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/core/services/api_service.dart';
import 'package:mou_business_app/utils/app_shared.dart';

class EmployeeRepository {
  CancelToken _cancelToken = CancelToken();

  final EmployeeDao employeeDao;

  EmployeeRepository(this.employeeDao);

  Future<Resource<Employee>> addEmployee(AddEmployeeRequest addEmployeeRequest) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<Employee, Employee>(
      createCall: () => APIService.addEmployee(companyId, addEmployeeRequest, _cancelToken),
      parsedData: (json) => Employee.fromJson(json),
      saveCallResult: (data) async =>
          await employeeDao.insertEmployee(data.copyWith(employeeConfirm: Value("W"))),
    );

    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> editEmployee(
      AddEmployeeRequest addEmployeeRequest, int employeeId) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () =>
          APIService.editEmployee(employeeId, companyId, addEmployeeRequest, _cancelToken),
      parsedData: (json) => Employee.fromJson(json),
      saveCallResult: (data) async => await employeeDao.insertEmployee(data),
    );
    return resource.getAsObservable();
  }

  Future<Resource<ListResponse<Employee>>> getEmployeeList() async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<ListResponse<Employee>, ListResponse<Employee>>(
      createCall: () => APIService.getEmployeeList(companyId, _cancelToken),
      parsedData: (json) {
        return ListResponse<Employee>(
          data: (json as List).map((e) => Employee.fromJson(e)).toList(),
        );
      },
      saveCallResult: (response) async {
        List<Employee> employees = response.data ?? [];
        await employeeDao.deleteAll();
        for (Employee employee in employees) {
          await employeeDao.insertEmployee(employee);
        }
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> deleteEmployee(int employeeId) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final user = await AppShared.getUser();
    final companyId = user.company?.id ?? -1;
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.deleteEmployee(employeeId, companyId, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (data) async => await employeeDao.deleteEmployeeByID(employeeId),
      loadFromDb: () async => await null,
    );
    return resource.getAsObservable();
  }

  cancel() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }
}
