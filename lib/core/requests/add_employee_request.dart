class AddEmployeeRequest {
  int contactId;
  String roleName;
  int permissionAccessBusiness;
  int permissionAddTask;
  int permissionAddProject;
  int permissionAddEmployee;
  int permissionAddRoster;

  AddEmployeeRequest({
    required this.contactId,
    this.roleName = '',
    this.permissionAccessBusiness = 1,
    this.permissionAddTask = 1,
    this.permissionAddProject = 1,
    this.permissionAddEmployee = 1,
    this.permissionAddRoster = 1,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["contact_id"] = contactId;
    data["role_name"] = roleName;
    data["permission_access_business"] = permissionAccessBusiness;
    data["permission_add_task"] = permissionAddTask;
    data["permission_add_project"] = permissionAddProject;
    data["permission_add_employee"] = permissionAddEmployee;
    data["permission_add_roster"] = permissionAddRoster;
    return data;
  }
}
