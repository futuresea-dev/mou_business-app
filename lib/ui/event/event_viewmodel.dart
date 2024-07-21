import 'package:mou_business_app/core/models/event_count.dart';
import 'package:mou_business_app/core/repositories/event_repository.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/types/event_task_type.dart';
import 'package:rxdart/rxdart.dart';

class EventViewModel extends BaseViewModel {
  final indexSubject = BehaviorSubject<int>.seeded(0);
  final eventCountSubject = BehaviorSubject<EventCount>();

  final EventRepository _eventRepository;

  EventViewModel(this._eventRepository);

  fetchEventCount(List<EventTaskType> filterTypes) async {
    final resource = await _eventRepository.getCountEvent(filterTypes);
    eventCountSubject.add(resource.data ?? EventCount());
  }

  void onTabChanged(int index) => indexSubject.add(index);

  @override
  void dispose() async {
    _eventRepository.cancel();
    await indexSubject.drain();
    indexSubject.close();
    await eventCountSubject.drain();
    eventCountSubject.close();
    super.dispose();
  }
}
