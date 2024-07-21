import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/table/roster_checks.dart';

import '../app_database.dart';

part 'roster_check_dao.g.dart';

@DriftAccessor(tables: [RosterChecks])
class RosterCheckDao  extends DatabaseAccessor<AppDatabase> with _$RosterCheckDaoMixin  {
  final AppDatabase db;

  RosterCheckDao(this.db) : super(db);

  Future<List<RosterCheck>> getAllRosterChecks() => select(rosterChecks).get();

  Future<RosterCheck>? getRosterCheckByDate(DateTime? dateTime) {
    if (dateTime == null) return null;

    (select(rosterChecks)
      ..where((t) {
        final date = dateTime.toString().split(" ")[0];
        return t.key.equals(date);
      }))
        .getSingle();
    return null;
  }

  Stream<List<RosterCheck>> watchAllRosterChecks() => select(rosterChecks).watch();

  Future insertRosterCheck(RosterCheck rosterCheck) =>
      into(rosterChecks).insert(rosterCheck, mode: InsertMode.insertOrReplace);

  Future updateRosterCheck(RosterCheck rosterCheck) =>
      update(rosterChecks).replace(rosterCheck);

  Future deleteRosterCheck(RosterCheck rosterCheck) =>
      delete(rosterChecks).delete(rosterCheck);

  Future deleteAll() => delete(rosterChecks).go();
}
