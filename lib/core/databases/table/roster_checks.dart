import 'package:drift/drift.dart';

class RosterChecks extends Table {
  TextColumn get key => text()();

  IntColumn get value => integer().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}
