// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _projectStartDateMeta =
      const VerificationMeta('projectStartDate');
  @override
  late final GeneratedColumn<String> projectStartDate = GeneratedColumn<String>(
      'project_start_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _projectEndDateMeta =
      const VerificationMeta('projectEndDate');
  @override
  late final GeneratedColumn<String> projectEndDate = GeneratedColumn<String>(
      'project_end_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _repeatMeta = const VerificationMeta('repeat');
  @override
  late final GeneratedColumn<String> repeat = GeneratedColumn<String>(
      'repeat', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _alarmMeta = const VerificationMeta('alarm');
  @override
  late final GeneratedColumn<String> alarm = GeneratedColumn<String>(
      'alarm', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _placeMeta = const VerificationMeta('place');
  @override
  late final GeneratedColumn<String> place = GeneratedColumn<String>(
      'place', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _busyModeMeta =
      const VerificationMeta('busyMode');
  @override
  late final GeneratedColumn<int> busyMode = GeneratedColumn<int>(
      'busy_mode', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _creatorMeta =
      const VerificationMeta('creator');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      creator = GeneratedColumn<String>('creator', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $EventsTable.$convertercreatorn);
  static const VerificationMeta _usersMeta = const VerificationMeta('users');
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String> users =
      GeneratedColumn<String>('users', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<dynamic>?>($EventsTable.$converterusersn);
  static const VerificationMeta _waitingToConfirmMeta =
      const VerificationMeta('waitingToConfirm');
  @override
  late final GeneratedColumn<bool> waitingToConfirm = GeneratedColumn<bool>(
      'waiting_to_confirm', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("waiting_to_confirm" IN (0, 1))'));
  static const VerificationMeta _eventStatusMeta =
      const VerificationMeta('eventStatus');
  @override
  late final GeneratedColumnWithTypeConverter<EventStatus?, String>
      eventStatus = GeneratedColumn<String>('event_status', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EventStatus?>($EventsTable.$convertereventStatusn);
  static const VerificationMeta _workStatusMeta =
      const VerificationMeta('workStatus');
  @override
  late final GeneratedColumnWithTypeConverter<WorkStatus?, String> workStatus =
      GeneratedColumn<String>('work_status', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<WorkStatus?>($EventsTable.$converterworkStatusn);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<EventTaskType?, String> type =
      GeneratedColumn<String>('type', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EventTaskType?>($EventsTable.$convertertypen);
  static const VerificationMeta _projectNameMeta =
      const VerificationMeta('projectName');
  @override
  late final GeneratedColumn<String> projectName = GeneratedColumn<String>(
      'project_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyPhotoMeta =
      const VerificationMeta('companyPhoto');
  @override
  late final GeneratedColumn<String> companyPhoto = GeneratedColumn<String>(
      'company_photo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyNameMeta =
      const VerificationMeta('companyName');
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
      'company_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _storeNameMeta =
      const VerificationMeta('storeName');
  @override
  late final GeneratedColumn<String> storeName = GeneratedColumn<String>(
      'store_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _doneTimeMeta =
      const VerificationMeta('doneTime');
  @override
  late final GeneratedColumn<String> doneTime = GeneratedColumn<String>(
      'done_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateLocalMeta =
      const VerificationMeta('dateLocal');
  @override
  late final GeneratedColumn<DateTime> dateLocal = GeneratedColumn<DateTime>(
      'date_local', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
      'project_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _scopeNameMeta =
      const VerificationMeta('scopeName');
  @override
  late final GeneratedColumn<String> scopeName = GeneratedColumn<String>(
      'scope_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clientNameMeta =
      const VerificationMeta('clientName');
  @override
  late final GeneratedColumn<String> clientName = GeneratedColumn<String>(
      'client_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _leaderNameMeta =
      const VerificationMeta('leaderName');
  @override
  late final GeneratedColumn<String> leaderName = GeneratedColumn<String>(
      'leader_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pageTypeMeta =
      const VerificationMeta('pageType');
  @override
  late final GeneratedColumnWithTypeConverter<EventPageType?, String> pageType =
      GeneratedColumn<String>('page_type', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EventPageType?>($EventsTable.$converterpageTypen);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        startDate,
        endDate,
        projectStartDate,
        projectEndDate,
        comment,
        repeat,
        alarm,
        place,
        busyMode,
        creator,
        users,
        waitingToConfirm,
        eventStatus,
        workStatus,
        type,
        projectName,
        companyPhoto,
        companyName,
        storeName,
        doneTime,
        dateLocal,
        projectId,
        status,
        scopeName,
        clientName,
        leaderName,
        pageType
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('project_start_date')) {
      context.handle(
          _projectStartDateMeta,
          projectStartDate.isAcceptableOrUnknown(
              data['project_start_date']!, _projectStartDateMeta));
    }
    if (data.containsKey('project_end_date')) {
      context.handle(
          _projectEndDateMeta,
          projectEndDate.isAcceptableOrUnknown(
              data['project_end_date']!, _projectEndDateMeta));
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    }
    if (data.containsKey('repeat')) {
      context.handle(_repeatMeta,
          repeat.isAcceptableOrUnknown(data['repeat']!, _repeatMeta));
    }
    if (data.containsKey('alarm')) {
      context.handle(
          _alarmMeta, alarm.isAcceptableOrUnknown(data['alarm']!, _alarmMeta));
    }
    if (data.containsKey('place')) {
      context.handle(
          _placeMeta, place.isAcceptableOrUnknown(data['place']!, _placeMeta));
    }
    if (data.containsKey('busy_mode')) {
      context.handle(_busyModeMeta,
          busyMode.isAcceptableOrUnknown(data['busy_mode']!, _busyModeMeta));
    }
    context.handle(_creatorMeta, const VerificationResult.success());
    context.handle(_usersMeta, const VerificationResult.success());
    if (data.containsKey('waiting_to_confirm')) {
      context.handle(
          _waitingToConfirmMeta,
          waitingToConfirm.isAcceptableOrUnknown(
              data['waiting_to_confirm']!, _waitingToConfirmMeta));
    }
    context.handle(_eventStatusMeta, const VerificationResult.success());
    context.handle(_workStatusMeta, const VerificationResult.success());
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('project_name')) {
      context.handle(
          _projectNameMeta,
          projectName.isAcceptableOrUnknown(
              data['project_name']!, _projectNameMeta));
    }
    if (data.containsKey('company_photo')) {
      context.handle(
          _companyPhotoMeta,
          companyPhoto.isAcceptableOrUnknown(
              data['company_photo']!, _companyPhotoMeta));
    }
    if (data.containsKey('company_name')) {
      context.handle(
          _companyNameMeta,
          companyName.isAcceptableOrUnknown(
              data['company_name']!, _companyNameMeta));
    }
    if (data.containsKey('store_name')) {
      context.handle(_storeNameMeta,
          storeName.isAcceptableOrUnknown(data['store_name']!, _storeNameMeta));
    }
    if (data.containsKey('done_time')) {
      context.handle(_doneTimeMeta,
          doneTime.isAcceptableOrUnknown(data['done_time']!, _doneTimeMeta));
    }
    if (data.containsKey('date_local')) {
      context.handle(_dateLocalMeta,
          dateLocal.isAcceptableOrUnknown(data['date_local']!, _dateLocalMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('scope_name')) {
      context.handle(_scopeNameMeta,
          scopeName.isAcceptableOrUnknown(data['scope_name']!, _scopeNameMeta));
    }
    if (data.containsKey('client_name')) {
      context.handle(
          _clientNameMeta,
          clientName.isAcceptableOrUnknown(
              data['client_name']!, _clientNameMeta));
    }
    if (data.containsKey('leader_name')) {
      context.handle(
          _leaderNameMeta,
          leaderName.isAcceptableOrUnknown(
              data['leader_name']!, _leaderNameMeta));
    }
    context.handle(_pageTypeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, dateLocal, pageType};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date']),
      projectStartDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}project_start_date']),
      projectEndDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}project_end_date']),
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment']),
      repeat: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}repeat']),
      alarm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alarm']),
      place: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}place']),
      busyMode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}busy_mode']),
      creator: $EventsTable.$convertercreatorn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creator'])),
      users: $EventsTable.$converterusersn.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}users'])),
      waitingToConfirm: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}waiting_to_confirm']),
      eventStatus: $EventsTable.$convertereventStatusn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_status'])),
      workStatus: $EventsTable.$converterworkStatusn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_status'])),
      type: $EventsTable.$convertertypen.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])),
      projectName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_name']),
      companyPhoto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_photo']),
      companyName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_name']),
      storeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_name']),
      doneTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}done_time']),
      dateLocal: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_local']),
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}project_id']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      scopeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scope_name']),
      clientName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_name']),
      leaderName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}leader_name']),
      pageType: $EventsTable.$converterpageTypen.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}page_type'])),
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $convertercreator =
      const MapConverter();
  static TypeConverter<Map<String, dynamic>?, String?> $convertercreatorn =
      NullAwareTypeConverter.wrap($convertercreator);
  static TypeConverter<List<dynamic>, String> $converterusers =
      const ListConverter();
  static TypeConverter<List<dynamic>?, String?> $converterusersn =
      NullAwareTypeConverter.wrap($converterusers);
  static JsonTypeConverter2<EventStatus, String, String> $convertereventStatus =
      const EnumNameConverter<EventStatus>(EventStatus.values);
  static JsonTypeConverter2<EventStatus?, String?, String?>
      $convertereventStatusn =
      JsonTypeConverter2.asNullable($convertereventStatus);
  static JsonTypeConverter2<WorkStatus, String, String> $converterworkStatus =
      const EnumNameConverter<WorkStatus>(WorkStatus.values);
  static JsonTypeConverter2<WorkStatus?, String?, String?>
      $converterworkStatusn =
      JsonTypeConverter2.asNullable($converterworkStatus);
  static JsonTypeConverter2<EventTaskType, String, String> $convertertype =
      const EnumNameConverter<EventTaskType>(EventTaskType.values);
  static JsonTypeConverter2<EventTaskType?, String?, String?> $convertertypen =
      JsonTypeConverter2.asNullable($convertertype);
  static JsonTypeConverter2<EventPageType, String, String> $converterpageType =
      const EnumNameConverter<EventPageType>(EventPageType.values);
  static JsonTypeConverter2<EventPageType?, String?, String?>
      $converterpageTypen = JsonTypeConverter2.asNullable($converterpageType);
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final String? title;
  final String? startDate;
  final String? endDate;
  final String? projectStartDate;
  final String? projectEndDate;
  final String? comment;
  final String? repeat;
  final String? alarm;
  final String? place;
  final int? busyMode;
  final Map<String, dynamic>? creator;
  final List<dynamic>? users;
  final bool? waitingToConfirm;
  final EventStatus? eventStatus;
  final WorkStatus? workStatus;
  final EventTaskType? type;
  final String? projectName;
  final String? companyPhoto;
  final String? companyName;
  final String? storeName;
  final String? doneTime;
  final DateTime? dateLocal;
  final int? projectId;
  final String? status;
  final String? scopeName;
  final String? clientName;
  final String? leaderName;
  final EventPageType? pageType;
  const Event(
      {required this.id,
      this.title,
      this.startDate,
      this.endDate,
      this.projectStartDate,
      this.projectEndDate,
      this.comment,
      this.repeat,
      this.alarm,
      this.place,
      this.busyMode,
      this.creator,
      this.users,
      this.waitingToConfirm,
      this.eventStatus,
      this.workStatus,
      this.type,
      this.projectName,
      this.companyPhoto,
      this.companyName,
      this.storeName,
      this.doneTime,
      this.dateLocal,
      this.projectId,
      this.status,
      this.scopeName,
      this.clientName,
      this.leaderName,
      this.pageType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<String>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    if (!nullToAbsent || projectStartDate != null) {
      map['project_start_date'] = Variable<String>(projectStartDate);
    }
    if (!nullToAbsent || projectEndDate != null) {
      map['project_end_date'] = Variable<String>(projectEndDate);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    if (!nullToAbsent || repeat != null) {
      map['repeat'] = Variable<String>(repeat);
    }
    if (!nullToAbsent || alarm != null) {
      map['alarm'] = Variable<String>(alarm);
    }
    if (!nullToAbsent || place != null) {
      map['place'] = Variable<String>(place);
    }
    if (!nullToAbsent || busyMode != null) {
      map['busy_mode'] = Variable<int>(busyMode);
    }
    if (!nullToAbsent || creator != null) {
      final converter = $EventsTable.$convertercreatorn;
      map['creator'] = Variable<String>(converter.toSql(creator));
    }
    if (!nullToAbsent || users != null) {
      final converter = $EventsTable.$converterusersn;
      map['users'] = Variable<String>(converter.toSql(users));
    }
    if (!nullToAbsent || waitingToConfirm != null) {
      map['waiting_to_confirm'] = Variable<bool>(waitingToConfirm);
    }
    if (!nullToAbsent || eventStatus != null) {
      final converter = $EventsTable.$convertereventStatusn;
      map['event_status'] = Variable<String>(converter.toSql(eventStatus));
    }
    if (!nullToAbsent || workStatus != null) {
      final converter = $EventsTable.$converterworkStatusn;
      map['work_status'] = Variable<String>(converter.toSql(workStatus));
    }
    if (!nullToAbsent || type != null) {
      final converter = $EventsTable.$convertertypen;
      map['type'] = Variable<String>(converter.toSql(type));
    }
    if (!nullToAbsent || projectName != null) {
      map['project_name'] = Variable<String>(projectName);
    }
    if (!nullToAbsent || companyPhoto != null) {
      map['company_photo'] = Variable<String>(companyPhoto);
    }
    if (!nullToAbsent || companyName != null) {
      map['company_name'] = Variable<String>(companyName);
    }
    if (!nullToAbsent || storeName != null) {
      map['store_name'] = Variable<String>(storeName);
    }
    if (!nullToAbsent || doneTime != null) {
      map['done_time'] = Variable<String>(doneTime);
    }
    if (!nullToAbsent || dateLocal != null) {
      map['date_local'] = Variable<DateTime>(dateLocal);
    }
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<int>(projectId);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || scopeName != null) {
      map['scope_name'] = Variable<String>(scopeName);
    }
    if (!nullToAbsent || clientName != null) {
      map['client_name'] = Variable<String>(clientName);
    }
    if (!nullToAbsent || leaderName != null) {
      map['leader_name'] = Variable<String>(leaderName);
    }
    if (!nullToAbsent || pageType != null) {
      final converter = $EventsTable.$converterpageTypen;
      map['page_type'] = Variable<String>(converter.toSql(pageType));
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      projectStartDate: projectStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(projectStartDate),
      projectEndDate: projectEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(projectEndDate),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      repeat:
          repeat == null && nullToAbsent ? const Value.absent() : Value(repeat),
      alarm:
          alarm == null && nullToAbsent ? const Value.absent() : Value(alarm),
      place:
          place == null && nullToAbsent ? const Value.absent() : Value(place),
      busyMode: busyMode == null && nullToAbsent
          ? const Value.absent()
          : Value(busyMode),
      creator: creator == null && nullToAbsent
          ? const Value.absent()
          : Value(creator),
      users:
          users == null && nullToAbsent ? const Value.absent() : Value(users),
      waitingToConfirm: waitingToConfirm == null && nullToAbsent
          ? const Value.absent()
          : Value(waitingToConfirm),
      eventStatus: eventStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(eventStatus),
      workStatus: workStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(workStatus),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      projectName: projectName == null && nullToAbsent
          ? const Value.absent()
          : Value(projectName),
      companyPhoto: companyPhoto == null && nullToAbsent
          ? const Value.absent()
          : Value(companyPhoto),
      companyName: companyName == null && nullToAbsent
          ? const Value.absent()
          : Value(companyName),
      storeName: storeName == null && nullToAbsent
          ? const Value.absent()
          : Value(storeName),
      doneTime: doneTime == null && nullToAbsent
          ? const Value.absent()
          : Value(doneTime),
      dateLocal: dateLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(dateLocal),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      scopeName: scopeName == null && nullToAbsent
          ? const Value.absent()
          : Value(scopeName),
      clientName: clientName == null && nullToAbsent
          ? const Value.absent()
          : Value(clientName),
      leaderName: leaderName == null && nullToAbsent
          ? const Value.absent()
          : Value(leaderName),
      pageType: pageType == null && nullToAbsent
          ? const Value.absent()
          : Value(pageType),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      startDate: serializer.fromJson<String?>(json['start_date']),
      endDate: serializer.fromJson<String?>(json['end_date']),
      projectStartDate:
          serializer.fromJson<String?>(json['project_start_date']),
      projectEndDate: serializer.fromJson<String?>(json['project_end_date']),
      comment: serializer.fromJson<String?>(json['comment']),
      repeat: serializer.fromJson<String?>(json['repeat']),
      alarm: serializer.fromJson<String?>(json['alarm']),
      place: serializer.fromJson<String?>(json['place']),
      busyMode: serializer.fromJson<int?>(json['busy_mode']),
      creator: serializer.fromJson<Map<String, dynamic>?>(json['creator']),
      users: serializer.fromJson<List<dynamic>?>(json['users']),
      waitingToConfirm: serializer.fromJson<bool?>(json['waiting_to_confirm']),
      eventStatus: $EventsTable.$convertereventStatusn
          .fromJson(serializer.fromJson<String?>(json['eventStatus'])),
      workStatus: $EventsTable.$converterworkStatusn
          .fromJson(serializer.fromJson<String?>(json['workStatus'])),
      type: $EventsTable.$convertertypen
          .fromJson(serializer.fromJson<String?>(json['type'])),
      projectName: serializer.fromJson<String?>(json['project_name']),
      companyPhoto: serializer.fromJson<String?>(json['company_photo']),
      companyName: serializer.fromJson<String?>(json['company_name']),
      storeName: serializer.fromJson<String?>(json['store_name']),
      doneTime: serializer.fromJson<String?>(json['done_time']),
      dateLocal: serializer.fromJson<DateTime?>(json['dateLocal']),
      projectId: serializer.fromJson<int?>(json['project_id']),
      status: serializer.fromJson<String?>(json['status']),
      scopeName: serializer.fromJson<String?>(json['scope_name']),
      clientName: serializer.fromJson<String?>(json['client_name']),
      leaderName: serializer.fromJson<String?>(json['leader_name']),
      pageType: $EventsTable.$converterpageTypen
          .fromJson(serializer.fromJson<String?>(json['page_type'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'start_date': serializer.toJson<String?>(startDate),
      'end_date': serializer.toJson<String?>(endDate),
      'project_start_date': serializer.toJson<String?>(projectStartDate),
      'project_end_date': serializer.toJson<String?>(projectEndDate),
      'comment': serializer.toJson<String?>(comment),
      'repeat': serializer.toJson<String?>(repeat),
      'alarm': serializer.toJson<String?>(alarm),
      'place': serializer.toJson<String?>(place),
      'busy_mode': serializer.toJson<int?>(busyMode),
      'creator': serializer.toJson<Map<String, dynamic>?>(creator),
      'users': serializer.toJson<List<dynamic>?>(users),
      'waiting_to_confirm': serializer.toJson<bool?>(waitingToConfirm),
      'eventStatus': serializer.toJson<String?>(
          $EventsTable.$convertereventStatusn.toJson(eventStatus)),
      'workStatus': serializer.toJson<String?>(
          $EventsTable.$converterworkStatusn.toJson(workStatus)),
      'type':
          serializer.toJson<String?>($EventsTable.$convertertypen.toJson(type)),
      'project_name': serializer.toJson<String?>(projectName),
      'company_photo': serializer.toJson<String?>(companyPhoto),
      'company_name': serializer.toJson<String?>(companyName),
      'store_name': serializer.toJson<String?>(storeName),
      'done_time': serializer.toJson<String?>(doneTime),
      'dateLocal': serializer.toJson<DateTime?>(dateLocal),
      'project_id': serializer.toJson<int?>(projectId),
      'status': serializer.toJson<String?>(status),
      'scope_name': serializer.toJson<String?>(scopeName),
      'client_name': serializer.toJson<String?>(clientName),
      'leader_name': serializer.toJson<String?>(leaderName),
      'page_type': serializer
          .toJson<String?>($EventsTable.$converterpageTypen.toJson(pageType)),
    };
  }

  Event copyWith(
          {int? id,
          Value<String?> title = const Value.absent(),
          Value<String?> startDate = const Value.absent(),
          Value<String?> endDate = const Value.absent(),
          Value<String?> projectStartDate = const Value.absent(),
          Value<String?> projectEndDate = const Value.absent(),
          Value<String?> comment = const Value.absent(),
          Value<String?> repeat = const Value.absent(),
          Value<String?> alarm = const Value.absent(),
          Value<String?> place = const Value.absent(),
          Value<int?> busyMode = const Value.absent(),
          Value<Map<String, dynamic>?> creator = const Value.absent(),
          Value<List<dynamic>?> users = const Value.absent(),
          Value<bool?> waitingToConfirm = const Value.absent(),
          Value<EventStatus?> eventStatus = const Value.absent(),
          Value<WorkStatus?> workStatus = const Value.absent(),
          Value<EventTaskType?> type = const Value.absent(),
          Value<String?> projectName = const Value.absent(),
          Value<String?> companyPhoto = const Value.absent(),
          Value<String?> companyName = const Value.absent(),
          Value<String?> storeName = const Value.absent(),
          Value<String?> doneTime = const Value.absent(),
          Value<DateTime?> dateLocal = const Value.absent(),
          Value<int?> projectId = const Value.absent(),
          Value<String?> status = const Value.absent(),
          Value<String?> scopeName = const Value.absent(),
          Value<String?> clientName = const Value.absent(),
          Value<String?> leaderName = const Value.absent(),
          Value<EventPageType?> pageType = const Value.absent()}) =>
      Event(
        id: id ?? this.id,
        title: title.present ? title.value : this.title,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        projectStartDate: projectStartDate.present
            ? projectStartDate.value
            : this.projectStartDate,
        projectEndDate:
            projectEndDate.present ? projectEndDate.value : this.projectEndDate,
        comment: comment.present ? comment.value : this.comment,
        repeat: repeat.present ? repeat.value : this.repeat,
        alarm: alarm.present ? alarm.value : this.alarm,
        place: place.present ? place.value : this.place,
        busyMode: busyMode.present ? busyMode.value : this.busyMode,
        creator: creator.present ? creator.value : this.creator,
        users: users.present ? users.value : this.users,
        waitingToConfirm: waitingToConfirm.present
            ? waitingToConfirm.value
            : this.waitingToConfirm,
        eventStatus: eventStatus.present ? eventStatus.value : this.eventStatus,
        workStatus: workStatus.present ? workStatus.value : this.workStatus,
        type: type.present ? type.value : this.type,
        projectName: projectName.present ? projectName.value : this.projectName,
        companyPhoto:
            companyPhoto.present ? companyPhoto.value : this.companyPhoto,
        companyName: companyName.present ? companyName.value : this.companyName,
        storeName: storeName.present ? storeName.value : this.storeName,
        doneTime: doneTime.present ? doneTime.value : this.doneTime,
        dateLocal: dateLocal.present ? dateLocal.value : this.dateLocal,
        projectId: projectId.present ? projectId.value : this.projectId,
        status: status.present ? status.value : this.status,
        scopeName: scopeName.present ? scopeName.value : this.scopeName,
        clientName: clientName.present ? clientName.value : this.clientName,
        leaderName: leaderName.present ? leaderName.value : this.leaderName,
        pageType: pageType.present ? pageType.value : this.pageType,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('projectStartDate: $projectStartDate, ')
          ..write('projectEndDate: $projectEndDate, ')
          ..write('comment: $comment, ')
          ..write('repeat: $repeat, ')
          ..write('alarm: $alarm, ')
          ..write('place: $place, ')
          ..write('busyMode: $busyMode, ')
          ..write('creator: $creator, ')
          ..write('users: $users, ')
          ..write('waitingToConfirm: $waitingToConfirm, ')
          ..write('eventStatus: $eventStatus, ')
          ..write('workStatus: $workStatus, ')
          ..write('type: $type, ')
          ..write('projectName: $projectName, ')
          ..write('companyPhoto: $companyPhoto, ')
          ..write('companyName: $companyName, ')
          ..write('storeName: $storeName, ')
          ..write('doneTime: $doneTime, ')
          ..write('dateLocal: $dateLocal, ')
          ..write('projectId: $projectId, ')
          ..write('status: $status, ')
          ..write('scopeName: $scopeName, ')
          ..write('clientName: $clientName, ')
          ..write('leaderName: $leaderName, ')
          ..write('pageType: $pageType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        title,
        startDate,
        endDate,
        projectStartDate,
        projectEndDate,
        comment,
        repeat,
        alarm,
        place,
        busyMode,
        creator,
        users,
        waitingToConfirm,
        eventStatus,
        workStatus,
        type,
        projectName,
        companyPhoto,
        companyName,
        storeName,
        doneTime,
        dateLocal,
        projectId,
        status,
        scopeName,
        clientName,
        leaderName,
        pageType
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.title == this.title &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.projectStartDate == this.projectStartDate &&
          other.projectEndDate == this.projectEndDate &&
          other.comment == this.comment &&
          other.repeat == this.repeat &&
          other.alarm == this.alarm &&
          other.place == this.place &&
          other.busyMode == this.busyMode &&
          other.creator == this.creator &&
          other.users == this.users &&
          other.waitingToConfirm == this.waitingToConfirm &&
          other.eventStatus == this.eventStatus &&
          other.workStatus == this.workStatus &&
          other.type == this.type &&
          other.projectName == this.projectName &&
          other.companyPhoto == this.companyPhoto &&
          other.companyName == this.companyName &&
          other.storeName == this.storeName &&
          other.doneTime == this.doneTime &&
          other.dateLocal == this.dateLocal &&
          other.projectId == this.projectId &&
          other.status == this.status &&
          other.scopeName == this.scopeName &&
          other.clientName == this.clientName &&
          other.leaderName == this.leaderName &&
          other.pageType == this.pageType);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> startDate;
  final Value<String?> endDate;
  final Value<String?> projectStartDate;
  final Value<String?> projectEndDate;
  final Value<String?> comment;
  final Value<String?> repeat;
  final Value<String?> alarm;
  final Value<String?> place;
  final Value<int?> busyMode;
  final Value<Map<String, dynamic>?> creator;
  final Value<List<dynamic>?> users;
  final Value<bool?> waitingToConfirm;
  final Value<EventStatus?> eventStatus;
  final Value<WorkStatus?> workStatus;
  final Value<EventTaskType?> type;
  final Value<String?> projectName;
  final Value<String?> companyPhoto;
  final Value<String?> companyName;
  final Value<String?> storeName;
  final Value<String?> doneTime;
  final Value<DateTime?> dateLocal;
  final Value<int?> projectId;
  final Value<String?> status;
  final Value<String?> scopeName;
  final Value<String?> clientName;
  final Value<String?> leaderName;
  final Value<EventPageType?> pageType;
  final Value<int> rowid;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.projectStartDate = const Value.absent(),
    this.projectEndDate = const Value.absent(),
    this.comment = const Value.absent(),
    this.repeat = const Value.absent(),
    this.alarm = const Value.absent(),
    this.place = const Value.absent(),
    this.busyMode = const Value.absent(),
    this.creator = const Value.absent(),
    this.users = const Value.absent(),
    this.waitingToConfirm = const Value.absent(),
    this.eventStatus = const Value.absent(),
    this.workStatus = const Value.absent(),
    this.type = const Value.absent(),
    this.projectName = const Value.absent(),
    this.companyPhoto = const Value.absent(),
    this.companyName = const Value.absent(),
    this.storeName = const Value.absent(),
    this.doneTime = const Value.absent(),
    this.dateLocal = const Value.absent(),
    this.projectId = const Value.absent(),
    this.status = const Value.absent(),
    this.scopeName = const Value.absent(),
    this.clientName = const Value.absent(),
    this.leaderName = const Value.absent(),
    this.pageType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsCompanion.insert({
    required int id,
    this.title = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.projectStartDate = const Value.absent(),
    this.projectEndDate = const Value.absent(),
    this.comment = const Value.absent(),
    this.repeat = const Value.absent(),
    this.alarm = const Value.absent(),
    this.place = const Value.absent(),
    this.busyMode = const Value.absent(),
    this.creator = const Value.absent(),
    this.users = const Value.absent(),
    this.waitingToConfirm = const Value.absent(),
    this.eventStatus = const Value.absent(),
    this.workStatus = const Value.absent(),
    this.type = const Value.absent(),
    this.projectName = const Value.absent(),
    this.companyPhoto = const Value.absent(),
    this.companyName = const Value.absent(),
    this.storeName = const Value.absent(),
    this.doneTime = const Value.absent(),
    this.dateLocal = const Value.absent(),
    this.projectId = const Value.absent(),
    this.status = const Value.absent(),
    this.scopeName = const Value.absent(),
    this.clientName = const Value.absent(),
    this.leaderName = const Value.absent(),
    this.pageType = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? projectStartDate,
    Expression<String>? projectEndDate,
    Expression<String>? comment,
    Expression<String>? repeat,
    Expression<String>? alarm,
    Expression<String>? place,
    Expression<int>? busyMode,
    Expression<String>? creator,
    Expression<String>? users,
    Expression<bool>? waitingToConfirm,
    Expression<String>? eventStatus,
    Expression<String>? workStatus,
    Expression<String>? type,
    Expression<String>? projectName,
    Expression<String>? companyPhoto,
    Expression<String>? companyName,
    Expression<String>? storeName,
    Expression<String>? doneTime,
    Expression<DateTime>? dateLocal,
    Expression<int>? projectId,
    Expression<String>? status,
    Expression<String>? scopeName,
    Expression<String>? clientName,
    Expression<String>? leaderName,
    Expression<String>? pageType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (projectStartDate != null) 'project_start_date': projectStartDate,
      if (projectEndDate != null) 'project_end_date': projectEndDate,
      if (comment != null) 'comment': comment,
      if (repeat != null) 'repeat': repeat,
      if (alarm != null) 'alarm': alarm,
      if (place != null) 'place': place,
      if (busyMode != null) 'busy_mode': busyMode,
      if (creator != null) 'creator': creator,
      if (users != null) 'users': users,
      if (waitingToConfirm != null) 'waiting_to_confirm': waitingToConfirm,
      if (eventStatus != null) 'event_status': eventStatus,
      if (workStatus != null) 'work_status': workStatus,
      if (type != null) 'type': type,
      if (projectName != null) 'project_name': projectName,
      if (companyPhoto != null) 'company_photo': companyPhoto,
      if (companyName != null) 'company_name': companyName,
      if (storeName != null) 'store_name': storeName,
      if (doneTime != null) 'done_time': doneTime,
      if (dateLocal != null) 'date_local': dateLocal,
      if (projectId != null) 'project_id': projectId,
      if (status != null) 'status': status,
      if (scopeName != null) 'scope_name': scopeName,
      if (clientName != null) 'client_name': clientName,
      if (leaderName != null) 'leader_name': leaderName,
      if (pageType != null) 'page_type': pageType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? title,
      Value<String?>? startDate,
      Value<String?>? endDate,
      Value<String?>? projectStartDate,
      Value<String?>? projectEndDate,
      Value<String?>? comment,
      Value<String?>? repeat,
      Value<String?>? alarm,
      Value<String?>? place,
      Value<int?>? busyMode,
      Value<Map<String, dynamic>?>? creator,
      Value<List<dynamic>?>? users,
      Value<bool?>? waitingToConfirm,
      Value<EventStatus?>? eventStatus,
      Value<WorkStatus?>? workStatus,
      Value<EventTaskType?>? type,
      Value<String?>? projectName,
      Value<String?>? companyPhoto,
      Value<String?>? companyName,
      Value<String?>? storeName,
      Value<String?>? doneTime,
      Value<DateTime?>? dateLocal,
      Value<int?>? projectId,
      Value<String?>? status,
      Value<String?>? scopeName,
      Value<String?>? clientName,
      Value<String?>? leaderName,
      Value<EventPageType?>? pageType,
      Value<int>? rowid}) {
    return EventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      projectStartDate: projectStartDate ?? this.projectStartDate,
      projectEndDate: projectEndDate ?? this.projectEndDate,
      comment: comment ?? this.comment,
      repeat: repeat ?? this.repeat,
      alarm: alarm ?? this.alarm,
      place: place ?? this.place,
      busyMode: busyMode ?? this.busyMode,
      creator: creator ?? this.creator,
      users: users ?? this.users,
      waitingToConfirm: waitingToConfirm ?? this.waitingToConfirm,
      eventStatus: eventStatus ?? this.eventStatus,
      workStatus: workStatus ?? this.workStatus,
      type: type ?? this.type,
      projectName: projectName ?? this.projectName,
      companyPhoto: companyPhoto ?? this.companyPhoto,
      companyName: companyName ?? this.companyName,
      storeName: storeName ?? this.storeName,
      doneTime: doneTime ?? this.doneTime,
      dateLocal: dateLocal ?? this.dateLocal,
      projectId: projectId ?? this.projectId,
      status: status ?? this.status,
      scopeName: scopeName ?? this.scopeName,
      clientName: clientName ?? this.clientName,
      leaderName: leaderName ?? this.leaderName,
      pageType: pageType ?? this.pageType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (projectStartDate.present) {
      map['project_start_date'] = Variable<String>(projectStartDate.value);
    }
    if (projectEndDate.present) {
      map['project_end_date'] = Variable<String>(projectEndDate.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (repeat.present) {
      map['repeat'] = Variable<String>(repeat.value);
    }
    if (alarm.present) {
      map['alarm'] = Variable<String>(alarm.value);
    }
    if (place.present) {
      map['place'] = Variable<String>(place.value);
    }
    if (busyMode.present) {
      map['busy_mode'] = Variable<int>(busyMode.value);
    }
    if (creator.present) {
      final converter = $EventsTable.$convertercreatorn;

      map['creator'] = Variable<String>(converter.toSql(creator.value));
    }
    if (users.present) {
      final converter = $EventsTable.$converterusersn;

      map['users'] = Variable<String>(converter.toSql(users.value));
    }
    if (waitingToConfirm.present) {
      map['waiting_to_confirm'] = Variable<bool>(waitingToConfirm.value);
    }
    if (eventStatus.present) {
      final converter = $EventsTable.$convertereventStatusn;

      map['event_status'] =
          Variable<String>(converter.toSql(eventStatus.value));
    }
    if (workStatus.present) {
      final converter = $EventsTable.$converterworkStatusn;

      map['work_status'] = Variable<String>(converter.toSql(workStatus.value));
    }
    if (type.present) {
      final converter = $EventsTable.$convertertypen;

      map['type'] = Variable<String>(converter.toSql(type.value));
    }
    if (projectName.present) {
      map['project_name'] = Variable<String>(projectName.value);
    }
    if (companyPhoto.present) {
      map['company_photo'] = Variable<String>(companyPhoto.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (storeName.present) {
      map['store_name'] = Variable<String>(storeName.value);
    }
    if (doneTime.present) {
      map['done_time'] = Variable<String>(doneTime.value);
    }
    if (dateLocal.present) {
      map['date_local'] = Variable<DateTime>(dateLocal.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (scopeName.present) {
      map['scope_name'] = Variable<String>(scopeName.value);
    }
    if (clientName.present) {
      map['client_name'] = Variable<String>(clientName.value);
    }
    if (leaderName.present) {
      map['leader_name'] = Variable<String>(leaderName.value);
    }
    if (pageType.present) {
      final converter = $EventsTable.$converterpageTypen;

      map['page_type'] = Variable<String>(converter.toSql(pageType.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('projectStartDate: $projectStartDate, ')
          ..write('projectEndDate: $projectEndDate, ')
          ..write('comment: $comment, ')
          ..write('repeat: $repeat, ')
          ..write('alarm: $alarm, ')
          ..write('place: $place, ')
          ..write('busyMode: $busyMode, ')
          ..write('creator: $creator, ')
          ..write('users: $users, ')
          ..write('waitingToConfirm: $waitingToConfirm, ')
          ..write('eventStatus: $eventStatus, ')
          ..write('workStatus: $workStatus, ')
          ..write('type: $type, ')
          ..write('projectName: $projectName, ')
          ..write('companyPhoto: $companyPhoto, ')
          ..write('companyName: $companyName, ')
          ..write('storeName: $storeName, ')
          ..write('doneTime: $doneTime, ')
          ..write('dateLocal: $dateLocal, ')
          ..write('projectId: $projectId, ')
          ..write('status: $status, ')
          ..write('scopeName: $scopeName, ')
          ..write('clientName: $clientName, ')
          ..write('leaderName: $leaderName, ')
          ..write('pageType: $pageType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fullAddressMeta =
      const VerificationMeta('fullAddress');
  @override
  late final GeneratedColumn<String> fullAddress = GeneratedColumn<String>(
      'full_address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<String> birthday = GeneratedColumn<String>(
      'birthday', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<int> gender = GeneratedColumn<int>(
      'gender', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _countryCodeMeta =
      const VerificationMeta('countryCode');
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
      'country_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dialCodeMeta =
      const VerificationMeta('dialCode');
  @override
  late final GeneratedColumn<String> dialCode = GeneratedColumn<String>(
      'dial_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
      'avatar', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
      'page', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        email,
        fullAddress,
        birthday,
        gender,
        countryCode,
        city,
        phoneNumber,
        dialCode,
        avatar,
        page
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('full_address')) {
      context.handle(
          _fullAddressMeta,
          fullAddress.isAcceptableOrUnknown(
              data['full_address']!, _fullAddressMeta));
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('country_code')) {
      context.handle(
          _countryCodeMeta,
          countryCode.isAcceptableOrUnknown(
              data['country_code']!, _countryCodeMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('dial_code')) {
      context.handle(_dialCodeMeta,
          dialCode.isAcceptableOrUnknown(data['dial_code']!, _dialCodeMeta));
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    }
    if (data.containsKey('page')) {
      context.handle(
          _pageMeta, page.isAcceptableOrUnknown(data['page']!, _pageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      fullAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_address']),
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}birthday']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gender']),
      countryCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country_code']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city']),
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number']),
      dialCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dial_code']),
      avatar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar']),
      page: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page']),
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final String? name;
  final String? email;
  final String? fullAddress;
  final String? birthday;
  final int? gender;
  final String? countryCode;
  final String? city;
  final String? phoneNumber;
  final String? dialCode;
  final String? avatar;
  final int? page;
  const Contact(
      {required this.id,
      this.name,
      this.email,
      this.fullAddress,
      this.birthday,
      this.gender,
      this.countryCode,
      this.city,
      this.phoneNumber,
      this.dialCode,
      this.avatar,
      this.page});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || fullAddress != null) {
      map['full_address'] = Variable<String>(fullAddress);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<String>(birthday);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<int>(gender);
    }
    if (!nullToAbsent || countryCode != null) {
      map['country_code'] = Variable<String>(countryCode);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || dialCode != null) {
      map['dial_code'] = Variable<String>(dialCode);
    }
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    if (!nullToAbsent || page != null) {
      map['page'] = Variable<int>(page);
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      fullAddress: fullAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(fullAddress),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      countryCode: countryCode == null && nullToAbsent
          ? const Value.absent()
          : Value(countryCode),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      dialCode: dialCode == null && nullToAbsent
          ? const Value.absent()
          : Value(dialCode),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      page: page == null && nullToAbsent ? const Value.absent() : Value(page),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      fullAddress: serializer.fromJson<String?>(json['full_address']),
      birthday: serializer.fromJson<String?>(json['birthday']),
      gender: serializer.fromJson<int?>(json['gender']),
      countryCode: serializer.fromJson<String?>(json['country_code']),
      city: serializer.fromJson<String?>(json['city']),
      phoneNumber: serializer.fromJson<String?>(json['phone_number']),
      dialCode: serializer.fromJson<String?>(json['dial_code']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      page: serializer.fromJson<int?>(json['page']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'email': serializer.toJson<String?>(email),
      'full_address': serializer.toJson<String?>(fullAddress),
      'birthday': serializer.toJson<String?>(birthday),
      'gender': serializer.toJson<int?>(gender),
      'country_code': serializer.toJson<String?>(countryCode),
      'city': serializer.toJson<String?>(city),
      'phone_number': serializer.toJson<String?>(phoneNumber),
      'dial_code': serializer.toJson<String?>(dialCode),
      'avatar': serializer.toJson<String?>(avatar),
      'page': serializer.toJson<int?>(page),
    };
  }

  Contact copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> fullAddress = const Value.absent(),
          Value<String?> birthday = const Value.absent(),
          Value<int?> gender = const Value.absent(),
          Value<String?> countryCode = const Value.absent(),
          Value<String?> city = const Value.absent(),
          Value<String?> phoneNumber = const Value.absent(),
          Value<String?> dialCode = const Value.absent(),
          Value<String?> avatar = const Value.absent(),
          Value<int?> page = const Value.absent()}) =>
      Contact(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        email: email.present ? email.value : this.email,
        fullAddress: fullAddress.present ? fullAddress.value : this.fullAddress,
        birthday: birthday.present ? birthday.value : this.birthday,
        gender: gender.present ? gender.value : this.gender,
        countryCode: countryCode.present ? countryCode.value : this.countryCode,
        city: city.present ? city.value : this.city,
        phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
        dialCode: dialCode.present ? dialCode.value : this.dialCode,
        avatar: avatar.present ? avatar.value : this.avatar,
        page: page.present ? page.value : this.page,
      );
  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('fullAddress: $fullAddress, ')
          ..write('birthday: $birthday, ')
          ..write('gender: $gender, ')
          ..write('countryCode: $countryCode, ')
          ..write('city: $city, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('dialCode: $dialCode, ')
          ..write('avatar: $avatar, ')
          ..write('page: $page')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, fullAddress, birthday,
      gender, countryCode, city, phoneNumber, dialCode, avatar, page);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.fullAddress == this.fullAddress &&
          other.birthday == this.birthday &&
          other.gender == this.gender &&
          other.countryCode == this.countryCode &&
          other.city == this.city &&
          other.phoneNumber == this.phoneNumber &&
          other.dialCode == this.dialCode &&
          other.avatar == this.avatar &&
          other.page == this.page);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String?> email;
  final Value<String?> fullAddress;
  final Value<String?> birthday;
  final Value<int?> gender;
  final Value<String?> countryCode;
  final Value<String?> city;
  final Value<String?> phoneNumber;
  final Value<String?> dialCode;
  final Value<String?> avatar;
  final Value<int?> page;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.fullAddress = const Value.absent(),
    this.birthday = const Value.absent(),
    this.gender = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.city = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.dialCode = const Value.absent(),
    this.avatar = const Value.absent(),
    this.page = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.fullAddress = const Value.absent(),
    this.birthday = const Value.absent(),
    this.gender = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.city = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.dialCode = const Value.absent(),
    this.avatar = const Value.absent(),
    this.page = const Value.absent(),
  });
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? fullAddress,
    Expression<String>? birthday,
    Expression<int>? gender,
    Expression<String>? countryCode,
    Expression<String>? city,
    Expression<String>? phoneNumber,
    Expression<String>? dialCode,
    Expression<String>? avatar,
    Expression<int>? page,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (fullAddress != null) 'full_address': fullAddress,
      if (birthday != null) 'birthday': birthday,
      if (gender != null) 'gender': gender,
      if (countryCode != null) 'country_code': countryCode,
      if (city != null) 'city': city,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (dialCode != null) 'dial_code': dialCode,
      if (avatar != null) 'avatar': avatar,
      if (page != null) 'page': page,
    });
  }

  ContactsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String?>? email,
      Value<String?>? fullAddress,
      Value<String?>? birthday,
      Value<int?>? gender,
      Value<String?>? countryCode,
      Value<String?>? city,
      Value<String?>? phoneNumber,
      Value<String?>? dialCode,
      Value<String?>? avatar,
      Value<int?>? page}) {
    return ContactsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      fullAddress: fullAddress ?? this.fullAddress,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      countryCode: countryCode ?? this.countryCode,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dialCode: dialCode ?? this.dialCode,
      avatar: avatar ?? this.avatar,
      page: page ?? this.page,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (fullAddress.present) {
      map['full_address'] = Variable<String>(fullAddress.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<String>(birthday.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(gender.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (dialCode.present) {
      map['dial_code'] = Variable<String>(dialCode.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('fullAddress: $fullAddress, ')
          ..write('birthday: $birthday, ')
          ..write('gender: $gender, ')
          ..write('countryCode: $countryCode, ')
          ..write('city: $city, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('dialCode: $dialCode, ')
          ..write('avatar: $avatar, ')
          ..write('page: $page')
          ..write(')'))
        .toString();
  }
}

class $RosterChecksTable extends RosterChecks
    with TableInfo<$RosterChecksTable, RosterCheck> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RosterChecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
      'value', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'roster_checks';
  @override
  VerificationContext validateIntegrity(Insertable<RosterCheck> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  RosterCheck map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RosterCheck(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}value']),
    );
  }

  @override
  $RosterChecksTable createAlias(String alias) {
    return $RosterChecksTable(attachedDatabase, alias);
  }
}

class RosterCheck extends DataClass implements Insertable<RosterCheck> {
  final String key;
  final int? value;
  const RosterCheck({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<int>(value);
    }
    return map;
  }

  RosterChecksCompanion toCompanion(bool nullToAbsent) {
    return RosterChecksCompanion(
      key: Value(key),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  factory RosterCheck.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RosterCheck(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<int?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<int?>(value),
    };
  }

  RosterCheck copyWith(
          {String? key, Value<int?> value = const Value.absent()}) =>
      RosterCheck(
        key: key ?? this.key,
        value: value.present ? value.value : this.value,
      );
  @override
  String toString() {
    return (StringBuffer('RosterCheck(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RosterCheck &&
          other.key == this.key &&
          other.value == this.value);
}

class RosterChecksCompanion extends UpdateCompanion<RosterCheck> {
  final Value<String> key;
  final Value<int?> value;
  final Value<int> rowid;
  const RosterChecksCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RosterChecksCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<RosterCheck> custom({
    Expression<String>? key,
    Expression<int>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RosterChecksCompanion copyWith(
      {Value<String>? key, Value<int?>? value, Value<int>? rowid}) {
    return RosterChecksCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RosterChecksCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _contactMeta =
      const VerificationMeta('contact');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      contact = GeneratedColumn<String>('contact', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $EmployeesTable.$convertercontactn);
  static const VerificationMeta _roleNameMeta =
      const VerificationMeta('roleName');
  @override
  late final GeneratedColumn<String> roleName = GeneratedColumn<String>(
      'role_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _permissionAccessBusinessMeta =
      const VerificationMeta('permissionAccessBusiness');
  @override
  late final GeneratedColumn<int> permissionAccessBusiness =
      GeneratedColumn<int>('permission_access_business', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _permissionAddTaskMeta =
      const VerificationMeta('permissionAddTask');
  @override
  late final GeneratedColumn<int> permissionAddTask = GeneratedColumn<int>(
      'permission_add_task', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _permissionAddProjectMeta =
      const VerificationMeta('permissionAddProject');
  @override
  late final GeneratedColumn<int> permissionAddProject = GeneratedColumn<int>(
      'permission_add_project', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _permissionAddEmployeeMeta =
      const VerificationMeta('permissionAddEmployee');
  @override
  late final GeneratedColumn<int> permissionAddEmployee = GeneratedColumn<int>(
      'permission_add_employee', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _permissionAddRosterMeta =
      const VerificationMeta('permissionAddRoster');
  @override
  late final GeneratedColumn<int> permissionAddRoster = GeneratedColumn<int>(
      'permission_add_roster', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _employeeConfirmMeta =
      const VerificationMeta('employeeConfirm');
  @override
  late final GeneratedColumn<String> employeeConfirm = GeneratedColumn<String>(
      'employee_confirm', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _employeeNameMeta =
      const VerificationMeta('employeeName');
  @override
  late final GeneratedColumn<String> employeeName = GeneratedColumn<String>(
      'employee_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        contact,
        roleName,
        permissionAccessBusiness,
        permissionAddTask,
        permissionAddProject,
        permissionAddEmployee,
        permissionAddRoster,
        companyId,
        employeeConfirm,
        employeeName
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees';
  @override
  VerificationContext validateIntegrity(Insertable<Employee> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_contactMeta, const VerificationResult.success());
    if (data.containsKey('role_name')) {
      context.handle(_roleNameMeta,
          roleName.isAcceptableOrUnknown(data['role_name']!, _roleNameMeta));
    }
    if (data.containsKey('permission_access_business')) {
      context.handle(
          _permissionAccessBusinessMeta,
          permissionAccessBusiness.isAcceptableOrUnknown(
              data['permission_access_business']!,
              _permissionAccessBusinessMeta));
    }
    if (data.containsKey('permission_add_task')) {
      context.handle(
          _permissionAddTaskMeta,
          permissionAddTask.isAcceptableOrUnknown(
              data['permission_add_task']!, _permissionAddTaskMeta));
    }
    if (data.containsKey('permission_add_project')) {
      context.handle(
          _permissionAddProjectMeta,
          permissionAddProject.isAcceptableOrUnknown(
              data['permission_add_project']!, _permissionAddProjectMeta));
    }
    if (data.containsKey('permission_add_employee')) {
      context.handle(
          _permissionAddEmployeeMeta,
          permissionAddEmployee.isAcceptableOrUnknown(
              data['permission_add_employee']!, _permissionAddEmployeeMeta));
    }
    if (data.containsKey('permission_add_roster')) {
      context.handle(
          _permissionAddRosterMeta,
          permissionAddRoster.isAcceptableOrUnknown(
              data['permission_add_roster']!, _permissionAddRosterMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    }
    if (data.containsKey('employee_confirm')) {
      context.handle(
          _employeeConfirmMeta,
          employeeConfirm.isAcceptableOrUnknown(
              data['employee_confirm']!, _employeeConfirmMeta));
    }
    if (data.containsKey('employee_name')) {
      context.handle(
          _employeeNameMeta,
          employeeName.isAcceptableOrUnknown(
              data['employee_name']!, _employeeNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Employee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Employee(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      contact: $EmployeesTable.$convertercontactn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact'])),
      roleName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role_name']),
      permissionAccessBusiness: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}permission_access_business']),
      permissionAddTask: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}permission_add_task']),
      permissionAddProject: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}permission_add_project']),
      permissionAddEmployee: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}permission_add_employee']),
      permissionAddRoster: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}permission_add_roster']),
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id']),
      employeeConfirm: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}employee_confirm']),
      employeeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_name']),
    );
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $convertercontact =
      const MapConverter();
  static TypeConverter<Map<String, dynamic>?, String?> $convertercontactn =
      NullAwareTypeConverter.wrap($convertercontact);
}

class Employee extends DataClass implements Insertable<Employee> {
  final int id;
  final Map<String, dynamic>? contact;
  final String? roleName;
  final int? permissionAccessBusiness;
  final int? permissionAddTask;
  final int? permissionAddProject;
  final int? permissionAddEmployee;
  final int? permissionAddRoster;
  final int? companyId;
  final String? employeeConfirm;
  final String? employeeName;
  const Employee(
      {required this.id,
      this.contact,
      this.roleName,
      this.permissionAccessBusiness,
      this.permissionAddTask,
      this.permissionAddProject,
      this.permissionAddEmployee,
      this.permissionAddRoster,
      this.companyId,
      this.employeeConfirm,
      this.employeeName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || contact != null) {
      final converter = $EmployeesTable.$convertercontactn;
      map['contact'] = Variable<String>(converter.toSql(contact));
    }
    if (!nullToAbsent || roleName != null) {
      map['role_name'] = Variable<String>(roleName);
    }
    if (!nullToAbsent || permissionAccessBusiness != null) {
      map['permission_access_business'] =
          Variable<int>(permissionAccessBusiness);
    }
    if (!nullToAbsent || permissionAddTask != null) {
      map['permission_add_task'] = Variable<int>(permissionAddTask);
    }
    if (!nullToAbsent || permissionAddProject != null) {
      map['permission_add_project'] = Variable<int>(permissionAddProject);
    }
    if (!nullToAbsent || permissionAddEmployee != null) {
      map['permission_add_employee'] = Variable<int>(permissionAddEmployee);
    }
    if (!nullToAbsent || permissionAddRoster != null) {
      map['permission_add_roster'] = Variable<int>(permissionAddRoster);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    if (!nullToAbsent || employeeConfirm != null) {
      map['employee_confirm'] = Variable<String>(employeeConfirm);
    }
    if (!nullToAbsent || employeeName != null) {
      map['employee_name'] = Variable<String>(employeeName);
    }
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      id: Value(id),
      contact: contact == null && nullToAbsent
          ? const Value.absent()
          : Value(contact),
      roleName: roleName == null && nullToAbsent
          ? const Value.absent()
          : Value(roleName),
      permissionAccessBusiness: permissionAccessBusiness == null && nullToAbsent
          ? const Value.absent()
          : Value(permissionAccessBusiness),
      permissionAddTask: permissionAddTask == null && nullToAbsent
          ? const Value.absent()
          : Value(permissionAddTask),
      permissionAddProject: permissionAddProject == null && nullToAbsent
          ? const Value.absent()
          : Value(permissionAddProject),
      permissionAddEmployee: permissionAddEmployee == null && nullToAbsent
          ? const Value.absent()
          : Value(permissionAddEmployee),
      permissionAddRoster: permissionAddRoster == null && nullToAbsent
          ? const Value.absent()
          : Value(permissionAddRoster),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      employeeConfirm: employeeConfirm == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeConfirm),
      employeeName: employeeName == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeName),
    );
  }

  factory Employee.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<int>(json['id']),
      contact: serializer.fromJson<Map<String, dynamic>?>(json['contact']),
      roleName: serializer.fromJson<String?>(json['role_name']),
      permissionAccessBusiness:
          serializer.fromJson<int?>(json['permission_access_business']),
      permissionAddTask: serializer.fromJson<int?>(json['permission_add_task']),
      permissionAddProject:
          serializer.fromJson<int?>(json['permission_add_project']),
      permissionAddEmployee:
          serializer.fromJson<int?>(json['permission_add_employee']),
      permissionAddRoster:
          serializer.fromJson<int?>(json['permission_add_roster']),
      companyId: serializer.fromJson<int?>(json['company_id']),
      employeeConfirm: serializer.fromJson<String?>(json['employee_confirm']),
      employeeName: serializer.fromJson<String?>(json['employee_name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contact': serializer.toJson<Map<String, dynamic>?>(contact),
      'role_name': serializer.toJson<String?>(roleName),
      'permission_access_business':
          serializer.toJson<int?>(permissionAccessBusiness),
      'permission_add_task': serializer.toJson<int?>(permissionAddTask),
      'permission_add_project': serializer.toJson<int?>(permissionAddProject),
      'permission_add_employee': serializer.toJson<int?>(permissionAddEmployee),
      'permission_add_roster': serializer.toJson<int?>(permissionAddRoster),
      'company_id': serializer.toJson<int?>(companyId),
      'employee_confirm': serializer.toJson<String?>(employeeConfirm),
      'employee_name': serializer.toJson<String?>(employeeName),
    };
  }

  Employee copyWith(
          {int? id,
          Value<Map<String, dynamic>?> contact = const Value.absent(),
          Value<String?> roleName = const Value.absent(),
          Value<int?> permissionAccessBusiness = const Value.absent(),
          Value<int?> permissionAddTask = const Value.absent(),
          Value<int?> permissionAddProject = const Value.absent(),
          Value<int?> permissionAddEmployee = const Value.absent(),
          Value<int?> permissionAddRoster = const Value.absent(),
          Value<int?> companyId = const Value.absent(),
          Value<String?> employeeConfirm = const Value.absent(),
          Value<String?> employeeName = const Value.absent()}) =>
      Employee(
        id: id ?? this.id,
        contact: contact.present ? contact.value : this.contact,
        roleName: roleName.present ? roleName.value : this.roleName,
        permissionAccessBusiness: permissionAccessBusiness.present
            ? permissionAccessBusiness.value
            : this.permissionAccessBusiness,
        permissionAddTask: permissionAddTask.present
            ? permissionAddTask.value
            : this.permissionAddTask,
        permissionAddProject: permissionAddProject.present
            ? permissionAddProject.value
            : this.permissionAddProject,
        permissionAddEmployee: permissionAddEmployee.present
            ? permissionAddEmployee.value
            : this.permissionAddEmployee,
        permissionAddRoster: permissionAddRoster.present
            ? permissionAddRoster.value
            : this.permissionAddRoster,
        companyId: companyId.present ? companyId.value : this.companyId,
        employeeConfirm: employeeConfirm.present
            ? employeeConfirm.value
            : this.employeeConfirm,
        employeeName:
            employeeName.present ? employeeName.value : this.employeeName,
      );
  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('contact: $contact, ')
          ..write('roleName: $roleName, ')
          ..write('permissionAccessBusiness: $permissionAccessBusiness, ')
          ..write('permissionAddTask: $permissionAddTask, ')
          ..write('permissionAddProject: $permissionAddProject, ')
          ..write('permissionAddEmployee: $permissionAddEmployee, ')
          ..write('permissionAddRoster: $permissionAddRoster, ')
          ..write('companyId: $companyId, ')
          ..write('employeeConfirm: $employeeConfirm, ')
          ..write('employeeName: $employeeName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      contact,
      roleName,
      permissionAccessBusiness,
      permissionAddTask,
      permissionAddProject,
      permissionAddEmployee,
      permissionAddRoster,
      companyId,
      employeeConfirm,
      employeeName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.id == this.id &&
          other.contact == this.contact &&
          other.roleName == this.roleName &&
          other.permissionAccessBusiness == this.permissionAccessBusiness &&
          other.permissionAddTask == this.permissionAddTask &&
          other.permissionAddProject == this.permissionAddProject &&
          other.permissionAddEmployee == this.permissionAddEmployee &&
          other.permissionAddRoster == this.permissionAddRoster &&
          other.companyId == this.companyId &&
          other.employeeConfirm == this.employeeConfirm &&
          other.employeeName == this.employeeName);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<int> id;
  final Value<Map<String, dynamic>?> contact;
  final Value<String?> roleName;
  final Value<int?> permissionAccessBusiness;
  final Value<int?> permissionAddTask;
  final Value<int?> permissionAddProject;
  final Value<int?> permissionAddEmployee;
  final Value<int?> permissionAddRoster;
  final Value<int?> companyId;
  final Value<String?> employeeConfirm;
  final Value<String?> employeeName;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.contact = const Value.absent(),
    this.roleName = const Value.absent(),
    this.permissionAccessBusiness = const Value.absent(),
    this.permissionAddTask = const Value.absent(),
    this.permissionAddProject = const Value.absent(),
    this.permissionAddEmployee = const Value.absent(),
    this.permissionAddRoster = const Value.absent(),
    this.companyId = const Value.absent(),
    this.employeeConfirm = const Value.absent(),
    this.employeeName = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.id = const Value.absent(),
    this.contact = const Value.absent(),
    this.roleName = const Value.absent(),
    this.permissionAccessBusiness = const Value.absent(),
    this.permissionAddTask = const Value.absent(),
    this.permissionAddProject = const Value.absent(),
    this.permissionAddEmployee = const Value.absent(),
    this.permissionAddRoster = const Value.absent(),
    this.companyId = const Value.absent(),
    this.employeeConfirm = const Value.absent(),
    this.employeeName = const Value.absent(),
  });
  static Insertable<Employee> custom({
    Expression<int>? id,
    Expression<String>? contact,
    Expression<String>? roleName,
    Expression<int>? permissionAccessBusiness,
    Expression<int>? permissionAddTask,
    Expression<int>? permissionAddProject,
    Expression<int>? permissionAddEmployee,
    Expression<int>? permissionAddRoster,
    Expression<int>? companyId,
    Expression<String>? employeeConfirm,
    Expression<String>? employeeName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contact != null) 'contact': contact,
      if (roleName != null) 'role_name': roleName,
      if (permissionAccessBusiness != null)
        'permission_access_business': permissionAccessBusiness,
      if (permissionAddTask != null) 'permission_add_task': permissionAddTask,
      if (permissionAddProject != null)
        'permission_add_project': permissionAddProject,
      if (permissionAddEmployee != null)
        'permission_add_employee': permissionAddEmployee,
      if (permissionAddRoster != null)
        'permission_add_roster': permissionAddRoster,
      if (companyId != null) 'company_id': companyId,
      if (employeeConfirm != null) 'employee_confirm': employeeConfirm,
      if (employeeName != null) 'employee_name': employeeName,
    });
  }

  EmployeesCompanion copyWith(
      {Value<int>? id,
      Value<Map<String, dynamic>?>? contact,
      Value<String?>? roleName,
      Value<int?>? permissionAccessBusiness,
      Value<int?>? permissionAddTask,
      Value<int?>? permissionAddProject,
      Value<int?>? permissionAddEmployee,
      Value<int?>? permissionAddRoster,
      Value<int?>? companyId,
      Value<String?>? employeeConfirm,
      Value<String?>? employeeName}) {
    return EmployeesCompanion(
      id: id ?? this.id,
      contact: contact ?? this.contact,
      roleName: roleName ?? this.roleName,
      permissionAccessBusiness:
          permissionAccessBusiness ?? this.permissionAccessBusiness,
      permissionAddTask: permissionAddTask ?? this.permissionAddTask,
      permissionAddProject: permissionAddProject ?? this.permissionAddProject,
      permissionAddEmployee:
          permissionAddEmployee ?? this.permissionAddEmployee,
      permissionAddRoster: permissionAddRoster ?? this.permissionAddRoster,
      companyId: companyId ?? this.companyId,
      employeeConfirm: employeeConfirm ?? this.employeeConfirm,
      employeeName: employeeName ?? this.employeeName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contact.present) {
      final converter = $EmployeesTable.$convertercontactn;

      map['contact'] = Variable<String>(converter.toSql(contact.value));
    }
    if (roleName.present) {
      map['role_name'] = Variable<String>(roleName.value);
    }
    if (permissionAccessBusiness.present) {
      map['permission_access_business'] =
          Variable<int>(permissionAccessBusiness.value);
    }
    if (permissionAddTask.present) {
      map['permission_add_task'] = Variable<int>(permissionAddTask.value);
    }
    if (permissionAddProject.present) {
      map['permission_add_project'] = Variable<int>(permissionAddProject.value);
    }
    if (permissionAddEmployee.present) {
      map['permission_add_employee'] =
          Variable<int>(permissionAddEmployee.value);
    }
    if (permissionAddRoster.present) {
      map['permission_add_roster'] = Variable<int>(permissionAddRoster.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (employeeConfirm.present) {
      map['employee_confirm'] = Variable<String>(employeeConfirm.value);
    }
    if (employeeName.present) {
      map['employee_name'] = Variable<String>(employeeName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('id: $id, ')
          ..write('contact: $contact, ')
          ..write('roleName: $roleName, ')
          ..write('permissionAccessBusiness: $permissionAccessBusiness, ')
          ..write('permissionAddTask: $permissionAddTask, ')
          ..write('permissionAddProject: $permissionAddProject, ')
          ..write('permissionAddEmployee: $permissionAddEmployee, ')
          ..write('permissionAddRoster: $permissionAddRoster, ')
          ..write('companyId: $companyId, ')
          ..write('employeeConfirm: $employeeConfirm, ')
          ..write('employeeName: $employeeName')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _employeesMeta =
      const VerificationMeta('employees');
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String>
      employees = GeneratedColumn<String>('employees', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<dynamic>?>($TasksTable.$converteremployeesn);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
      'page', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
      'store_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        comment,
        employees,
        startDate,
        endDate,
        status,
        page,
        storeId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    }
    context.handle(_employeesMeta, const VerificationResult.success());
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('page')) {
      context.handle(
          _pageMeta, page.isAcceptableOrUnknown(data['page']!, _pageMeta));
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment']),
      employees: $TasksTable.$converteremployeesn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employees'])),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      page: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page']),
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}store_id']),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }

  static TypeConverter<List<dynamic>, String> $converteremployees =
      const ListConverter();
  static TypeConverter<List<dynamic>?, String?> $converteremployeesn =
      NullAwareTypeConverter.wrap($converteremployees);
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String? comment;
  final List<dynamic>? employees;
  final String? startDate;
  final String? endDate;
  final String? status;
  final int? page;
  final int? storeId;
  const Task(
      {required this.id,
      required this.title,
      this.comment,
      this.employees,
      this.startDate,
      this.endDate,
      this.status,
      this.page,
      this.storeId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    if (!nullToAbsent || employees != null) {
      final converter = $TasksTable.$converteremployeesn;
      map['employees'] = Variable<String>(converter.toSql(employees));
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<String>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || page != null) {
      map['page'] = Variable<int>(page);
    }
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      employees: employees == null && nullToAbsent
          ? const Value.absent()
          : Value(employees),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      page: page == null && nullToAbsent ? const Value.absent() : Value(page),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      comment: serializer.fromJson<String?>(json['comment']),
      employees: serializer.fromJson<List<dynamic>?>(json['employees']),
      startDate: serializer.fromJson<String?>(json['start_date']),
      endDate: serializer.fromJson<String?>(json['end_date']),
      status: serializer.fromJson<String?>(json['status']),
      page: serializer.fromJson<int?>(json['page']),
      storeId: serializer.fromJson<int?>(json['store_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'comment': serializer.toJson<String?>(comment),
      'employees': serializer.toJson<List<dynamic>?>(employees),
      'start_date': serializer.toJson<String?>(startDate),
      'end_date': serializer.toJson<String?>(endDate),
      'status': serializer.toJson<String?>(status),
      'page': serializer.toJson<int?>(page),
      'store_id': serializer.toJson<int?>(storeId),
    };
  }

  Task copyWith(
          {int? id,
          String? title,
          Value<String?> comment = const Value.absent(),
          Value<List<dynamic>?> employees = const Value.absent(),
          Value<String?> startDate = const Value.absent(),
          Value<String?> endDate = const Value.absent(),
          Value<String?> status = const Value.absent(),
          Value<int?> page = const Value.absent(),
          Value<int?> storeId = const Value.absent()}) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        comment: comment.present ? comment.value : this.comment,
        employees: employees.present ? employees.value : this.employees,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        status: status.present ? status.value : this.status,
        page: page.present ? page.value : this.page,
        storeId: storeId.present ? storeId.value : this.storeId,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('employees: $employees, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('page: $page, ')
          ..write('storeId: $storeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, comment, employees, startDate, endDate, status, page, storeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.comment == this.comment &&
          other.employees == this.employees &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.status == this.status &&
          other.page == this.page &&
          other.storeId == this.storeId);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> comment;
  final Value<List<dynamic>?> employees;
  final Value<String?> startDate;
  final Value<String?> endDate;
  final Value<String?> status;
  final Value<int?> page;
  final Value<int?> storeId;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.comment = const Value.absent(),
    this.employees = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
    this.page = const Value.absent(),
    this.storeId = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.comment = const Value.absent(),
    this.employees = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
    this.page = const Value.absent(),
    this.storeId = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? comment,
    Expression<String>? employees,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? status,
    Expression<int>? page,
    Expression<int>? storeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (comment != null) 'comment': comment,
      if (employees != null) 'employees': employees,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (status != null) 'status': status,
      if (page != null) 'page': page,
      if (storeId != null) 'store_id': storeId,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? comment,
      Value<List<dynamic>?>? employees,
      Value<String?>? startDate,
      Value<String?>? endDate,
      Value<String?>? status,
      Value<int?>? page,
      Value<int?>? storeId}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      employees: employees ?? this.employees,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      page: page ?? this.page,
      storeId: storeId ?? this.storeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (employees.present) {
      final converter = $TasksTable.$converteremployeesn;

      map['employees'] = Variable<String>(converter.toSql(employees.value));
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('employees: $employees, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('page: $page, ')
          ..write('storeId: $storeId')
          ..write(')'))
        .toString();
  }
}

class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clientMeta = const VerificationMeta('client');
  @override
  late final GeneratedColumn<String> client = GeneratedColumn<String>(
      'client', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyNameMeta =
      const VerificationMeta('companyName');
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
      'company_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _employeeResponsibleMeta =
      const VerificationMeta('employeeResponsible');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      employeeResponsible = GeneratedColumn<String>(
              'employee_responsible', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $ProjectsTable.$converteremployeeResponsiblen);
  static const VerificationMeta _teamsMeta = const VerificationMeta('teams');
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String> teams =
      GeneratedColumn<String>('teams', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<dynamic>?>($ProjectsTable.$converterteamsn);
  static const VerificationMeta _creatorIdMeta =
      const VerificationMeta('creatorId');
  @override
  late final GeneratedColumn<int> creatorId = GeneratedColumn<int>(
      'creator_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _tasksMeta = const VerificationMeta('tasks');
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String> tasks =
      GeneratedColumn<String>('tasks', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<dynamic>?>($ProjectsTable.$convertertasksn);
  static const VerificationMeta _companyPhotoMeta =
      const VerificationMeta('companyPhoto');
  @override
  late final GeneratedColumn<String> companyPhoto = GeneratedColumn<String>(
      'company_photo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        client,
        companyName,
        employeeResponsible,
        teams,
        creatorId,
        tasks,
        companyPhoto
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(Insertable<Project> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('client')) {
      context.handle(_clientMeta,
          client.isAcceptableOrUnknown(data['client']!, _clientMeta));
    }
    if (data.containsKey('company_name')) {
      context.handle(
          _companyNameMeta,
          companyName.isAcceptableOrUnknown(
              data['company_name']!, _companyNameMeta));
    }
    context.handle(
        _employeeResponsibleMeta, const VerificationResult.success());
    context.handle(_teamsMeta, const VerificationResult.success());
    if (data.containsKey('creator_id')) {
      context.handle(_creatorIdMeta,
          creatorId.isAcceptableOrUnknown(data['creator_id']!, _creatorIdMeta));
    }
    context.handle(_tasksMeta, const VerificationResult.success());
    if (data.containsKey('company_photo')) {
      context.handle(
          _companyPhotoMeta,
          companyPhoto.isAcceptableOrUnknown(
              data['company_photo']!, _companyPhotoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      client: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client']),
      companyName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_name']),
      employeeResponsible: $ProjectsTable.$converteremployeeResponsiblen
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}employee_responsible'])),
      teams: $ProjectsTable.$converterteamsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}teams'])),
      creatorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}creator_id']),
      tasks: $ProjectsTable.$convertertasksn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tasks'])),
      companyPhoto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_photo']),
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String>
      $converteremployeeResponsible = const MapConverter();
  static TypeConverter<Map<String, dynamic>?, String?>
      $converteremployeeResponsiblen =
      NullAwareTypeConverter.wrap($converteremployeeResponsible);
  static TypeConverter<List<dynamic>, String> $converterteams =
      const ListConverter();
  static TypeConverter<List<dynamic>?, String?> $converterteamsn =
      NullAwareTypeConverter.wrap($converterteams);
  static TypeConverter<List<dynamic>, String> $convertertasks =
      const ListConverter();
  static TypeConverter<List<dynamic>?, String?> $convertertasksn =
      NullAwareTypeConverter.wrap($convertertasks);
}

class Project extends DataClass implements Insertable<Project> {
  final int id;
  final String title;
  final String? description;
  final String? client;
  final String? companyName;
  final Map<String, dynamic>? employeeResponsible;
  final List<dynamic>? teams;
  final int? creatorId;
  final List<dynamic>? tasks;
  final String? companyPhoto;
  const Project(
      {required this.id,
      required this.title,
      this.description,
      this.client,
      this.companyName,
      this.employeeResponsible,
      this.teams,
      this.creatorId,
      this.tasks,
      this.companyPhoto});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || client != null) {
      map['client'] = Variable<String>(client);
    }
    if (!nullToAbsent || companyName != null) {
      map['company_name'] = Variable<String>(companyName);
    }
    if (!nullToAbsent || employeeResponsible != null) {
      final converter = $ProjectsTable.$converteremployeeResponsiblen;
      map['employee_responsible'] =
          Variable<String>(converter.toSql(employeeResponsible));
    }
    if (!nullToAbsent || teams != null) {
      final converter = $ProjectsTable.$converterteamsn;
      map['teams'] = Variable<String>(converter.toSql(teams));
    }
    if (!nullToAbsent || creatorId != null) {
      map['creator_id'] = Variable<int>(creatorId);
    }
    if (!nullToAbsent || tasks != null) {
      final converter = $ProjectsTable.$convertertasksn;
      map['tasks'] = Variable<String>(converter.toSql(tasks));
    }
    if (!nullToAbsent || companyPhoto != null) {
      map['company_photo'] = Variable<String>(companyPhoto);
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      client:
          client == null && nullToAbsent ? const Value.absent() : Value(client),
      companyName: companyName == null && nullToAbsent
          ? const Value.absent()
          : Value(companyName),
      employeeResponsible: employeeResponsible == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeResponsible),
      teams:
          teams == null && nullToAbsent ? const Value.absent() : Value(teams),
      creatorId: creatorId == null && nullToAbsent
          ? const Value.absent()
          : Value(creatorId),
      tasks:
          tasks == null && nullToAbsent ? const Value.absent() : Value(tasks),
      companyPhoto: companyPhoto == null && nullToAbsent
          ? const Value.absent()
          : Value(companyPhoto),
    );
  }

  factory Project.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      client: serializer.fromJson<String?>(json['client']),
      companyName: serializer.fromJson<String?>(json['company_name']),
      employeeResponsible: serializer
          .fromJson<Map<String, dynamic>?>(json['employee_responsible']),
      teams: serializer.fromJson<List<dynamic>?>(json['teams']),
      creatorId: serializer.fromJson<int?>(json['creator_id']),
      tasks: serializer.fromJson<List<dynamic>?>(json['tasks']),
      companyPhoto: serializer.fromJson<String?>(json['company_photo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'client': serializer.toJson<String?>(client),
      'company_name': serializer.toJson<String?>(companyName),
      'employee_responsible':
          serializer.toJson<Map<String, dynamic>?>(employeeResponsible),
      'teams': serializer.toJson<List<dynamic>?>(teams),
      'creator_id': serializer.toJson<int?>(creatorId),
      'tasks': serializer.toJson<List<dynamic>?>(tasks),
      'company_photo': serializer.toJson<String?>(companyPhoto),
    };
  }

  Project copyWith(
          {int? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<String?> client = const Value.absent(),
          Value<String?> companyName = const Value.absent(),
          Value<Map<String, dynamic>?> employeeResponsible =
              const Value.absent(),
          Value<List<dynamic>?> teams = const Value.absent(),
          Value<int?> creatorId = const Value.absent(),
          Value<List<dynamic>?> tasks = const Value.absent(),
          Value<String?> companyPhoto = const Value.absent()}) =>
      Project(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        client: client.present ? client.value : this.client,
        companyName: companyName.present ? companyName.value : this.companyName,
        employeeResponsible: employeeResponsible.present
            ? employeeResponsible.value
            : this.employeeResponsible,
        teams: teams.present ? teams.value : this.teams,
        creatorId: creatorId.present ? creatorId.value : this.creatorId,
        tasks: tasks.present ? tasks.value : this.tasks,
        companyPhoto:
            companyPhoto.present ? companyPhoto.value : this.companyPhoto,
      );
  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('client: $client, ')
          ..write('companyName: $companyName, ')
          ..write('employeeResponsible: $employeeResponsible, ')
          ..write('teams: $teams, ')
          ..write('creatorId: $creatorId, ')
          ..write('tasks: $tasks, ')
          ..write('companyPhoto: $companyPhoto')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, client, companyName,
      employeeResponsible, teams, creatorId, tasks, companyPhoto);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.client == this.client &&
          other.companyName == this.companyName &&
          other.employeeResponsible == this.employeeResponsible &&
          other.teams == this.teams &&
          other.creatorId == this.creatorId &&
          other.tasks == this.tasks &&
          other.companyPhoto == this.companyPhoto);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> client;
  final Value<String?> companyName;
  final Value<Map<String, dynamic>?> employeeResponsible;
  final Value<List<dynamic>?> teams;
  final Value<int?> creatorId;
  final Value<List<dynamic>?> tasks;
  final Value<String?> companyPhoto;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.client = const Value.absent(),
    this.companyName = const Value.absent(),
    this.employeeResponsible = const Value.absent(),
    this.teams = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.tasks = const Value.absent(),
    this.companyPhoto = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.client = const Value.absent(),
    this.companyName = const Value.absent(),
    this.employeeResponsible = const Value.absent(),
    this.teams = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.tasks = const Value.absent(),
    this.companyPhoto = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Project> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? client,
    Expression<String>? companyName,
    Expression<String>? employeeResponsible,
    Expression<String>? teams,
    Expression<int>? creatorId,
    Expression<String>? tasks,
    Expression<String>? companyPhoto,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (client != null) 'client': client,
      if (companyName != null) 'company_name': companyName,
      if (employeeResponsible != null)
        'employee_responsible': employeeResponsible,
      if (teams != null) 'teams': teams,
      if (creatorId != null) 'creator_id': creatorId,
      if (tasks != null) 'tasks': tasks,
      if (companyPhoto != null) 'company_photo': companyPhoto,
    });
  }

  ProjectsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<String?>? client,
      Value<String?>? companyName,
      Value<Map<String, dynamic>?>? employeeResponsible,
      Value<List<dynamic>?>? teams,
      Value<int?>? creatorId,
      Value<List<dynamic>?>? tasks,
      Value<String?>? companyPhoto}) {
    return ProjectsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      client: client ?? this.client,
      companyName: companyName ?? this.companyName,
      employeeResponsible: employeeResponsible ?? this.employeeResponsible,
      teams: teams ?? this.teams,
      creatorId: creatorId ?? this.creatorId,
      tasks: tasks ?? this.tasks,
      companyPhoto: companyPhoto ?? this.companyPhoto,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (client.present) {
      map['client'] = Variable<String>(client.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (employeeResponsible.present) {
      final converter = $ProjectsTable.$converteremployeeResponsiblen;

      map['employee_responsible'] =
          Variable<String>(converter.toSql(employeeResponsible.value));
    }
    if (teams.present) {
      final converter = $ProjectsTable.$converterteamsn;

      map['teams'] = Variable<String>(converter.toSql(teams.value));
    }
    if (creatorId.present) {
      map['creator_id'] = Variable<int>(creatorId.value);
    }
    if (tasks.present) {
      final converter = $ProjectsTable.$convertertasksn;

      map['tasks'] = Variable<String>(converter.toSql(tasks.value));
    }
    if (companyPhoto.present) {
      map['company_photo'] = Variable<String>(companyPhoto.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('client: $client, ')
          ..write('companyName: $companyName, ')
          ..write('employeeResponsible: $employeeResponsible, ')
          ..write('teams: $teams, ')
          ..write('creatorId: $creatorId, ')
          ..write('tasks: $tasks, ')
          ..write('companyPhoto: $companyPhoto')
          ..write(')'))
        .toString();
  }
}

class $RostersTable extends Rosters with TableInfo<$RostersTable, Roster> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RostersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _employeeMeta =
      const VerificationMeta('employee');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      employee = GeneratedColumn<String>('employee', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $RostersTable.$converteremployeen);
  static const VerificationMeta _creatorIdMeta =
      const VerificationMeta('creatorId');
  @override
  late final GeneratedColumn<int> creatorId = GeneratedColumn<int>(
      'creator_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumnWithTypeConverter<String, DateTime> startTime =
      GeneratedColumn<DateTime>('start_time', aliasedName, true,
              type: DriftSqlType.dateTime, requiredDuringInsert: false)
          .withConverter<String>($RostersTable.$converterstartTime);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumnWithTypeConverter<String, DateTime> endTime =
      GeneratedColumn<DateTime>('end_time', aliasedName, true,
              type: DriftSqlType.dateTime, requiredDuringInsert: false)
          .withConverter<String>($RostersTable.$converterendTime);
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
      'page', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
      'store_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _storeMeta = const VerificationMeta('store');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      store = GeneratedColumn<String>('store', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>($RostersTable.$converterstoren);
  static const VerificationMeta _totalDenyMeta =
      const VerificationMeta('totalDeny');
  @override
  late final GeneratedColumn<int> totalDeny = GeneratedColumn<int>(
      'total_deny', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        employee,
        creatorId,
        status,
        startTime,
        endTime,
        page,
        storeId,
        store,
        totalDeny
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rosters';
  @override
  VerificationContext validateIntegrity(Insertable<Roster> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_employeeMeta, const VerificationResult.success());
    if (data.containsKey('creator_id')) {
      context.handle(_creatorIdMeta,
          creatorId.isAcceptableOrUnknown(data['creator_id']!, _creatorIdMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    context.handle(_startTimeMeta, const VerificationResult.success());
    context.handle(_endTimeMeta, const VerificationResult.success());
    if (data.containsKey('page')) {
      context.handle(
          _pageMeta, page.isAcceptableOrUnknown(data['page']!, _pageMeta));
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    context.handle(_storeMeta, const VerificationResult.success());
    if (data.containsKey('total_deny')) {
      context.handle(_totalDenyMeta,
          totalDeny.isAcceptableOrUnknown(data['total_deny']!, _totalDenyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Roster map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Roster(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      employee: $RostersTable.$converteremployeen.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee'])),
      creatorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}creator_id']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      startTime: $RostersTable.$converterstartTime.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])),
      endTime: $RostersTable.$converterendTime.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time'])),
      page: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page']),
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}store_id']),
      store: $RostersTable.$converterstoren.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store'])),
      totalDeny: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_deny']),
    );
  }

  @override
  $RostersTable createAlias(String alias) {
    return $RostersTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $converteremployee =
      const MapConverter();
  static TypeConverter<Map<String, dynamic>?, String?> $converteremployeen =
      NullAwareTypeConverter.wrap($converteremployee);
  static TypeConverter<String, DateTime?> $converterstartTime =
      const DateTimeConverter();
  static TypeConverter<String, DateTime?> $converterendTime =
      const DateTimeConverter();
  static TypeConverter<Map<String, dynamic>, String> $converterstore =
      const MapConverter();
  static TypeConverter<Map<String, dynamic>?, String?> $converterstoren =
      NullAwareTypeConverter.wrap($converterstore);
}

class Roster extends DataClass implements Insertable<Roster> {
  final int id;
  final Map<String, dynamic>? employee;
  final int? creatorId;
  final String? status;
  final String startTime;
  final String endTime;
  final int? page;
  final int? storeId;
  final Map<String, dynamic>? store;
  final int? totalDeny;
  const Roster(
      {required this.id,
      this.employee,
      this.creatorId,
      this.status,
      required this.startTime,
      required this.endTime,
      this.page,
      this.storeId,
      this.store,
      this.totalDeny});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || employee != null) {
      final converter = $RostersTable.$converteremployeen;
      map['employee'] = Variable<String>(converter.toSql(employee));
    }
    if (!nullToAbsent || creatorId != null) {
      map['creator_id'] = Variable<int>(creatorId);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    {
      final converter = $RostersTable.$converterstartTime;
      map['start_time'] = Variable<DateTime>(converter.toSql(startTime));
    }
    {
      final converter = $RostersTable.$converterendTime;
      map['end_time'] = Variable<DateTime>(converter.toSql(endTime));
    }
    if (!nullToAbsent || page != null) {
      map['page'] = Variable<int>(page);
    }
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    if (!nullToAbsent || store != null) {
      final converter = $RostersTable.$converterstoren;
      map['store'] = Variable<String>(converter.toSql(store));
    }
    if (!nullToAbsent || totalDeny != null) {
      map['total_deny'] = Variable<int>(totalDeny);
    }
    return map;
  }

  RostersCompanion toCompanion(bool nullToAbsent) {
    return RostersCompanion(
      id: Value(id),
      employee: employee == null && nullToAbsent
          ? const Value.absent()
          : Value(employee),
      creatorId: creatorId == null && nullToAbsent
          ? const Value.absent()
          : Value(creatorId),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      startTime: Value(startTime),
      endTime: Value(endTime),
      page: page == null && nullToAbsent ? const Value.absent() : Value(page),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      store:
          store == null && nullToAbsent ? const Value.absent() : Value(store),
      totalDeny: totalDeny == null && nullToAbsent
          ? const Value.absent()
          : Value(totalDeny),
    );
  }

  factory Roster.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Roster(
      id: serializer.fromJson<int>(json['id']),
      employee: serializer.fromJson<Map<String, dynamic>?>(json['employee']),
      creatorId: serializer.fromJson<int?>(json['creator_id']),
      status: serializer.fromJson<String?>(json['status']),
      startTime: serializer.fromJson<String>(json['start_time']),
      endTime: serializer.fromJson<String>(json['end_time']),
      page: serializer.fromJson<int?>(json['page']),
      storeId: serializer.fromJson<int?>(json['store_id']),
      store: serializer.fromJson<Map<String, dynamic>?>(json['store']),
      totalDeny: serializer.fromJson<int?>(json['total_deny']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employee': serializer.toJson<Map<String, dynamic>?>(employee),
      'creator_id': serializer.toJson<int?>(creatorId),
      'status': serializer.toJson<String?>(status),
      'start_time': serializer.toJson<String>(startTime),
      'end_time': serializer.toJson<String>(endTime),
      'page': serializer.toJson<int?>(page),
      'store_id': serializer.toJson<int?>(storeId),
      'store': serializer.toJson<Map<String, dynamic>?>(store),
      'total_deny': serializer.toJson<int?>(totalDeny),
    };
  }

  Roster copyWith(
          {int? id,
          Value<Map<String, dynamic>?> employee = const Value.absent(),
          Value<int?> creatorId = const Value.absent(),
          Value<String?> status = const Value.absent(),
          String? startTime,
          String? endTime,
          Value<int?> page = const Value.absent(),
          Value<int?> storeId = const Value.absent(),
          Value<Map<String, dynamic>?> store = const Value.absent(),
          Value<int?> totalDeny = const Value.absent()}) =>
      Roster(
        id: id ?? this.id,
        employee: employee.present ? employee.value : this.employee,
        creatorId: creatorId.present ? creatorId.value : this.creatorId,
        status: status.present ? status.value : this.status,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        page: page.present ? page.value : this.page,
        storeId: storeId.present ? storeId.value : this.storeId,
        store: store.present ? store.value : this.store,
        totalDeny: totalDeny.present ? totalDeny.value : this.totalDeny,
      );
  @override
  String toString() {
    return (StringBuffer('Roster(')
          ..write('id: $id, ')
          ..write('employee: $employee, ')
          ..write('creatorId: $creatorId, ')
          ..write('status: $status, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('page: $page, ')
          ..write('storeId: $storeId, ')
          ..write('store: $store, ')
          ..write('totalDeny: $totalDeny')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, employee, creatorId, status, startTime,
      endTime, page, storeId, store, totalDeny);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Roster &&
          other.id == this.id &&
          other.employee == this.employee &&
          other.creatorId == this.creatorId &&
          other.status == this.status &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.page == this.page &&
          other.storeId == this.storeId &&
          other.store == this.store &&
          other.totalDeny == this.totalDeny);
}

class RostersCompanion extends UpdateCompanion<Roster> {
  final Value<int> id;
  final Value<Map<String, dynamic>?> employee;
  final Value<int?> creatorId;
  final Value<String?> status;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<int?> page;
  final Value<int?> storeId;
  final Value<Map<String, dynamic>?> store;
  final Value<int?> totalDeny;
  const RostersCompanion({
    this.id = const Value.absent(),
    this.employee = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.status = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.page = const Value.absent(),
    this.storeId = const Value.absent(),
    this.store = const Value.absent(),
    this.totalDeny = const Value.absent(),
  });
  RostersCompanion.insert({
    this.id = const Value.absent(),
    this.employee = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.status = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.page = const Value.absent(),
    this.storeId = const Value.absent(),
    this.store = const Value.absent(),
    this.totalDeny = const Value.absent(),
  });
  static Insertable<Roster> custom({
    Expression<int>? id,
    Expression<String>? employee,
    Expression<int>? creatorId,
    Expression<String>? status,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? page,
    Expression<int>? storeId,
    Expression<String>? store,
    Expression<int>? totalDeny,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employee != null) 'employee': employee,
      if (creatorId != null) 'creator_id': creatorId,
      if (status != null) 'status': status,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (page != null) 'page': page,
      if (storeId != null) 'store_id': storeId,
      if (store != null) 'store': store,
      if (totalDeny != null) 'total_deny': totalDeny,
    });
  }

  RostersCompanion copyWith(
      {Value<int>? id,
      Value<Map<String, dynamic>?>? employee,
      Value<int?>? creatorId,
      Value<String?>? status,
      Value<String>? startTime,
      Value<String>? endTime,
      Value<int?>? page,
      Value<int?>? storeId,
      Value<Map<String, dynamic>?>? store,
      Value<int?>? totalDeny}) {
    return RostersCompanion(
      id: id ?? this.id,
      employee: employee ?? this.employee,
      creatorId: creatorId ?? this.creatorId,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      page: page ?? this.page,
      storeId: storeId ?? this.storeId,
      store: store ?? this.store,
      totalDeny: totalDeny ?? this.totalDeny,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employee.present) {
      final converter = $RostersTable.$converteremployeen;

      map['employee'] = Variable<String>(converter.toSql(employee.value));
    }
    if (creatorId.present) {
      map['creator_id'] = Variable<int>(creatorId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startTime.present) {
      final converter = $RostersTable.$converterstartTime;

      map['start_time'] = Variable<DateTime>(converter.toSql(startTime.value));
    }
    if (endTime.present) {
      final converter = $RostersTable.$converterendTime;

      map['end_time'] = Variable<DateTime>(converter.toSql(endTime.value));
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (store.present) {
      final converter = $RostersTable.$converterstoren;

      map['store'] = Variable<String>(converter.toSql(store.value));
    }
    if (totalDeny.present) {
      map['total_deny'] = Variable<int>(totalDeny.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RostersCompanion(')
          ..write('id: $id, ')
          ..write('employee: $employee, ')
          ..write('creatorId: $creatorId, ')
          ..write('status: $status, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('page: $page, ')
          ..write('storeId: $storeId, ')
          ..write('store: $store, ')
          ..write('totalDeny: $totalDeny')
          ..write(')'))
        .toString();
  }
}

class $ShopsTable extends Shops with TableInfo<$ShopsTable, Shop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creatorIdMeta =
      const VerificationMeta('creatorId');
  @override
  late final GeneratedColumn<int> creatorId = GeneratedColumn<int>(
      'creator_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, creatorId, companyId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shops';
  @override
  VerificationContext validateIntegrity(Insertable<Shop> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('creator_id')) {
      context.handle(_creatorIdMeta,
          creatorId.isAcceptableOrUnknown(data['creator_id']!, _creatorIdMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shop map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shop(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      creatorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}creator_id']),
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id']),
    );
  }

  @override
  $ShopsTable createAlias(String alias) {
    return $ShopsTable(attachedDatabase, alias);
  }
}

class Shop extends DataClass implements Insertable<Shop> {
  final int id;
  final String? name;
  final int? creatorId;
  final int? companyId;
  const Shop({required this.id, this.name, this.creatorId, this.companyId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || creatorId != null) {
      map['creator_id'] = Variable<int>(creatorId);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    return map;
  }

  ShopsCompanion toCompanion(bool nullToAbsent) {
    return ShopsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      creatorId: creatorId == null && nullToAbsent
          ? const Value.absent()
          : Value(creatorId),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
    );
  }

  factory Shop.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shop(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      creatorId: serializer.fromJson<int?>(json['creator_id']),
      companyId: serializer.fromJson<int?>(json['company_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'creator_id': serializer.toJson<int?>(creatorId),
      'company_id': serializer.toJson<int?>(companyId),
    };
  }

  Shop copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          Value<int?> creatorId = const Value.absent(),
          Value<int?> companyId = const Value.absent()}) =>
      Shop(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        creatorId: creatorId.present ? creatorId.value : this.creatorId,
        companyId: companyId.present ? companyId.value : this.companyId,
      );
  @override
  String toString() {
    return (StringBuffer('Shop(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('creatorId: $creatorId, ')
          ..write('companyId: $companyId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, creatorId, companyId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shop &&
          other.id == this.id &&
          other.name == this.name &&
          other.creatorId == this.creatorId &&
          other.companyId == this.companyId);
}

class ShopsCompanion extends UpdateCompanion<Shop> {
  final Value<int> id;
  final Value<String?> name;
  final Value<int?> creatorId;
  final Value<int?> companyId;
  const ShopsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.companyId = const Value.absent(),
  });
  ShopsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.companyId = const Value.absent(),
  });
  static Insertable<Shop> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? creatorId,
    Expression<int>? companyId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (creatorId != null) 'creator_id': creatorId,
      if (companyId != null) 'company_id': companyId,
    });
  }

  ShopsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<int?>? creatorId,
      Value<int?>? companyId}) {
    return ShopsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      creatorId: creatorId ?? this.creatorId,
      companyId: companyId ?? this.companyId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (creatorId.present) {
      map['creator_id'] = Variable<int>(creatorId.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('creatorId: $creatorId, ')
          ..write('companyId: $companyId')
          ..write(')'))
        .toString();
  }
}

class $EventChecksTable extends EventChecks
    with TableInfo<$EventChecksTable, EventCheck> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventChecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_checks';
  @override
  VerificationContext validateIntegrity(Insertable<EventCheck> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  EventCheck map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventCheck(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value']),
    );
  }

  @override
  $EventChecksTable createAlias(String alias) {
    return $EventChecksTable(attachedDatabase, alias);
  }
}

class EventCheck extends DataClass implements Insertable<EventCheck> {
  final String key;
  final String? value;
  const EventCheck({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  EventChecksCompanion toCompanion(bool nullToAbsent) {
    return EventChecksCompanion(
      key: Value(key),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  factory EventCheck.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventCheck(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
    };
  }

  EventCheck copyWith(
          {String? key, Value<String?> value = const Value.absent()}) =>
      EventCheck(
        key: key ?? this.key,
        value: value.present ? value.value : this.value,
      );
  @override
  String toString() {
    return (StringBuffer('EventCheck(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventCheck &&
          other.key == this.key &&
          other.value == this.value);
}

class EventChecksCompanion extends UpdateCompanion<EventCheck> {
  final Value<String> key;
  final Value<String?> value;
  final Value<int> rowid;
  const EventChecksCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventChecksCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<EventCheck> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventChecksCompanion copyWith(
      {Value<String>? key, Value<String?>? value, Value<int>? rowid}) {
    return EventChecksCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventChecksCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
      'avatar', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant('business'));
  static const VerificationMeta _readAtMeta = const VerificationMeta('readAt');
  @override
  late final GeneratedColumn<String> readAt = GeneratedColumn<String>(
      'read_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeAgoMeta =
      const VerificationMeta('timeAgo');
  @override
  late final GeneratedColumn<String> timeAgo = GeneratedColumn<String>(
      'time_ago', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _routeNameMeta =
      const VerificationMeta('routeName');
  @override
  late final GeneratedColumn<String> routeName = GeneratedColumn<String>(
      'route_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _argumentsMeta =
      const VerificationMeta('arguments');
  @override
  late final GeneratedColumn<String> arguments = GeneratedColumn<String>(
      'arguments', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        action,
        avatar,
        title,
        body,
        type,
        readAt,
        timeAgo,
        createdAt,
        updatedAt,
        routeName,
        arguments
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(Insertable<Notification> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('read_at')) {
      context.handle(_readAtMeta,
          readAt.isAcceptableOrUnknown(data['read_at']!, _readAtMeta));
    }
    if (data.containsKey('time_ago')) {
      context.handle(_timeAgoMeta,
          timeAgo.isAcceptableOrUnknown(data['time_ago']!, _timeAgoMeta));
    } else if (isInserting) {
      context.missing(_timeAgoMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('route_name')) {
      context.handle(_routeNameMeta,
          routeName.isAcceptableOrUnknown(data['route_name']!, _routeNameMeta));
    }
    if (data.containsKey('arguments')) {
      context.handle(_argumentsMeta,
          arguments.isAcceptableOrUnknown(data['arguments']!, _argumentsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      avatar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      readAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}read_at']),
      timeAgo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_ago'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
      routeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}route_name']),
      arguments: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}arguments']),
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final String id;
  final String action;
  final String? avatar;
  final String title;
  final String body;
  final String type;
  final String? readAt;
  final String timeAgo;
  final String createdAt;
  final String updatedAt;
  final String? routeName;
  final String? arguments;
  const Notification(
      {required this.id,
      required this.action,
      this.avatar,
      required this.title,
      required this.body,
      required this.type,
      this.readAt,
      required this.timeAgo,
      required this.createdAt,
      required this.updatedAt,
      this.routeName,
      this.arguments});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || readAt != null) {
      map['read_at'] = Variable<String>(readAt);
    }
    map['time_ago'] = Variable<String>(timeAgo);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || routeName != null) {
      map['route_name'] = Variable<String>(routeName);
    }
    if (!nullToAbsent || arguments != null) {
      map['arguments'] = Variable<String>(arguments);
    }
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      action: Value(action),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      title: Value(title),
      body: Value(body),
      type: Value(type),
      readAt:
          readAt == null && nullToAbsent ? const Value.absent() : Value(readAt),
      timeAgo: Value(timeAgo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      routeName: routeName == null && nullToAbsent
          ? const Value.absent()
          : Value(routeName),
      arguments: arguments == null && nullToAbsent
          ? const Value.absent()
          : Value(arguments),
    );
  }

  factory Notification.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<String>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      type: serializer.fromJson<String>(json['type']),
      readAt: serializer.fromJson<String?>(json['read_at']),
      timeAgo: serializer.fromJson<String>(json['time_ago']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      routeName: serializer.fromJson<String?>(json['route_name']),
      arguments: serializer.fromJson<String?>(json['arguments']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'action': serializer.toJson<String>(action),
      'avatar': serializer.toJson<String?>(avatar),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'type': serializer.toJson<String>(type),
      'read_at': serializer.toJson<String?>(readAt),
      'time_ago': serializer.toJson<String>(timeAgo),
      'created_at': serializer.toJson<String>(createdAt),
      'updated_at': serializer.toJson<String>(updatedAt),
      'route_name': serializer.toJson<String?>(routeName),
      'arguments': serializer.toJson<String?>(arguments),
    };
  }

  Notification copyWith(
          {String? id,
          String? action,
          Value<String?> avatar = const Value.absent(),
          String? title,
          String? body,
          String? type,
          Value<String?> readAt = const Value.absent(),
          String? timeAgo,
          String? createdAt,
          String? updatedAt,
          Value<String?> routeName = const Value.absent(),
          Value<String?> arguments = const Value.absent()}) =>
      Notification(
        id: id ?? this.id,
        action: action ?? this.action,
        avatar: avatar.present ? avatar.value : this.avatar,
        title: title ?? this.title,
        body: body ?? this.body,
        type: type ?? this.type,
        readAt: readAt.present ? readAt.value : this.readAt,
        timeAgo: timeAgo ?? this.timeAgo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        routeName: routeName.present ? routeName.value : this.routeName,
        arguments: arguments.present ? arguments.value : this.arguments,
      );
  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('avatar: $avatar, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('type: $type, ')
          ..write('readAt: $readAt, ')
          ..write('timeAgo: $timeAgo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('routeName: $routeName, ')
          ..write('arguments: $arguments')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, action, avatar, title, body, type, readAt,
      timeAgo, createdAt, updatedAt, routeName, arguments);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.action == this.action &&
          other.avatar == this.avatar &&
          other.title == this.title &&
          other.body == this.body &&
          other.type == this.type &&
          other.readAt == this.readAt &&
          other.timeAgo == this.timeAgo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.routeName == this.routeName &&
          other.arguments == this.arguments);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<String> id;
  final Value<String> action;
  final Value<String?> avatar;
  final Value<String> title;
  final Value<String> body;
  final Value<String> type;
  final Value<String?> readAt;
  final Value<String> timeAgo;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> routeName;
  final Value<String?> arguments;
  final Value<int> rowid;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.avatar = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.type = const Value.absent(),
    this.readAt = const Value.absent(),
    this.timeAgo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.routeName = const Value.absent(),
    this.arguments = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationsCompanion.insert({
    required String id,
    required String action,
    this.avatar = const Value.absent(),
    required String title,
    required String body,
    this.type = const Value.absent(),
    this.readAt = const Value.absent(),
    required String timeAgo,
    required String createdAt,
    required String updatedAt,
    this.routeName = const Value.absent(),
    this.arguments = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        action = Value(action),
        title = Value(title),
        body = Value(body),
        timeAgo = Value(timeAgo),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Notification> custom({
    Expression<String>? id,
    Expression<String>? action,
    Expression<String>? avatar,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? type,
    Expression<String>? readAt,
    Expression<String>? timeAgo,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? routeName,
    Expression<String>? arguments,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (avatar != null) 'avatar': avatar,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (type != null) 'type': type,
      if (readAt != null) 'read_at': readAt,
      if (timeAgo != null) 'time_ago': timeAgo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (routeName != null) 'route_name': routeName,
      if (arguments != null) 'arguments': arguments,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? action,
      Value<String?>? avatar,
      Value<String>? title,
      Value<String>? body,
      Value<String>? type,
      Value<String?>? readAt,
      Value<String>? timeAgo,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<String?>? routeName,
      Value<String?>? arguments,
      Value<int>? rowid}) {
    return NotificationsCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      avatar: avatar ?? this.avatar,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      readAt: readAt ?? this.readAt,
      timeAgo: timeAgo ?? this.timeAgo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      routeName: routeName ?? this.routeName,
      arguments: arguments ?? this.arguments,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (readAt.present) {
      map['read_at'] = Variable<String>(readAt.value);
    }
    if (timeAgo.present) {
      map['time_ago'] = Variable<String>(timeAgo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (routeName.present) {
      map['route_name'] = Variable<String>(routeName.value);
    }
    if (arguments.present) {
      map['arguments'] = Variable<String>(arguments.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('avatar: $avatar, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('type: $type, ')
          ..write('readAt: $readAt, ')
          ..write('timeAgo: $timeAgo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('routeName: $routeName, ')
          ..write('arguments: $arguments, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $EventsTable events = $EventsTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $RosterChecksTable rosterChecks = $RosterChecksTable(this);
  late final $EmployeesTable employees = $EmployeesTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $RostersTable rosters = $RostersTable(this);
  late final $ShopsTable shops = $ShopsTable(this);
  late final $EventChecksTable eventChecks = $EventChecksTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final EventDao eventDao = EventDao(this as AppDatabase);
  late final ContactDao contactDao = ContactDao(this as AppDatabase);
  late final RosterCheckDao rosterCheckDao =
      RosterCheckDao(this as AppDatabase);
  late final EmployeeDao employeeDao = EmployeeDao(this as AppDatabase);
  late final TaskDao taskDao = TaskDao(this as AppDatabase);
  late final ProjectDao projectDao = ProjectDao(this as AppDatabase);
  late final RosterDao rosterDao = RosterDao(this as AppDatabase);
  late final ShopDao shopDao = ShopDao(this as AppDatabase);
  late final EventCheckDao eventCheckDao = EventCheckDao(this as AppDatabase);
  late final NotificationDao notificationDao =
      NotificationDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        events,
        contacts,
        rosterChecks,
        employees,
        tasks,
        projects,
        rosters,
        shops,
        eventChecks,
        notifications
      ];
}
