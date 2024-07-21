import 'package:drift/drift.dart';

class Notifications extends Table {
  TextColumn get id => text()();

  TextColumn get action => text()();

  TextColumn get avatar => text().nullable()();

  TextColumn get title => text()();

  TextColumn get body => text()();

  TextColumn get type => text().withDefault(Constant('business'))();

  @JsonKey("read_at")
  TextColumn get readAt => text().named("read_at").nullable()();

  @JsonKey("time_ago")
  TextColumn get timeAgo => text().named("time_ago")();

  @JsonKey("created_at")
  TextColumn get createdAt => text().named("created_at")();

  @JsonKey("updated_at")
  TextColumn get updatedAt => text().named("updated_at")();

  @JsonKey("route_name")
  TextColumn get routeName => text().named("route_name").nullable()();

  @JsonKey("arguments")
  TextColumn get arguments => text().named("arguments").nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
