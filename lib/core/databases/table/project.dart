import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/converter/list_converter.dart';
import 'package:mou_business_app/core/databases/converter/map_converter.dart';

class Projects extends Table {
  IntColumn get id => integer()();

  TextColumn get title => text()();

  TextColumn get description => text().nullable()();

  TextColumn get client => text().nullable()();

  @JsonKey("company_name")
  TextColumn get companyName => text().named("company_name").nullable()();

  @JsonKey("employee_responsible")
  TextColumn get employeeResponsible => text().map(const MapConverter()).nullable()();

  TextColumn get teams => text().map(const ListConverter()).nullable()();

  @JsonKey("creator_id")
  IntColumn get creatorId => integer().named("creator_id").nullable()();

  TextColumn get tasks => text().map(const ListConverter()).nullable()();

  @JsonKey("company_photo")
  TextColumn get companyPhoto => text().named("company_photo").nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
