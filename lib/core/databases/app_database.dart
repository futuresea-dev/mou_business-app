import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:mou_business_app/core/databases/converter/date_time_converter.dart';
import 'package:mou_business_app/core/databases/converter/list_converter.dart';
import 'package:mou_business_app/core/databases/converter/map_converter.dart';
import 'package:mou_business_app/core/databases/dao/contact_dao.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/core/databases/dao/event_check_dao.dart';
import 'package:mou_business_app/core/databases/dao/event_dao.dart';
import 'package:mou_business_app/core/databases/dao/notification_dao.dart';
import 'package:mou_business_app/core/databases/dao/project_dao.dart';
import 'package:mou_business_app/core/databases/dao/roster_check_dao.dart';
import 'package:mou_business_app/core/databases/dao/roster_dao.dart';
import 'package:mou_business_app/core/databases/dao/shop_dao.dart';
import 'package:mou_business_app/core/databases/dao/task_dao.dart';
import 'package:mou_business_app/core/databases/table/contacts.dart';
import 'package:mou_business_app/core/databases/table/employee.dart';
import 'package:mou_business_app/core/databases/table/event_checks.dart';
import 'package:mou_business_app/core/databases/table/events.dart';
import 'package:mou_business_app/core/databases/table/notifications.dart';
import 'package:mou_business_app/core/databases/table/project.dart';
import 'package:mou_business_app/core/databases/table/roster_checks.dart';
import 'package:mou_business_app/core/databases/table/rosters.dart';
import 'package:mou_business_app/core/databases/table/shops.dart';
import 'package:mou_business_app/core/databases/table/tasks.dart';
import 'package:mou_business_app/utils/types/event_page_type.dart';
import 'package:mou_business_app/utils/types/event_status.dart';
import 'package:mou_business_app/utils/types/event_task_type.dart';
import 'package:mou_business_app/utils/types/work_status.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Events,
    Contacts,
    RosterChecks,
    Employees,
    Tasks,
    Projects,
    Rosters,
    Shops,
    EventChecks,
    Notifications,
  ],
  daos: [
    EventDao,
    ContactDao,
    RosterCheckDao,
    EmployeeDao,
    TaskDao,
    ProjectDao,
    RosterDao,
    ShopDao,
    EventCheckDao,
    NotificationDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(SqfliteQueryExecutor.inDatabaseFolder(path: "mou_personal.v.1.0.sqlite"));
  static AppDatabase? _instance;

  static AppDatabase? instance() {
    if (_instance == null) _instance = AppDatabase();
    return _instance;
  }

  @override
  int get schemaVersion => 14;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (Migrator migrator, int from, int to) async {
        for (final table in allTables) {
          await migrator.deleteTable(table.actualTableName);
          await migrator.createTable(table);
        }
      },
    );
  }

  static Future<void> clearData() async {
    // await _instance?.rosterCheckDao.deleteAll();
    // await _instance?.eventDao.deleteAll();
    // await _instance?.contactDao.deleteAll();
    // await _instance?.projectDao.deleteAll();
    // await _instance?.rosterDao.deleteAll();
    // await _instance?.employeeDao.deleteAll();
    // await _instance?.shopDao.deleteAll();
    // await _instance?.eventCheckDao.deleteAll();
  }
}
