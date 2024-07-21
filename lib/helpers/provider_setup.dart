import 'package:mou_business_app/core/databases/app_database.dart';
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
import 'package:mou_business_app/core/repositories/auth_repository.dart';
import 'package:mou_business_app/core/repositories/contact_repository.dart';
import 'package:mou_business_app/core/repositories/employee_repository.dart';
import 'package:mou_business_app/core/repositories/event_repository.dart';
import 'package:mou_business_app/core/repositories/notification_repository.dart';
import 'package:mou_business_app/core/repositories/project_repository.dart';
import 'package:mou_business_app/core/repositories/roster_repository.dart';
import 'package:mou_business_app/core/repositories/store_repository.dart';
import 'package:mou_business_app/core/repositories/user_repository.dart';
import 'package:mou_business_app/core/services/firebase_service.dart';
import 'package:mou_business_app/core/services/wifi_service.dart';
import 'package:mou_business_app/helpers/permissions_service.dart';
import 'package:mou_business_app/managers/payments_manager.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [...independentServices, ...dependentServices];

List<SingleChildWidget> independentServices = [
  Provider.value(value: AppDatabase.instance()),
  Provider.value(value: AuthRepository()),
  Provider.value(value: UserRepository()),
  Provider.value(value: FirebaseService()),
  Provider.value(value: WifiService()),
  Provider.value(value: PaymentsManager()),
  Provider.value(value: PermissionsService()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<AppDatabase, EventDao>(update: (context, database, dao) => database.eventDao),
  ProxyProvider<AppDatabase, TaskDao>(
    update: (context, database, dao) => database.taskDao,
  ),
  ProxyProvider<AppDatabase, RosterCheckDao>(update: (_, database, __) => database.rosterCheckDao),
  ProxyProvider<AppDatabase, ContactDao>(update: (context, database, dao) => database.contactDao),
  ProxyProvider<AppDatabase, EmployeeDao>(update: (context, database, dao) => database.employeeDao),
  ProxyProvider<AppDatabase, ProjectDao>(update: (context, database, dao) => database.projectDao),
  ProxyProvider<AppDatabase, RosterDao>(update: (context, database, dao) => database.rosterDao),
  ProxyProvider<AppDatabase, ShopDao>(update: (context, database, dao) => database.shopDao),
  ProxyProvider<AppDatabase, EventCheckDao>(update: (_, database, __) => database.eventCheckDao),
  ProxyProvider<AppDatabase, NotificationDao>(
    update: (_, database, __) => database.notificationDao,
  ),
  ProxyProvider<EmployeeDao, EmployeeRepository>(
    update: (context, employeeDao, repository) => EmployeeRepository(employeeDao),
  ),
  ProxyProvider<ContactDao, ContactRepository>(
    update: (context, contactDao, repository) => ContactRepository(contactDao),
  ),
  ProxyProvider2<EventDao, EventCheckDao, EventRepository>(
    update: (context, eventDao, eventCheckDao, repository) =>
        EventRepository(eventDao, eventCheckDao),
  ),
  ProxyProvider3<ProjectDao, TaskDao, ShopDao, ProjectRepository>(
    update: (context, projectDao, taskDao, shopDao, repository) =>
        ProjectRepository(projectDao, taskDao, shopDao),
  ),
  ProxyProvider3<RosterDao, RosterCheckDao, ShopDao, RosterRepository>(
    update: (context, rosterDao, rosterCheckDao, shopDao, repository) =>
        RosterRepository(rosterDao, rosterCheckDao, shopDao),
  ),
  ProxyProvider<ShopDao, StoreRepository>(
    update: (context, shopDao, repository) => StoreRepository(shopDao),
  ),
  ProxyProvider<NotificationDao, NotificationRepository>(
    update: (context, dao, repository) => NotificationRepository(dao),
  ),
];
