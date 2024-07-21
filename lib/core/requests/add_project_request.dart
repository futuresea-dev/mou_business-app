import 'package:mou_business_app/core/databases/app_database.dart';

class AddProjectRequest {
  String? title;
  String? description;
  String? client;
  int? employeeResponsibleId;
  List<int>? teams;
  List<Task>? tasks;

  AddProjectRequest({
    this.title,
    this.description,
    this.client,
    this.employeeResponsibleId,
    this.teams,
    this.tasks,
  });
}
