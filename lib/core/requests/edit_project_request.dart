class EditProjectRequest {
  String? title;
  String? description;
  String? client;
  int? employeeResponsibleId;
  List<int>? teams;

  EditProjectRequest({
    this.title,
    this.description,
    this.client,
    this.employeeResponsibleId,
    this.teams,
  });
}
