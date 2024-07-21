class EmployeeDetail {
  int? id;
  String? name;
  String? employeeConfirm;

  EmployeeDetail({this.id, this.name, this.employeeConfirm});

  EmployeeDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    employeeConfirm = json["employee_confirm"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['employee_confirm'] = this.employeeConfirm;
    return data;
  }
}
