class EventCount {
  int? forYouToConfirm;
  int? waitingToConfirm;
  int? denied;
  int? confirmed;

  EventCount({this.forYouToConfirm, this.waitingToConfirm, this.denied, this.confirmed});

  EventCount.fromJson(Map<String, dynamic> json) {
    this.forYouToConfirm = json['for_you_to_confirm'];
    this.waitingToConfirm = json['waiting_to_confirm'];
    this.denied = json['denied'];
    this.confirmed = json['confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['for_you_to_confirm'] = this.forYouToConfirm;
    data['waiting_to_confirm'] = this.waitingToConfirm;
    data['denied'] = this.denied;
    data['confirmed'] = this.confirmed;
    return data;
  }
}
