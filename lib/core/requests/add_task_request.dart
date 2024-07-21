class AddTaskRequest {
  String? title;
  String? comment;
  List<int>? employees;
  DateTime? startDate;
  DateTime? endDate;
  String? repeat;
  int? storeId;

  AddTaskRequest({
    this.title,
    this.comment,
    this.employees,
    this.startDate,
    this.endDate,
    this.repeat,
    required this.storeId,
  });
}
