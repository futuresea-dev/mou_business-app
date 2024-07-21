import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/event_check_dao.dart';
import 'package:mou_business_app/core/databases/dao/event_dao.dart';
import 'package:mou_business_app/core/models/event_count.dart';
import 'package:mou_business_app/core/models/list_response.dart';
import 'package:mou_business_app/core/network_bound_resource.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/core/services/api_service.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_shared.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:mou_business_app/utils/types/event_status.dart';
import 'package:mou_business_app/utils/types/event_task_type.dart';
import 'package:mou_business_app/utils/types/work_status.dart';

class EventRepository {
  CancelToken _cancelToken = CancelToken();
  final EventDao eventDao;
  final EventCheckDao eventCheckDao;

  EventRepository(this.eventDao, this.eventCheckDao);

  Future<Resource<ListResponse<Event>>> getCalendarEventsByDate(
    DateTime selected,
    int page,
  ) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final value = AppUtils.convertDayToString(selected, format: "yyyy-MM-dd");
    final dateTime = DateTime.parse(value);
    final resource = NetworkBoundResource<ListResponse<Event>, ListResponse<Event>>(
      createCall: () => APIService.getEventsByDate(dateTime, page, _cancelToken),
      parsedData: (json) => ListResponse<Event>.fromJson(json, (e) => Event.fromJson(e)),
      saveCallResult: (response) async {
        if (page == AppConstants.FIRST_PAGE) eventDao.deleteHomeEventsByDate(selected);
        final List<Event> events = response.data ?? [];
        for (Event event in events) {
          await eventDao.insertHomeEvent(event.copyWith(
            dateLocal: Value(selected),
            eventStatus: Value(
              event.waitingToConfirm ?? true ? EventStatus.WAITING : EventStatus.CONFIRMED,
            ),
          ));
        }
      },
    );
    return resource.getAsObservable();
  }

  Future<Map<String, dynamic>> getDBEventChecks(DateTime fromDate, DateTime toDate) async {
    Map<String, dynamic> eventChecks = {};
    int days = AppUtils.countDays(fromDate, toDate);
    for (int i = 0; i <= days; i++) {
      final eventCheck = await eventCheckDao.getEventCheckByDate(fromDate.add(Duration(days: i)));
      if (eventCheck != null) {
        eventChecks[eventCheck.key] = eventCheck.value;
      }
    }
    return eventChecks;
  }

  Future<Resource<Map<String, dynamic>>> getEventChecks(DateTime fromDate, DateTime toDate) {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    return NetworkBoundResource<Map<String, dynamic>, Map<String, dynamic>>(
      createCall: () => APIService.checkEventDateOfMonth(fromDate, toDate, _cancelToken),
      parsedData: (json) => json as Map<String, dynamic>,
      saveCallResult: (response) async {
        int days = AppUtils.countDays(fromDate, toDate);
        for (int i = 0; i <= days; i++) {
          final date = fromDate.add(Duration(days: i));
          final eventCheck = await eventCheckDao.getEventCheckByDate(date);
          if (eventCheck != null) {
            await eventCheckDao.deleteEventCheck(eventCheck);
          }
        }
        response.forEach((key, value) {
          eventCheckDao.insertEventCheck(EventCheck(key: key, value: value));
        });
      },
      loadFromDb: () => getDBEventChecks(fromDate, toDate),
    ).getAsObservable();
  }

  Future<Resource<EventCount>> getCountEvent(List<EventTaskType> filterTypes) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    List<String> types = filterTypes.map((e) => e.name).toList();
    final resource = NetworkBoundResource<EventCount, EventCount>(
      createCall: () => APIService.getCountEvent(_cancelToken, eventTypes: types),
      parsedData: (json) => EventCount.fromJson(json),
      saveCallResult: AppShared.setEventCount,
      loadFromDb: () => AppShared.getEventCount(),
    );
    return resource.getAsObservable();
  }

  Future<Resource<ListResponse<Event>>> getEventsByTypes(
    EventStatus eventStatus,
    int page,
    List<EventTaskType> filterTypes,
  ) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    List<String> types = filterTypes.map((e) => e.name).toList();
    final resource = NetworkBoundResource<ListResponse<Event>, ListResponse<Event>>(
      createCall: () {
        switch (eventStatus) {
          case EventStatus.WAITING:
            return APIService.getEventsByWaiting(
              page,
              _cancelToken,
              eventTypes: types,
            );
          case EventStatus.DENIED:
            return APIService.getEventsByDenied(
              page,
              _cancelToken,
              eventTypes: types,
            );
          case EventStatus.CONFIRMED:
            return APIService.getEventsByConfirmed(
              page,
              _cancelToken,
              eventTypes: types,
            );
        }
      },
      parsedData: (json) => ListResponse<Event>.fromJson(json, (e) => Event.fromJson(e)),
      saveCallResult: (response) async {
        if (page == AppConstants.FIRST_PAGE) {
          eventDao.deleteEventsByStatus(eventStatus);
        }
        List<Event> events = response.data ?? [];
        for (Event event in events) {
          final DateTime? dateLocal = AppUtils.convertStringToDateTime(
            event.startDate ?? '',
            split: true,
          );
          await eventDao.insertEvent(event.copyWith(
            dateLocal: Value(dateLocal),
            eventStatus: Value(eventStatus),
          ));
        }
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> confirmEvent(int id) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.confirmEvent(id, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (json) async {
        final List<Event> events = await eventDao.getEventsByID(id);
        for (Event event in events) {
          await eventDao.updateEvent(event.copyWith(
            waitingToConfirm: Value(false),
            eventStatus: Value(EventStatus.CONFIRMED),
          ));
        }
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> denyEvent(int id) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.denyEvent(id, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (json) async => await eventDao.deleteEventByID(id),
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> deleteEvent(int id) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.deleteEvent(id, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (json) async => await eventDao.deleteEventByID(id),
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> leaveEvent(int id) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.leaveEvent(id, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (json) async => await eventDao.deleteEventByID(id),
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> acceptRoster(int id) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.acceptRoster(id, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (json) async {
        final List<Event> events = await eventDao.getEventsByID(id);
        for (Event event in events) {
          await eventDao.updateEvent(event.copyWith(
            waitingToConfirm: Value(false),
            eventStatus: Value(EventStatus.CONFIRMED),
          ));
        }
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> declineRoster(int id) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.declineRoster(id, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (json) async => await eventDao.deleteEventByID(id),
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> deleteRoster(int id) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.deleteRoster(id, _cancelToken),
      parsedData: (json) {
        print("====== data : $json ======");
        return json;
      },
      saveCallResult: (json) async => await eventDao.deleteEventByID(id),
    );
    return resource.getAsObservable();
  }

  Future<Resource<List<Event>>> getEventAlarmDevice() async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<List<Event>, List<Event>>(
      createCall: () => APIService.getEventAlarmDevice(_cancelToken),
      parsedData: (json) {
        final data = json as List;
        return data.map((event) => Event.fromJson(event)).toList();
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<Event>> confirmDoneTask(int id) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<Event, Event>(
      createCall: () => APIService.doneTask(id, _cancelToken),
      parsedData: (json) => Event.fromJson(json),
      saveCallResult: (resource) async {
        final List<Event> events = await eventDao.getEventsByID(id);
        for (Event event in events) {
          await eventDao.updateEvent(event.copyWith(
            doneTime: Value(resource.doneTime),
            status: Value(TaskStatus.DONE),
          ));
        }
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<ListResponse<Event>>> getWorks({
    int page = 1,
    required WorkStatus workStatus,
    List<EventTaskType> types = const [],
  }) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<ListResponse<Event>, ListResponse<Event>>(
      createCall: () => APIService.getWorkData(
        page: page,
        status: workStatus.apiRequestName,
        types: types.map((e) => e.name).toList(),
        _cancelToken,
      ),
      parsedData: (json) => ListResponse<Event>.fromJson(json, (e) => Event.fromJson(e)),
      saveCallResult: (response) async {
        if (page == AppConstants.FIRST_PAGE) {
          eventDao.deleteWorksByStatus(workStatus);
        }
        List<Event> events = response.data ?? [];
        for (Event event in events) {
          final DateTime? dateLocal = AppUtils.convertStringToDateTime(
            event.startDate ?? '',
            split: true,
          );
          await eventDao.insertWork(event.copyWith(
            dateLocal: Value(dateLocal),
            workStatus: Value(workStatus),
          ));
        }
      },
    );
    return resource.getAsObservable();
  }

  cancel() {
    if (_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }
}
