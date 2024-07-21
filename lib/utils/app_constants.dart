class AppConstants {
  static const String fontQuickSand = "Quicksand";
  static const String countryCodesPath = "assets/data.json";
  static const String code = "+84";
  static const String dateFormat = "dd/MM/yyyy";
  static const String hourMinuteFormat = "HH:mm";
  static const String dateFormatUpload = "yyyy-MM-dd";
  static const String dateHourFormatAddProject = "yyyy-MM-dd HH:mm:ss";
  static const String dateHourFormatAddRoster = "yyyy-MM-dd HH:mm:ss";
  static const String channelIDNotify = "CHANNEL_ID_";
  static const String linkDonate =
      "https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=FSSQZVVCPATL2&currency_code=AUD&source=url";
  static const String linkAbout = "https://www.mou.center";
  static const String dateFormatDisplay = "dd/MM/yy";

  static const int FIRST_PAGE = 1;
  static const int LIMIT = 10;

  static const String patternEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String projectScopeLink =
      "https://www.mou.center/articles-news/categories/project-scope";
  static const String taskScopeLink = "https://www.mou.center/articles-news/categories/tasks";
  static const String rosterScopeLink = "https://www.mou.center/articles-news/categories/rosters";
  static const String leadershipScopeLink =
      "https://www.mou.center/articles-news/categories/leadership";

  // Purchases
  static const String PURCHASE_ANDROID_KEY = 'goog_LpxOvnEwInGAzwkeZjqIVQhwwMp';
  static const String PURCHASE_IOS_KEY = 'appl_eNtBizxGvNyUjDWfDHWfyWluPYI';

  // Limit for unSubscription users
  static const int LIMIT_MEMBERS = 3;

  // Animation list
  static const int ANIMATION_LIST_DURATION = 700;
  static const double ANIMATION_LIST_RE_BOUNCE_DEPTH = 3;
}
