class EditTaskRequest {
  String? title;
  String? comment;
  List<int>? employees;
  String? startDate;
  String? endDate;

  EditTaskRequest({
    this.title,
    this.comment,
    this.employees,
    this.startDate,
    this.endDate,
  });
}
