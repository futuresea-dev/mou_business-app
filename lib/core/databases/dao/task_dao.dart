import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/table/tasks.dart';

import '../app_database.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  final AppDatabase db;

  TaskDao(this.db) : super(db);

  Future<Task?> getTaskById(int id) =>
      (select(tasks)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future insertTask(Task task) => into(tasks).insert(task, mode: InsertMode.insertOrReplace);

  Future updateTask(Task task) => update(tasks).replace(task);

  Future deleteTaskByID(int id) =>
      (delete(tasks)..where((c) => c.id.equals(id))).go();

  Future deleteAll() => delete(tasks).go();

}
