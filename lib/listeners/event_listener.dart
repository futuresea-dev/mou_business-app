import 'package:mou_business_app/core/databases/app_database.dart';

abstract class EventListener {
  void onDenyEvent(Event event);

  void onAcceptEvent(Event event);

  void onDeleteEvent(Event event);

  void onLeaveEvent(Event event);
}
