class AppApis {
  static const String domainAPI = "http://apimou.site/public";

  static String register() => "/api/v1/business/register-company";

  static String me() => "/api/v1/business/me";

  static String existPhone() => "/api/v1/business/exist-phone";

  static String getContacts() => "/api/v1/contacts";

  static String searchUsers(String search) => "/api/v1/user/search?q=$search";

  static String linkContact(int id) => "/api/v1/contacts/$id/link";

  static String addContact() => "/api/v1/contacts";

  static String editContact(int id) => "/api/v1/contacts/$id/edit";

  static String deleteContact(int id) => "/api/v1/contacts/$id";

  static String importContact() => "/api/v1/contacts/import-contacts";

  static String updateSetting() => "/api/v1/me/setting";

  static String connectContactFacebook() => "/api/v1/facebook/connect";

  static String importContactFacebook() => "/api/v1/facebook/import";

  static String getFacebookProfile(String token) => "/me?fields=id,name&access_token=$token";

  static String getFacebookFriends(String token) =>
      "/me/friends?fields=id,name&access_token=$token";

  static String sendFeedBack() => "/api/v1/feedback";

  static String getUpdateFCMToken() => "/api/v1/business/me/fcm-token";

  static String getDeleteFCMToken(String token) => "/api/v1/business/me/fcm-token/$token";

  static String addEmployee(int companyId) => "/api/v1/business/$companyId/employee";

  static String getEmployeeList(int companyId) => "/api/v1/business/$companyId/employee";

  static String addTask(int companyId) => "/api/v1/business/$companyId/task";

  static String updateLogo() => "/api/v1/business/me/company-logo";

  static String updateProfileCompany() => "/api/v1/business/me/company-profile";

  static String editEmployee(int employeeId, int companyId) =>
      "/api/v1/business/$companyId/employee/$employeeId/edit";

  static String deleteEmployee(int employeeId, int companyId) =>
      "/api/v1/business/$companyId/employee/$employeeId";

  static String addProject(int companyId) => "/api/v1/business/$companyId/project";

  static String getProjectDetail(int companyId, int projectId) =>
      "/api/v1/business/$companyId/project/$projectId";

  static String getTaskDetail(int companyId, int taskId) =>
      "/api/v1/business/$companyId/task/$taskId";

  static String editTask(int companyId, int taskId) =>
      "/api/v1/business/$companyId/task/$taskId/edit";

  static String deleteTask(int companyId, int taskId) => "/api/v1/business/$companyId/task/$taskId";

  static String deleteProject(int companyId, int projectId) =>
      "/api/v1/business/$companyId/project/$projectId";

  static String editProject(int companyId, int projectId) =>
      "/api/v1/business/$companyId/project/$projectId/edit";

  static String addTaskOfProject(int companyId, int taskId) =>
      "/api/v1/business/$companyId/project/$taskId/task";

  static String editTaskOfProject(int companyId, int projectId, int taskId) =>
      "/api/v1/business/$companyId/project/$projectId/task/$taskId/edit";

  static String deleteTaskOfProject(int companyId, int projectId, int taskId) =>
      "/api/v1/business/$companyId/project/$projectId/task/$taskId";

  static String exportReport(int projectId) => "/exports/report/project-task/$projectId";

  static String addRoster() => "/api/v1/business/rosters/create";

  static String updateRoster(int rosterId) => "/api/v1/business/rosters/$rosterId/update";

  static String getListRoster(String date, int page) =>
      "/api/v1/business/rosters?date=$date&page=$page";

  static String getRosterDetail(int rosterId) => "/api/v1/business/rosters/$rosterId";

  static String deleteRoster(int rosterId) => "/api/v1/business/rosters/$rosterId/delete";

  static String openTasks(int companyId, int page) =>
      "/api/v1/business/$companyId/task/open?page=$page";

  static String inProgressTasks(int companyId, int page) =>
      "/api/v1/business/$companyId/task/in-progress?page=$page";

  static String doneTasks(int companyId, int page) =>
      "/api/v1/business/$companyId/task/done?page=$page";

  static String checkRosterDateOfMonth(String startDate, String endDate) =>
      "/api/v1/business/rosters/status?start_date=$startDate&end_date=$endDate";

  static String sendEmail() => "/v1/change-phone/send-mail";

  static String changePhone() => "/api/v1/change-phone";

  static String getStoresBusiness() => "/api/v1/business/stores";

  static String createStore() => "/api/v1/business/stores";

  static String editStore(int id) => "/api/v1/business/stores/$id";

  static String deleteStore(int id) => "/api/v1/business/stores/$id";

  static String deleteAccount() => "/api/v1/user/destroy";

  static String getEventsByDate(
    String date,
    int page, {
    String userType = 'business',
  }) =>
      "/api/v1/event/date?start_date=$date&page=$page&user_type=$userType";

  static String checkEventDateOfMonth(
    String startDate,
    String endDate, {
    String type = 'business',
  }) =>
      "/api/v1/event/month?type=$type&start_date=$startDate&end_date=$endDate";

  static String getCountEvent({
    List<String> eventTypes = const [],
    String userType = 'business',
  }) {
    String baseUrl = "/api/v1/event/status/count?user_type=$userType";
    return baseUrl + eventTypes.map((e) => '&type[]=$e').join();
  }

  static String getEventsByConfirm(
    int page, {
    List<String> eventTypes = const [],
  }) {
    final baseUrl = "/api/v1/event/status/for-you-to-confirm?page=$page";
    return baseUrl + eventTypes.map((e) => '&type[]=$e').join();
  }

  static String getEventsByWaiting(
    int page, {
    List<String> eventTypes = const [],
    String userType = 'business',
  }) {
    final baseUrl = "/api/v1/event/status/waiting-to-confirm?page=$page&user_type=$userType";
    return baseUrl + eventTypes.map((e) => '&type[]=$e').join();
  }

  static String getEventsByDenied(
    int page, {
    List<String> eventTypes = const [],
    String userType = 'business',
  }) {
    final baseUrl = "/api/v1/event/status/denied?page=$page&user_type=$userType";
    return baseUrl + eventTypes.map((e) => '&type[]=$e').join();
  }

  static String getEventsByConfirmed(
    int page, {
    List<String> eventTypes = const [],
    String userType = 'business',
  }) {
    final baseUrl = "/api/v1/event/status/confirmed?page=$page&user_type=$userType";
    return baseUrl + eventTypes.map((e) => '&type[]=$e').join();
  }

  static String deleteEvent(int id) => "/api/v1/event/$id";

  static String confirmEvent(int id) => "/api/v1/event/$id/confirm";

  static String denyEvent(int id) => "/api/v1/event/$id/deny";

  static String leaveEvent(int id) => "/api/v1/event/$id/leave";

  static String acceptRoster(int id) => "/api/v1/personal/rosters/$id/accept";

  static String declineRoster(int id) => "/api/v1/personal/rosters/$id/decline";

  static String getEventAlarmDevice() => "/api/v1/event/alarm-device";

  static String doneTask(int taskId) => "/api/v1/business/personal/event-task/$taskId/done";

  static String getNotifications({
    String type = 'business',
    int page = 1,
    int limit = 10,
  }) =>
      "/api/v1/notifications?type=$type&page=$page&limit=$limit";

  static String countNotifications({String type = 'business'}) =>
      "/api/v1/notifications/count?type=$type";

  static String updateWorkingDays() => "/api/v1/business/me/working-days";

  static String getWorkData({
    int page = 1,
    required String status, // open/progress/done
    List<String> types = const [], // TASK/PROJECT_TASK/ROSTER
  }) =>
      "/api/v1/business/general?page=$page&status=$status" + types.map((e) => '&type[]=$e').join();
}
