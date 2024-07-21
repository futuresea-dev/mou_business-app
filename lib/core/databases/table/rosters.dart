import 'package:drift/drift.dart';

import 'package:mou_business_app/core/databases/converter/date_time_converter.dart';
import 'package:mou_business_app/core/databases/converter/map_converter.dart';

class Rosters extends Table {
  IntColumn get id => integer()();

  TextColumn get employee => text().map(const MapConverter()).nullable()();

  @JsonKey("creator_id")
  IntColumn get creatorId => integer().named("creator_id").nullable()();

  TextColumn get status => text().nullable()();

  @JsonKey("start_time")
  DateTimeColumn get startTime =>
      dateTime().map(const DateTimeConverter()).named("start_time").nullable()();

  @JsonKey("end_time")
  DateTimeColumn get endTime =>
      dateTime().map(const DateTimeConverter()).named("end_time").nullable()();

  IntColumn get page => integer().nullable()();

  @JsonKey("store_id")
  IntColumn get storeId => integer().named("store_id").nullable()();

  TextColumn get store => text().map(const MapConverter()).nullable()();

  @JsonKey("total_deny")
  IntColumn get totalDeny => integer().named("total_deny").nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
