import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static final SqliteService _sqliteService = SqliteService._internal();
  factory SqliteService() => _sqliteService;
  SqliteService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'mou_business.db');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1
    );
  }

  Future<void> _onCreate(Database db, int version) async{
    await db.execute(
      'CREATE TABLE contacts(' + 
      'id INTEGER PRIMARY KEY NOT NULL, ' + 
      'name TEXT, ' + 
      'email TEXT, ' +
      'full_address TEXT, ' +
      'birthday TEXT, ' +
      'gender INTEGER, ' +
      'country_code TEXT, ' + 
      'city TEXT, ' +
      'phone_number TEXT, ' +
      'dial_code TEXT, ' +
      'avatar TEXT, ' +
      'page INTEGER) '
    );

    await db.execute(
      'CREATE TABLE contacts(' + 
      'id INTEGER PRIMARY KEY NOT NULL, ' + 
      'contact_id INTEGER, ' + 
      'role_name TEXT, ' + 
      'permission_access_business INTEGER, ' +
      'permission_add_task INTEGER, ' +
      'permission_add_project INTEGER, ' +
      'permission_add_employee INTEGER, ' +
      'permission_add_roster INTEGER, ' + 
      'company_id INTEGER, ' +
      'employee_confirm TEXT, ' +
      'employee_name TEXT) '
    );

    await db.execute(
      'CREATE TABLE shops(' + 
      'id INTEGER PRIMARY KEY NOT NULL, ' + 
      'name TEXT, ' +
      'creator_id INTEGER, ' +
      'company_id INTEGER) '
    );

    await db.execute(
      'CREATE TABLE projects(' + 
      'id INTEGER PRIMARY KEY NOT NULL, ' + 
      'title TEXT, ' +
      'description TEXT, ' +
      'client TEXT, ' +
      'company_name TEXT, ' +
      'employee_responsible TEXT, ' +
      'teams TEXT, ' +
      'creator_id INTEGER, ' +
      'tasks TEXT, ' +
      'company_photo TEXT) '
    );

    await db.execute(
      'CREATE TABLE tasks(' + 
      'id INTEGER PRIMARY KEY NOT NULL, ' + 
      'title TEXT, ' +
      'comment TEXT, ' +
      'employees TEXT, ' +
      'start_date TEXT, ' +
      'end_date TEXT, ' +
      'status TEXT, ' +
      'page INTEGER, ' +
      'store_id INTEGER) '
    );

    await db.execute(
      'CREATE TABLE rosters(' + 
      'id INTEGER PRIMARY KEY NOT NULL, ' + 
      'employee TEXT, ' +
      'creator_id INTEGER, ' +
      'status TEXT, ' +
      'start_time TEXT, ' +
      'end_time TEXT, ' +
      'page INTEGER, ' +
      'total_deny INTEGER, ' +
      'store_id INTEGER) '
    );

    await db.execute(
      'CREATE TABLE roster_checks(' + 
      'key TEXT, ' + 
      'value TEXT) '
    );

    await db.execute(
      'CREATE TABLE events(' + 
      'id INTEGER PRIMARY KEY NOT NULL, ' + 
      'title TEXT, ' +
      'start_date TEXT, ' +
      'end_date TEXT, ' +
      'project_start_date TEXT, ' +
      'project_end_date TEXT, ' +
      'comment TEXT, ' +
      'repeat TEXT, ' +
      'alarm TEXT, ' +
      'place TEXT, ' +
      'busy_mode INTEGER, ' +
      'creator TEXT, ' +
      'users TEXT, ' +
      'waiting_to_confirm BOOLEAN, ' +
      'event_status TEXT, ' +
      'work_status TEXT, ' +
      'type TEXT, ' +
      'project_name TEXT, ' +
      'company_photo TEXT, ' +
      'company_name TEXT, ' +
      'store_name TEXT, ' +
      'done_time TEXT, ' +
      'date_local TEXT, ' +
      'project_id INTEGER, ' +
      'status TEXT, ' +
      'scope_name TEXT, ' +
      'client_name TEXT, ' +
      'leader_name TEXT, ' +
      'page_type TEXT) '
    );

    await db.execute(
      'CREATE TABLE event_checks(' + 
      'key TEXT, ' + 
      'value TEXT) '
    );

    await db.execute(
      'CREATE TABLE notifications(' + 
      'id INTEGER PRIMARY KEY NOT NULL, ' + 
      'action TEXT , ' + 
      'avatar TEXT , ' + 
      'title TEXT , ' + 
      'body TEXT , ' + 
      'type TEXT , ' + 
      'read_at TEXT , ' + 
      'time_ago TEXT , ' + 
      'created_at TEXT , ' + 
      'updated_at TEXT , ' + 
      'route_name TEXT , ' + 
      'arguments TEXT) '
    );
  }

  Future<void> insertData(String table, Map<String, dynamic> data) async {
    final db = await _sqliteService.database;

    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> allData(String table) async {
    final db = await _sqliteService.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return maps;
  }

  Future<Map<String, dynamic>> getDataById(String table, int id) async {
    final db = await _sqliteService.database;

    final List<Map<String, dynamic>> maps = 
      await db.query(table, where: 'id = ?', whereArgs: [id]);

    return maps[0];
  }

  Future<void> updateData(String table, Map<String, dynamic> data, int id) async {
    final db = await _sqliteService.database;

    await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteData(String table, int id) async {
    final db = await _sqliteService.database;
    
    await db.delete(table);
  }
}