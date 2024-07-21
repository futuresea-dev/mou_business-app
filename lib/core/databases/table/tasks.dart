import 'package:drift/drift.dart';

import 'package:mou_business_app/core/databases/converter/list_converter.dart';

class Tasks extends Table {
  IntColumn get id => integer()();

  TextColumn get title => text()();

  TextColumn get comment => text().nullable()();

  TextColumn get employees => text().map(const ListConverter()).nullable()();

  @JsonKey("start_date")
  TextColumn get startDate => text().named("start_date").nullable()();

  @JsonKey("end_date")
  TextColumn get endDate => text().named("end_date").nullable()();

  TextColumn get status => text().nullable()();

  IntColumn get page => integer().nullable()();

  @JsonKey("store_id")
  IntColumn get storeId => integer().named("store_id").nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
