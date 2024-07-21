import 'package:drift/drift.dart';

class EventChecks extends Table {
  TextColumn get key => text()();

  TextColumn get value => text().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}
