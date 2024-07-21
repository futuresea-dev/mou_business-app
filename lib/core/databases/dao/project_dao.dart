import 'package:drift/drift.dart';

import '../app_database.dart';
import '../table/project.dart';

part 'project_dao.g.dart';

@DriftAccessor(tables: [Projects])
class ProjectDao extends DatabaseAccessor<AppDatabase> with _$ProjectDaoMixin {
  final AppDatabase db;

  ProjectDao(this.db) : super(db);

  Future<Project?> getProjectByID(int id) =>
      (select(projects)..where((project) => project.id.equals(id))).getSingleOrNull();

  Future insertProject(Project project) =>
      into(projects).insert(project, mode: InsertMode.insertOrReplace);

  Future updateProject(Project project) => update(projects).replace(project);

  Future deleteProjectByID(int id) => (delete(projects)..where((c) => c.id.equals(id))).go();

  Future deleteAll() => delete(projects).go();
}
