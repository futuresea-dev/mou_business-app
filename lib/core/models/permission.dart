class Permission {
  bool? isCreator;
  bool? permissionAccessBusiness;
  bool? permissionAddTask;
  bool? permissionAddProject;
  bool? permissionAddEmployee;

  Permission({
    this.isCreator,
    this.permissionAccessBusiness,
    this.permissionAddTask,
    this.permissionAddEmployee,
    this.permissionAddProject
  });

  Permission.fromJson(Map<String, dynamic> json) {
    this.isCreator = json['is_creator'];
    this.permissionAccessBusiness = json['permission_access_business'];
    this.permissionAddTask = json['permission_add_task'];
    this.permissionAddProject = json['permission_add_project'];
    this.permissionAddEmployee = json['permission_add_employee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_creator'] = this.isCreator;
    data['permission_access_business'] = this.permissionAccessBusiness;
    data['permission_add_task'] = this.permissionAddTask;
    data['permission_add_project'] = this.permissionAddProject;
    data['permission_add_employee'] = this.permissionAddEmployee;
    return data;
  }
}
