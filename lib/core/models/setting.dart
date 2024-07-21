class Setting {
  String? languageCode;
  int? busyMode;

  Setting({this.languageCode, this.busyMode});

  Setting.fromJson(Map<String, dynamic> json) {
    this.languageCode = json['language_code'];
    this.busyMode = json['busy_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_code'] = this.languageCode;
    data['busy_mode'] = this.busyMode;
    return data;
  }
}
