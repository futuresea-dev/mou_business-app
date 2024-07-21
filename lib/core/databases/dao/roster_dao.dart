import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/table/rosters.dart';

part 'roster_dao.g.dart';

@DriftAccessor(tables: [Rosters])
class RosterDao extends DatabaseAccessor<AppDatabase> with _$RosterDaoMixin {
  final AppDatabase db;

  RosterDao(this.db) : super(db);

  Future insertRosters(List<Roster> elements) => batch((batch) =>
      batch.insertAll(rosters, elements, mode: InsertMode.insertOrReplace));

  Stream<List<Roster>> watchAllRosters() => select(rosters).watch();

  Future<Roster?> getRosterById(int id) =>
      (select(rosters)..where((t) => t.id.equals(id))).getSingle();

  Future deleteAll() => delete(rosters).go();

  Future deleteRosterById(int id) =>
      (delete(rosters)..where((roster) => roster.id.equals(id))).go();

  Stream<List<Roster>> watchRostersInDate(DateTime selected) {
    DateTime date = DateTime(selected.year, selected.month, selected.day);
    return (select(rosters)
          ..where((t) => Variable(date.copyWith(hour: 23, minute: 59))
              .isBiggerOrEqual(t.startTime))
          ..where((t) => Variable(date).isSmallerOrEqual(t.endTime))
          ..orderBy([
            (c) => OrderingTerm(expression: c.startTime, mode: OrderingMode.asc)
          ]))
        .watch();
  }

  Future insertRoster(Roster roster) =>
      into(rosters).insert(roster, mode: InsertMode.insertOrReplace);
}
