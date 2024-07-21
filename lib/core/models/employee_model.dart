class EmployeeModel {
  final int id;
  final String employeeName;
  final String employeeAvatar;
  final String roleName;

  EmployeeModel({
    required this.id,
    this.employeeName = '',
    this.employeeAvatar = '',
    this.roleName = '',
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] ?? 0,
      employeeName: json['employee_name'] ?? '',
      employeeAvatar: json['employee_avatar'] ?? '',
      roleName: json['role_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_name': employeeName,
      'employee_avatar': employeeAvatar,
      'role_name': roleName,
    };
  }
}
