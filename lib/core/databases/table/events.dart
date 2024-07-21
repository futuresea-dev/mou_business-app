import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/converter/list_converter.dart';
import 'package:mou_business_app/core/databases/converter/map_converter.dart';
import 'package:mou_business_app/utils/types/event_page_type.dart';
import 'package:mou_business_app/utils/types/event_status.dart';
import 'package:mou_business_app/utils/types/event_task_type.dart';
import 'package:mou_business_app/utils/types/work_status.dart';

class Events extends Table {
  IntColumn get id => integer()();

  TextColumn get title => text().nullable()();

  @JsonKey("start_date")
  TextColumn get startDate => text().named("start_date").nullable()();

  @JsonKey("end_date")
  TextColumn get endDate => text().named("end_date").nullable()();

  @JsonKey("project_start_date")
  TextColumn get projectStartDate => text().named("project_start_date").nullable()();

  @JsonKey("project_end_date")
  TextColumn get projectEndDate => text().named("project_end_date").nullable()();

  TextColumn get comment => text().nullable()();

  TextColumn get repeat => text().nullable()();

  TextColumn get alarm => text().nullable()();

  TextColumn get place => text().nullable()();

  @JsonKey("busy_mode")
  IntColumn get busyMode => integer().named("busy_mode").nullable()();

  TextColumn get creator => text().map(const MapConverter()).nullable()();

  TextColumn get users => text().map(const ListConverter()).nullable()();

  @JsonKey("waiting_to_confirm")
  BoolColumn get waitingToConfirm => boolean().named("waiting_to_confirm").nullable()();

  // this field is used to check in local, not available in api response
  TextColumn get eventStatus => textEnum<EventStatus>().nullable()();

  // this field is used to check in local, not available in api response
  TextColumn get workStatus => textEnum<WorkStatus>().nullable()();

  TextColumn get type => textEnum<EventTaskType>().nullable()();

  @JsonKey("project_name")
  TextColumn get projectName => text().named("project_name").nullable()();

  @JsonKey("company_photo")
  TextColumn get companyPhoto => text().named("company_photo").nullable()();

  @JsonKey("company_name")
  TextColumn get companyName => text().named("company_name").nullable()();

  @JsonKey("store_name")
  TextColumn get storeName => text().named("store_name").nullable()();

  @JsonKey("done_time")
  TextColumn get doneTime => text().named("done_time").nullable()();

  // dateLocal is used to save home events to local by date
  DateTimeColumn get dateLocal => dateTime().nullable()();

  @JsonKey("project_id")
  IntColumn get projectId => integer().named("project_id").nullable()();

  TextColumn get status => text().nullable()();

  @JsonKey("scope_name")
  TextColumn get scopeName => text().named("scope_name").nullable()();

  @JsonKey("client_name")
  TextColumn get clientName => text().named("client_name").nullable()();

  @JsonKey("leader_name")
  TextColumn get leaderName => text().named("leader_name").nullable()();

  // pageType is used to save events to local by page
  @JsonKey("page_type")
  TextColumn get pageType => textEnum<EventPageType>().named("page_type").nullable()();

  @override
  Set<Column> get primaryKey => {id, dateLocal, pageType};
}
