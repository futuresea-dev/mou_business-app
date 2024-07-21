import 'dart:async';

import 'package:flutter/material.dart' hide Notification;
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/models/list_response.dart';
import 'package:mou_business_app/core/repositories/event_repository.dart';
import 'package:mou_business_app/core/repositories/notification_repository.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/ui/base/loadmore_viewmodel.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:mou_business_app/utils/types/event_task_type.dart';
import 'package:rxdart/rxdart.dart' hide Notification;

class CalendarViewModel extends LoadMoreViewModel<Event> {
  final focusedDaySubject = BehaviorSubject<DateTime>();
  final eventsSubject = BehaviorSubject<Map<DateTime, List<dynamic>>>();

  final EventRepository _eventRepository;
  final NotificationRepository _notificationRepository;

  CalendarViewModel(this._eventRepository, this._notificationRepository);

  @override
  Future<Resource<ListResponse>> onSyncResource(int page) {
    DateTime selected = AppUtils.clearTime(focusedDaySubject.value) ?? DateTime.now();
    return _eventRepository.getCalendarEventsByDate(selected, page);
  }

  @override
  Future<void> onRefresh() {
    final selected = AppUtils.clearTime(focusedDaySubject.valueOrNull);
    if (selected != null) {
      final weekDay = selected.weekday % 7;
      _fetchEvents(
        selected.subtract(Duration(days: weekDay)),
        selected.add(Duration(days: 6 - weekDay)),
      );
    }
    return super.onRefresh();
  }

  init(DateTime? selectedDay) {
    focusedDaySubject.add(selectedDay ?? DateTime.now());
    this.onRefresh();
    this.onSyncResource(1);
  }

  Future<void> _fetchEvents(DateTime fromDate, DateTime toDate) async {
    final dbEventChecks = await _eventRepository.getDBEventChecks(fromDate, toDate);
    _updateEvents(dbEventChecks);

    final resource = await _eventRepository.getEventChecks(fromDate, toDate);
    final focusedDay = focusedDaySubject.value;
    if (fromDate.isBefore(focusedDay) && toDate.isAfter(focusedDay)) {
      _updateEvents(resource.data ?? {});
    }
  }

  void _updateEvents(Map<String, dynamic> eventChecks) {
    Map<DateTime, List<dynamic>> events = {};
    eventChecks.forEach((key, value) {
      final dateKey = DateTime.parse(key);
      DateTime date = DateTime(dateKey.year, dateKey.month, dateKey.day);
      events[date] = [value];
    });
    eventsSubject.add(events);
  }

  void onBackPressed() {
    Navigator.popUntil(context, (router) => router.isFirst);
    Navigator.pushNamed(
      context,
      Routers.MONTH_CALENDAR,
      arguments: focusedDaySubject.valueOrNull,
    );
  }

  void onDaySelected(DateTime day) {
    _eventRepository.cancel();
    focusedDaySubject.add(day);
    this.onRefresh();
  }

  onLeave(Event? event) {
    if (event == null) return;
    setLoading(true);
    final request = event.type == EventTaskType.ROSTER
        ? _eventRepository.declineRoster(event.id)
        : _eventRepository.leaveEvent(event.id);
    request.then((value) {
      setLoading(false);
    }).catchError((Object error) {
      setLoading(false);
    });
  }

  onDone(Event event) {
    setLoading(true);
    _eventRepository.confirmDoneTask(event.id).then((value) {
      setLoading(false);
    }).catchError((Object error) {
      setLoading(false);
    });
  }

  @override
  void dispose() {
    _eventRepository.cancel();
    focusedDaySubject.close();
    eventsSubject.close();
    super.dispose();
  }

  Future<List<Notification>> getNotifications(int page) async {
    return _notificationRepository.getNotifications(page).then((resource) {
      if (resource.isSuccess) {
        return resource.data ?? [];
      } else {
        final String message = resource.message ?? '';
        if (message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ));
        }
        return <Notification>[];
      }
    });
  }

  Future<List<Notification>> getLocalNotifications() =>
      _notificationRepository.notificationDao.getAllNotifications();

  void navigateNotification(Notification notification) {
    final String routeName = notification.routeName ?? '';
    if (routeName.isNotEmpty) {
      final arguments = notification.arguments;
      if (routeName == Routers.CALENDAR) {
        Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => route.isFirst,
            arguments: arguments);
      } else {
        Navigator.pushNamed(context, routeName, arguments: arguments);
      }
    }
  }
}
