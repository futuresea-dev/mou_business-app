import 'package:mou_business_app/core/databases/app_database.dart';

class RosterResponse {
  final int id;
  final Map<String, dynamic>? employee;
  final int? creatorId;
  final String status;
  final String startTime;
  final String endTime;
  final int page;
  final Map<String, dynamic>? store;

  RosterResponse({
    required this.id,
    this.employee,
    this.creatorId,
    required this.status,
    required this.startTime,
    required this.endTime,
    this.page = 0,
    this.store,
  });

  factory RosterResponse.fromJson(Map<String, dynamic> json) {
    return RosterResponse(
      id: json['id'] as int,
      employee: json['employee'] as Map<String, dynamic>?,
      creatorId: json['creator_id'] as int?,
      status: json['status'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      store: json['store'],
    );
  }

  Roster toRoster({
    int? id,
    Map<String, dynamic>? employee,
    int? creatorId,
    String? status,
    String? startTime,
    String? endTime,
    int? page,
    Map<String, dynamic>? store,
  }) {
    return Roster(
      id: id ?? this.id,
      employee: employee ?? this.employee,
      creatorId: creatorId ?? this.creatorId,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      page: page ?? this.page,
      store: store ?? this.store,
    );
  }
}
