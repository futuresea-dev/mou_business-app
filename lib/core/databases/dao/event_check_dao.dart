import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/table/event_checks.dart';

part 'event_check_dao.g.dart';

@DriftAccessor(tables: [EventChecks])
class EventCheckDao extends DatabaseAccessor<AppDatabase> with _$EventCheckDaoMixin {
  final AppDatabase db;

  EventCheckDao(this.db) : super(db);

  Future<List<EventCheck>> getAllEventChecks() => select(eventChecks).get();

  Future<EventCheck?> getEventCheckByDate(DateTime dateTime) => (select(eventChecks)
        ..where((t) {
          // if (dateTime == null) return null;
          final date = dateTime.toString().split(" ")[0];
          return t.key.equals(date);
        }))
      .getSingleOrNull();

  Stream<List<EventCheck>> watchAllEventChecks() => select(eventChecks).watch();

  Future insertEventCheck(EventCheck eventCheck) =>
      into(eventChecks).insert(eventCheck, mode: InsertMode.insertOrReplace);

  Future updateEventCheck(EventCheck eventCheck) => update(eventChecks).replace(eventCheck);

  Future deleteEventCheck(EventCheck eventCheck) => delete(eventChecks).delete(eventCheck);

  Future deleteAll() => delete(eventChecks).go();
}
