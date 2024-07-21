import 'package:mou_business_app/core/databases/app_database.dart';

import 'employee.dart';

class TaskDetail {
  int? id;
  String? title;
  String? startDate;
  String? endDate;
  String? comment;
  List<EmployeeDetail>? employees;
  int? creatorId;
  String? repeat;
  String? status;
  String? employeeConfirm;
  Shop? shop;
  int? totalDeny;

  TaskDetail({
    this.id,
    this.title,
    this.startDate,
    this.endDate,
    this.comment,
    this.employees,
    this.creatorId,
    this.repeat,
    this.employeeConfirm,
    this.totalDeny,
  });

  TaskDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    comment = json['comment'];
    employees = json['employees'] != null
        ? (json['employees'] as List).map((json) => EmployeeDetail.fromJson(json)).toList()
        : null;
    creatorId = json['creator_id'];
    repeat = json['repeat'];
    status = json['status'];
    employeeConfirm = json['employee_confirm'];
    shop = json['store'] != null ? Shop.fromJson(json['store']) : null;
    totalDeny = json['total_deny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['comment'] = this.comment;
    if (this.employees != null) {
      data['employees'] = this.employees?.map((e) => e.toJson());
    }
    data['creator_id'] = this.creatorId;
    data['repeat'] = this.repeat;
    data['status'] = this.status;
    data['employee_confirm'] = this.employeeConfirm;
    data['total_deny'] = this.totalDeny;
    return data;
  }
}
