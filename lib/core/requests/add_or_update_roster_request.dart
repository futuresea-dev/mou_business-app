class AddOrUpdateRosterRequest {
  String? startTime;
  String? endTime;
  int? companyEmployeeId;
  int? storeId;

  AddOrUpdateRosterRequest({
    this.startTime,
    this.endTime,
    this.companyEmployeeId,
    this.storeId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'start_time': startTime,
      'end_time': endTime,
      'company_employee_id': companyEmployeeId,
      'store_id': storeId,
    };
  }
}
