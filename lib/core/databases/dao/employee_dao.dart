import 'package:drift/drift.dart';

import 'package:mou_business_app/core/databases/table/employee.dart';

import '../app_database.dart';

part 'employee_dao.g.dart';

@DriftAccessor(tables: [Employees])
class EmployeeDao extends DatabaseAccessor<AppDatabase> with _$EmployeeDaoMixin {
  final AppDatabase db;

  EmployeeDao(this.db) : super(db);

  Future<Employee> getEmployeeByID(int id) =>
      (select(employees)..where((t) => t.id.equals(id))).getSingle();

  Stream<Employee> watchAllEmployeeByID(int id) =>
      (select(employees)..where((t) => t.id.equals(id))).watchSingle();

  Future<List<Employee>> getLocalEmployees() => select(employees).get();

  Stream<List<Employee>> watchAllEmployees() => select(employees).watch();

  Future insertEmployee(Employee employee) =>
      into(employees).insert(employee, mode: InsertMode.insertOrReplace);

  Future updateEmployee(Employee employee) => update(employees).replace(employee);

  Future deleteEmployee(Employee employee) => delete(employees).delete(employee);

  Future deleteEmployeeByID(int id) => (delete(employees)..where((c) => c.id.equals(id))).go();

  Future deleteAll() => delete(employees).go();
}
