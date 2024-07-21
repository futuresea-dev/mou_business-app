import 'package:drift/drift.dart';

import 'package:mou_business_app/core/databases/converter/map_converter.dart';

class Employees extends Table {
  IntColumn get id => integer()();

  TextColumn get contact => text().map(const MapConverter()).nullable()();

  @JsonKey("role_name")
  TextColumn get roleName => text().named("role_name").nullable()();

  @JsonKey("permission_access_business")
  IntColumn get permissionAccessBusiness => integer().named("permission_access_business").nullable()();

  @JsonKey("permission_add_task")
  IntColumn get permissionAddTask => integer().named("permission_add_task").nullable()();

  @JsonKey("permission_add_project")
  IntColumn get permissionAddProject => integer().named("permission_add_project").nullable()();

  @JsonKey("permission_add_employee")
  IntColumn get permissionAddEmployee => integer().named("permission_add_employee").nullable()();

  @JsonKey("permission_add_roster")
  IntColumn get permissionAddRoster => integer().named("permission_add_roster").nullable()();

  @JsonKey("company_id")
  IntColumn get companyId => integer().named("company_id").nullable()();

  @JsonKey("employee_confirm")
  TextColumn get employeeConfirm => text().named("employee_confirm").nullable()();

  @JsonKey("employee_name")
  TextColumn get employeeName => text().named("employee_name").nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
