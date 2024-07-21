import 'package:drift/drift.dart';

class Shops extends Table {
  IntColumn get id => integer()();

  TextColumn get name  => text().nullable()();

  @JsonKey("creator_id")
  IntColumn get creatorId   => integer().named("creator_id").nullable()();
  @JsonKey("company_id")
  IntColumn get companyId => integer().named("company_id").nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
