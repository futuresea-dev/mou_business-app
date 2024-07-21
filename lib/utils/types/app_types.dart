class TaskStatus {
  static const String NOT_DONE = "NOT_DONE"; //Color red
  static const String WAITING = "WAITING"; //Color grey
  static const String DONE = "DONE"; //Color green
  static const String IN_PROGRESS = "IN_PROGRESS"; //Color yellow
}

class RosterStatusType {
  static const String waiting = "W";
  static const String accept = "Y";
  static const String deny = "N";
}

enum VerifyType { LOGIN, CHANGE_PHONE }

class NotifyType {
  static const String SMS_MESSAGE = "SMS_MESSAGE";
}

enum WeekDay {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}
