import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/requests/change_phone_request.dart';
import 'package:mou_business_app/ui/add_employee/add_employee_page.dart';
import 'package:mou_business_app/ui/add_project/add_project_page.dart';
import 'package:mou_business_app/ui/add_roster/add_roster_page.dart';
import 'package:mou_business_app/ui/add_task/add_task_page.dart';
import 'package:mou_business_app/ui/calendar/calendar_page.dart';
import 'package:mou_business_app/ui/change_number/change_number_page.dart';
import 'package:mou_business_app/ui/edit_profile/edit_profile_page.dart';
import 'package:mou_business_app/ui/employee/employee_page.dart';
import 'package:mou_business_app/ui/event/event_page.dart';
import 'package:mou_business_app/ui/feedback/feedback_page.dart';
import 'package:mou_business_app/ui/home/home_page.dart';
import 'package:mou_business_app/ui/login/login_page.dart';
import 'package:mou_business_app/ui/month_calendar/month_calendar_page.dart';
import 'package:mou_business_app/ui/onboarding_slides/onboarding_slides_page.dart';
import 'package:mou_business_app/ui/project_detail/project_detail_page.dart';
import 'package:mou_business_app/ui/register_profile/register_profile_page.dart';
import 'package:mou_business_app/ui/roster/roster_page.dart';
import 'package:mou_business_app/ui/send_email/send_email_page.dart';
import 'package:mou_business_app/ui/setting/setting_page.dart';
import 'package:mou_business_app/ui/store/store_page.dart';
import 'package:mou_business_app/ui/subscription/subscription_page.dart';
import 'package:mou_business_app/ui/task_detail/task_detail_page.dart';
import 'package:mou_business_app/ui/work/work_page.dart';

class Routers {
  static const String ROOT = "/";
  static const String LOGIN = "/login";
  static const String REGISTER_PROFILE = "/register_profile";
  static const String EDIT_PROFILE = "/edit_profile";
  static const String SETTING = "/setting";
  static const String HOME = "/home";
  static const String ADD_TASK = "/add_task";
  static const String ADD_PROJECT = "/add_project";
  static const String ADD_EMPLOYEE = "/add_employee";
  static const String PROJECT_BY_STATUS = "/project_by_status";
  static const String EMPLOYEE = "/employee";
  static const String FEEDBACK = "/feedback";
  static const String EDIT_EMPLOYEE = "/edit_employee";
  static const String PROJECT_DETAIL = "/project_detail";
  static const String ADD_ROSTER = "/add_roster";
  static const String WORK = "/work";
  static const String ROSTER = "/roster";
  static const String MONTH_CALENDAR = "/month_calendar";
  static const String TASK_DETAIL = "/task_detail";
  static const String SEND_EMAIL = "/send-email";
  static const String CHANGE_NUMBER = "/change_number";
  static const String STORE = "/store";
  static const String ADD_EVENT = "/add_event";
  static const String CALENDAR = "/calendar";
  static const String EVENT = "/event";
  static const String ONBOARDING = "/onboarding";
  static const String SUBSCRIPTION = "/subscription";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    print("Page ---- ${settings.name}");
    switch (settings.name) {
      case LOGIN:
        return _animRoute(LoginPage(message: arguments as Map<String, dynamic>?));
      case SETTING:
        final String routeName = arguments is String ? arguments : '';
        return _animRoute(SettingPage(routeName: routeName));
      case EDIT_PROFILE:
        return _animRoute(EditProfilePage(), beginOffset: top);
      case REGISTER_PROFILE:
        return _animRoute(const RegisterProfilePage());
      case HOME:
        return _animRoute(HomePage(openCalendar: arguments is bool ? arguments : false));
      case EVENT:
        final int index = arguments is int ? arguments : int.tryParse('${arguments ?? '0'}') ?? 0;
        return _animRoute(EventPage(index: index));
      case CALENDAR:
        DateTime? dateTime;
        if (arguments is DateTime) {
          dateTime = arguments;
        } else if (arguments is String) {
          dateTime = DateTime.tryParse(arguments);
        }
        return _animRoute(CalendarPage(selectedDay: dateTime));
      case ADD_TASK:
        return _animRoute(AddTaskPage(taskId: arguments as int?));
      case ADD_PROJECT:
        return _animRoute(AddProjectPage(projectId: arguments as int?));
      case ADD_EMPLOYEE:
        return _animRoute(AddEmployeePage(employee: null));
      case EDIT_EMPLOYEE:
        var employee = arguments as Employee;
        return _animRoute(AddEmployeePage(employee: employee));
      case EMPLOYEE:
        return _animRoute(EmployeePage());
      case FEEDBACK:
        return _animRoute(FeedbackPage());
      case PROJECT_DETAIL:
        return _animRoute(ProjectDetailPage(argument: arguments as ProjectDetailArgument?));
      case ADD_ROSTER:
        return _animRoute(AddRosterPage(rosterId: arguments as int?));
      case WORK:
        return _animRoute(WorkPage());
      case ROSTER:
        return _animRoute(RosterPage(selectedDay: arguments as DateTime?));
      case MONTH_CALENDAR:
        return _animRoute(MonthCalendarPage(selectedDay: arguments as DateTime));
      case TASK_DETAIL:
        var params = arguments as List<dynamic>;
        var taskId = params[0];
        var taskName = params[1];
        return _animRoute(TaskDetailPage(taskId: taskId, taskName: taskName));
      case SEND_EMAIL:
        return _animRoute(SendEmailPage());
      case CHANGE_NUMBER:
        return _animRoute(ChangeNumberPage(request: arguments as ChangeNumberRequest));
      case STORE:
        return _animRoute(StorePage());
      case ONBOARDING:
        return _animRoute(OnboardingSlidesPage());
      case SUBSCRIPTION:
        final String? productId = arguments is String ? arguments : null;
        return _animRoute(SubscriptionPage(productId: productId));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Route _animRoute(Widget page, {Offset? beginOffset}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = beginOffset ?? Offset(0.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Offset center = Offset(0.0, 0.0);
  static Offset top = Offset(0.0, 1.0);
  static Offset bottom = Offset(0.0, -1.0);
  static Offset left = Offset(-1.0, 0.0);
  static Offset right = Offset(1.0, 0.0);
}
