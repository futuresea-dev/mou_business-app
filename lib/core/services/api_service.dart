// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/requests/add_employee_request.dart';
import 'package:mou_business_app/core/requests/add_or_update_roster_request.dart';
import 'package:mou_business_app/core/requests/add_project_request.dart';
import 'package:mou_business_app/core/requests/add_task_request.dart';
import 'package:mou_business_app/core/requests/change_phone_request.dart';
import 'package:mou_business_app/core/requests/company_request.dart';
import 'package:mou_business_app/core/requests/contact_request.dart';
import 'package:mou_business_app/core/requests/edit_project_request.dart';
import 'package:mou_business_app/core/requests/edit_task_request.dart';
import 'package:mou_business_app/utils/app_apis.dart';
import 'package:mou_business_app/utils/app_clients.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class APIService {
  static Future<Response<dynamic>> getContacts(CancelToken cancelToken) async {
    final api = AppApis.getContacts();
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> registerCompany(
      CompanyRequest companyRequest, CancelToken cancelToken) {
    String imgPath = companyRequest.logo?.path ?? "";
    FormData data = FormData.fromMap({
      "name": companyRequest.name,
      "email": companyRequest.email,
      "logo": MultipartFile.fromFileSync(
        imgPath,
        filename: path.basename(imgPath),
      ),
      "country_code": companyRequest.countryCode?.toLowerCase(),
      "city": companyRequest.city,
    });

    String api = AppApis.register();
    return AppClients(multiPart: true).post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getMeInfo(CancelToken cancelToken) {
    String api = AppApis.me();
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> searchUsers(String search, CancelToken cancelToken) async {
    final api = AppApis.searchUsers(search);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> linkContact(int id, CancelToken cancelToken) async {
    final api = AppApis.linkContact(id);
    return AppClients().post(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> addContact(
      ContactRequest contactRequest, CancelToken cancelToken) async {
    String? imgPath = contactRequest.avatar?.path;
    FormData data = FormData.fromMap({
      "name": contactRequest.name,
      "avatar": MultipartFile.fromFileSync(
        imgPath ?? "",
        filename: path.basename(imgPath ?? ""),
      ),
      "phone_number": contactRequest.phoneNumber,
      "dial_code": contactRequest.dialCode
    });
    final api = AppApis.addContact();
    final clients = AppClients(multiPart: true);
    return clients.post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> editContact(
      int id, ContactRequest contactRequest, CancelToken cancelToken) {
    String imgPath = contactRequest.avatar?.path ?? "";
    Map<String, dynamic> map = {
      "name": contactRequest.name,
      "phone_number": contactRequest.phoneNumber,
      "dial_code": contactRequest.dialCode
    };
    if (imgPath.isNotEmpty == true) {
      map.addAll({
        "avatar": MultipartFile.fromFileSync(
          imgPath,
          filename: path.basename(imgPath),
        ),
      });
    }
    FormData data = FormData.fromMap(map);
    final api = AppApis.editContact(id);
    final clients = AppClients(multiPart: true);
    return clients.post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> deleteContact(Contact contact, CancelToken cancelToken) {
    final api = AppApis.deleteContact(contact.id);
    return AppClients().delete(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> importContacts(
      List<ContactRequest> contacts, CancelToken cancelToken) async {
    var params = {};
    if (contacts.isNotEmpty == true && contacts.length > 0) {
      params = {for (int i = 0; i < contacts.length; i++) i.toString(): contacts[i].toJson()};
    }
    var data = {"contacts": params};

    final api = AppApis.importContact();
    return AppClients(multiPart: true).post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> updateSetting(
      String languageCode, bool busyMode, CancelToken cancelToken) {
    String api = AppApis.updateSetting();
    Map<String, dynamic> data = {};
    if (busyMode != null) data["busy_mode"] = busyMode ? "1" : "0";
    if (languageCode.isNotEmpty == true) data["language_code"] = languageCode;
    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> connectContactFacebook(
      String facebookID, List<String> friendIDs, CancelToken cancelToken) {
    String api = AppApis.connectContactFacebook();
    Map<String, dynamic> data = {};
    if (facebookID.isNotEmpty == true) data['facebook_id'] = facebookID;
    if (friendIDs.isNotEmpty == true) data['friends'] = friendIDs;
    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> importContactFacebook(
      List<String> friendIDs, CancelToken cancelToken) {
    String api = AppApis.importContactFacebook();
    Map<String, dynamic> data = {};
    if (friendIDs.isNotEmpty == true) data['friends'] = friendIDs;
    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> sendFeedBack(String feedBack, CancelToken cancelToken) {
    String api = AppApis.sendFeedBack();
    Map<String, dynamic> data = {};
    data["content"] = feedBack;
    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> upDateFCMToken(
      String token, String deviceOS, CancelToken cancelToken) {
    String api = AppApis.getUpdateFCMToken();
    Map<String, dynamic> data = {};
    data["token"] = token;
    data["device"] = deviceOS;
    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> deleteFCMToken(String token, CancelToken cancelToken) {
    String api = AppApis.getDeleteFCMToken(token);
    return AppClients().delete(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> addEmployee(
      int companyId, AddEmployeeRequest addEmployeeRequest, CancelToken cancelToken) {
    String api = AppApis.addEmployee(companyId);

    Map<String, dynamic> data = {};
    data["contact_id"] = addEmployeeRequest.contactId;
    data["role_name"] = addEmployeeRequest.roleName;
    data["permission_access_business"] = addEmployeeRequest.permissionAccessBusiness;
    data["permission_add_task"] = addEmployeeRequest.permissionAddTask;
    data["permission_add_project"] = addEmployeeRequest.permissionAddProject;
    data["permission_add_employee"] = addEmployeeRequest.permissionAddEmployee;
    data["permission_add_roster"] = addEmployeeRequest.permissionAddRoster;
    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> editEmployee(int employeeId, int companyId,
      AddEmployeeRequest addEmployeeRequest, CancelToken cancelToken) {
    String api = AppApis.editEmployee(employeeId, companyId);
    Map<String, dynamic> data = {};
    data["contact_id"] = addEmployeeRequest.contactId;
    data["role_name"] = addEmployeeRequest.roleName;
    data["permission_access_business"] = addEmployeeRequest.permissionAccessBusiness;
    data["permission_add_task"] = addEmployeeRequest.permissionAddTask;
    data["permission_add_project"] = addEmployeeRequest.permissionAddProject;
    data["permission_add_employee"] = addEmployeeRequest.permissionAddEmployee;
    data["permission_add_roster"] = addEmployeeRequest.permissionAddRoster;

    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getEmployeeList(int employeeId, CancelToken cancelToken) {
    String api = AppApis.getEmployeeList(employeeId);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> deleteEmployee(
      int employeeId, int companyId, CancelToken cancelToken) {
    String api = AppApis.deleteEmployee(employeeId, companyId);
    return AppClients().delete(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> addTask(
      int companyId, AddTaskRequest addTaskRequest, CancelToken cancelToken) {
    String api = AppApis.addTask(companyId);

    Map<String, dynamic> data = {};
    data["title"] = addTaskRequest.title;
    data["comment"] = addTaskRequest.comment;

    var employeesParam = {};
    var employees = addTaskRequest.employees;
    if (employees?.isNotEmpty == true && employees!.length > 0) {
      employeesParam = {for (int i = 0; i < employees.length; i++) i.toString(): employees[i]};
    }
    data["employees"] = employeesParam;

    data["start_date"] = DateFormat(AppConstants.dateFormatUpload)
        .format(addTaskRequest.startDate ?? DateTime.now());
    data["end_date"] = addTaskRequest.endDate != null
        ? DateFormat(AppConstants.dateFormatUpload).format(addTaskRequest.endDate ?? DateTime.now())
        : "";
    data["repeat"] = addTaskRequest.repeat;

    if (addTaskRequest.storeId != null) data["store_id"] = addTaskRequest.storeId;

    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> updateLogo(File avatarPath, CancelToken cancelToken) {
    String imgPath = avatarPath.path;
    FormData data = FormData.fromMap({
      "logo": MultipartFile.fromFileSync(
        imgPath,
        filename: path.basename(imgPath),
      )
    });

    String api = AppApis.updateLogo();
    return AppClients(multiPart: true).post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> updateProfileCompany(
      CompanyRequest companyRequest, CancelToken cancelToken) {
    var data = {
      "name": companyRequest.name,
      "email": companyRequest.email,
      "country_code": companyRequest.countryCode?.toLowerCase(),
      "city": companyRequest.city,
      "address": companyRequest.address,
    };

    String api = AppApis.updateProfileCompany();
    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> addProject(
      int companyId, AddProjectRequest addProjectRequest, CancelToken cancelToken) {
    var tasksParam = {};
    var teamParam = {};
    if (addProjectRequest != null) {
      var tasks = addProjectRequest.tasks;
      var teams = addProjectRequest.teams;
      if (tasks?.isNotEmpty == true && (tasks?.length ?? 0) > 0) {
        var taskConvert = <Task>[];
        for (int i = 0; i < (tasks?.length ?? 0); i++) {
          var employees = tasks?[i].employees;
          if (employees?.isNotEmpty == true && (employees?.length ?? 0) > 0) {
            var userIDs =
                employees?.where((e) => e.id != null).map((e) => e.id).toList() as List<dynamic>;
            var task = tasks?[i].copyWith(employees: Value(userIDs));
            if (task != null) taskConvert.add(task);
          }
        }
        tasksParam = {
          for (int i = 0; i < taskConvert.length; i++) i.toString(): taskConvert[i].toJson()
        };
      }

      if (teams?.isNotEmpty == true && (teams?.length ?? 0) > 0) {
        teamParam = {for (int i = 0; i < (teams?.length ?? 0); i++) i.toString(): teams?[i]};
      }
    }
    var data = {
      "title": addProjectRequest.title,
      "description": addProjectRequest.description,
      "client": addProjectRequest.client,
      "employee_responsible_id": addProjectRequest.employeeResponsibleId,
      "tasks": tasksParam,
      "teams": teamParam
    };

    final api = AppApis.addProject(companyId);

    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getProjectDetail(
      int companyId, int projectId, CancelToken cancelToken) {
    String api = AppApis.getProjectDetail(companyId, projectId);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getTaskDetail(
      int companyId, int taskId, CancelToken cancelToken) {
    String api = AppApis.getTaskDetail(companyId, taskId);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> editTask(
      int companyId, int taskId, AddTaskRequest addTaskRequest, CancelToken cancelToken) {
    String api = AppApis.editTask(companyId, taskId);

    Map<String, dynamic> data = {};
    data["title"] = addTaskRequest.title;
    data["comment"] = addTaskRequest.comment;
    var employeesParam = {};
    var employees = addTaskRequest.employees;
    if (employees?.isNotEmpty == true && (employees?.length ?? 0) > 0) {
      employeesParam = {
        for (int i = 0; i < (employees?.length ?? 0); i++) i.toString(): employees?[i]
      };
    }
    data["employees"] = employeesParam;
    data["start_date"] = DateFormat(AppConstants.dateFormatUpload)
        .format(addTaskRequest.startDate ?? DateTime.now());
    data["end_date"] = addTaskRequest.endDate != null
        ? DateFormat(AppConstants.dateFormatUpload).format(addTaskRequest.endDate ?? DateTime.now())
        : "";
    data["repeat"] = addTaskRequest.repeat;

    if (addTaskRequest.storeId != null) data["store_id"] = addTaskRequest.storeId;

    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> deleteTask(int companyId, int taskId, CancelToken cancelToken) {
    final api = AppApis.deleteTask(companyId, taskId);
    return AppClients().delete(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> deleteProject(
      int companyId, int projectId, CancelToken cancelToken) {
    final api = AppApis.deleteProject(companyId, projectId);
    return AppClients().delete(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> addTaskOfProject(
    int companyId,
    int projectId,
    EditTaskRequest editTaskRequest,
    CancelToken cancelToken,
  ) {
    String api = AppApis.addTaskOfProject(companyId, projectId);

    var employeesParam = {};
    Map<String, dynamic> data = {};
    data["title"] = editTaskRequest.title;
    data["comment"] = editTaskRequest.comment;

    var employees = editTaskRequest.employees;
    if (employees?.isNotEmpty == true && (employees?.length ?? 0) > 0) {
      employeesParam = {
        for (int i = 0; i < (employees?.length ?? 0); i++) i.toString(): employees?[i]
      };
    }
    data["employees"] = employeesParam;
    data["start_date"] = editTaskRequest.startDate;
    data["end_date"] = editTaskRequest.endDate;

    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> editTaskOfProject(
    int companyId,
    int projectId,
    int taskId,
    EditTaskRequest editTaskRequest,
    CancelToken cancelToken,
  ) {
    String api = AppApis.editTaskOfProject(companyId, projectId, taskId);

    Map<String, dynamic> data = {};
    data["title"] = editTaskRequest.title;
    data["comment"] = editTaskRequest.comment;

    var employeesParam = {};
    var employees = editTaskRequest.employees;
    if (employees?.isNotEmpty == true && (employees?.length ?? 0) > 0) {
      employeesParam = {
        for (int i = 0; i < (employees?.length ?? 0); i++) i.toString(): employees?[i]
      };
    }
    data["employees"] = employeesParam;
    data["start_date"] = editTaskRequest.startDate;
    data["end_date"] = editTaskRequest.endDate;

    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> deleteTaskOfProject(
    int companyId,
    int projectId,
    int taskId,
    CancelToken cancelToken,
  ) {
    String api = AppApis.deleteTaskOfProject(companyId, projectId, taskId);
    return AppClients().delete(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> editProject(int companyId, int projectId,
      EditProjectRequest editProjectRequest, CancelToken cancelToken) {
    var teamParam = {};
    if (editProjectRequest != null) {
      var teams = editProjectRequest.teams;
      if (teams?.isNotEmpty == true && (teams?.length ?? 0) > 0) {
        teamParam = {for (int i = 0; i < (teams?.length ?? 0); i++) i.toString(): teams?[i]};
      }
    }
    var data = {
      "title": editProjectRequest.title,
      "description": editProjectRequest.description,
      "client": editProjectRequest.client,
      "employee_responsible_id": editProjectRequest.employeeResponsibleId,
      "teams": teamParam
    };

    final api = AppApis.editProject(companyId, projectId);
    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> addRoster(
      AddOrUpdateRosterRequest request, CancelToken cancelToken) {
    String api = AppApis.addRoster();

    return AppClients().post(api, data: request.toJson(), cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> updateRoster(
      int rosterId, AddOrUpdateRosterRequest request, CancelToken cancelToken) {
    String api = AppApis.updateRoster(rosterId);

    return AppClients().post(api, data: request.toJson(), cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getListRosters(String date, int page, CancelToken cancelToken) {
    String api = AppApis.getListRoster(date, page);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getRosterDetail(int rosterId, CancelToken cancelToken) {
    String api = AppApis.getRosterDetail(rosterId);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> deleteRoster(int rosterId, CancelToken cancelToken) {
    final api = AppApis.deleteRoster(rosterId);
    return AppClients().delete(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> openTasks(int companyId, int page, CancelToken cancelToken) {
    String api = AppApis.openTasks(companyId, page);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> inProgressTasks(
      int companyId, int page, CancelToken cancelToken) {
    String api = AppApis.inProgressTasks(companyId, page);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> doneTasks(int companyId, int page, CancelToken cancelToken) {
    String api = AppApis.doneTasks(companyId, page);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> checkRosterDateOfMonth(
      DateTime fromDate, DateTime toDate, CancelToken cancelToken) async {
    final String from = AppUtils.convertDayToString(fromDate, format: "yyyy-MM-dd");
    final String to = AppUtils.convertDayToString(toDate, format: "yyyy-MM-dd");
    final api = AppApis.checkRosterDateOfMonth(from, to);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> sendEmail(String email) async{
    // final FirebaseAuth _auth = FirebaseAuth.instance;

    // await _auth.verifyPhoneNumber();

    // String domainAPI = AppApis.domainAPI;
    String api = AppApis.sendEmail();
    final Map<String, dynamic> data = {"email": email, "send_to": 1};
    return AppClients().post(api, data: data);

    // final url = Uri.parse(domainAPI + api);
    // final response = await http.post(
    //   url,
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(data),
    // );

    // if (response.statusCode == 200) {
    //   final jsonResponse = json.decode(response.body);
    //   return jsonResponse;
    // } else {
    //   print('START BUG');
    //   print('Status code: ${response.statusCode}');
    //   print('Response body: ${response.body}');
    //   print('END BUG');
    //   return json.decode(response.body);
    // }
  }

  static Future<Response<dynamic>> changePhone(ChangeNumberRequest request) {
    String api = AppApis.changePhone();
    return AppClients().patch(api, data: request.toJson());
  }

  static Future<Response<dynamic>> createStore(String name) {
    String api = AppApis.createStore();
    return AppClients().post(api, data: {"name": name});
  }

  static Future<Response<dynamic>> updateStore(int id, String name) {
    String api = AppApis.editStore(id);
    return AppClients().put(api, data: {"name": name});
  }

  static Future<Response<dynamic>> deleteStore(int id) {
    String api = AppApis.deleteStore(id);
    return AppClients().delete(api);
  }

  static Future<Response<dynamic>> getStoresBusiness({String? search, String limit = ''}) {
    return AppClients().get(AppApis.getStoresBusiness());
  }

  static Future<Response<dynamic>> deleteAccount() {
    final api = AppApis.deleteAccount();
    return AppClients().delete(api);
  }

  static Future<Response<dynamic>> getEventsByDate(
      DateTime dateTime, int page, CancelToken cancelToken) async {
    final value = AppUtils.convertDayToString(dateTime, format: "yyyy-MM-dd");
    final api = AppApis.getEventsByDate(value, page);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> checkEventDateOfMonth(
      DateTime fromDate, DateTime toDate, CancelToken cancelToken) async {
    final String from = AppUtils.convertDayToString(fromDate, format: "yyyy-MM-dd");
    final String to = AppUtils.convertDayToString(toDate, format: "yyyy-MM-dd");
    final api = AppApis.checkEventDateOfMonth(from, to);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getCountEvent(
    CancelToken cancelToken, {
    List<String> eventTypes = const [],
  }) async {
    final api = AppApis.getCountEvent(eventTypes: eventTypes);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getEventsByConfirm(
    int page,
    CancelToken cancelToken, {
    List<String> eventTypes = const [],
  }) async {
    final api = AppApis.getEventsByConfirm(page, eventTypes: eventTypes);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getEventsByWaiting(
    int page,
    CancelToken cancelToken, {
    List<String> eventTypes = const [],
  }) async {
    final api = AppApis.getEventsByWaiting(page, eventTypes: eventTypes);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getEventsByDenied(
    int page,
    CancelToken cancelToken, {
    List<String> eventTypes = const [],
  }) async {
    final api = AppApis.getEventsByDenied(page, eventTypes: eventTypes);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getEventsByConfirmed(
    int page,
    CancelToken cancelToken, {
    List<String> eventTypes = const [],
  }) async {
    final api = AppApis.getEventsByConfirmed(page, eventTypes: eventTypes);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> confirmEvent(int id, CancelToken cancelToken) async {
    final api = AppApis.confirmEvent(id);
    return AppClients().post(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> denyEvent(int id, CancelToken cancelToken) async {
    final api = AppApis.denyEvent(id);
    return AppClients().post(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> leaveEvent(int id, CancelToken cancelToken) async {
    final api = AppApis.leaveEvent(id);
    return AppClients().post(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> deleteEvent(int id, CancelToken cancelToken) async {
    final api = AppApis.deleteEvent(id);
    return AppClients().delete(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getEventAlarmDevice(CancelToken cancelToken) {
    String api = AppApis.getEventAlarmDevice();
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> acceptRoster(int id, CancelToken cancelToken) async {
    final api = AppApis.acceptRoster(id);
    return AppClients().post(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> declineRoster(int id, CancelToken cancelToken) async {
    final api = AppApis.declineRoster(id);
    return AppClients().post(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> doneTask(int taskId, CancelToken cancelToken) {
    String api = AppApis.doneTask(taskId);
    return AppClients().post(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getNotifications(int page, CancelToken cancelToken) async {
    final api = AppApis.getNotifications(page: page);
    return AppClients().get(api, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> countNotifications() {
    final api = AppApis.countNotifications();
    return AppClients().get(api);
  }

  static Future<Response<dynamic>> updateWorkingDays(
      List<int> workingDays, CancelToken cancelToken) {
    String api = AppApis.updateWorkingDays();
    Map<String, dynamic> data = {'working_days': workingDays};
    return AppClients().post(api, data: data, cancelToken: cancelToken);
  }

  static Future<Response<dynamic>> getWorkData(
    CancelToken cancelToken, {
    int page = 1,
    required String status,
    List<String> types = const [],
  }) async {
    final api = AppApis.getWorkData(page: page, status: status, types: types);
    return AppClients().get(api, cancelToken: cancelToken);
  }
}
