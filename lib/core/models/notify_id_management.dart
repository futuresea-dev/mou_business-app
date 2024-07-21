class NotifyIdManagement {
  int? id;
  int? notifyId;

  NotifyIdManagement({this.id, this.notifyId});

  factory NotifyIdManagement.fromJson(Map<String, dynamic> json) {
    return NotifyIdManagement(id: json["id"], notifyId: json["notify_id"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notify_id'] = this.notifyId;
    return data;
  }
}

class NotifyIdManagementList {
  List<NotifyIdManagement>? notifyIdManagements;
  NotifyIdManagementList({this.notifyIdManagements});

  factory NotifyIdManagementList.fromJson(Map<String, dynamic> json) {
    return NotifyIdManagementList(
        notifyIdManagements: json["notify_id_managements"] == null
            ? null
            : (json["notify_id_managements"] as List)
                .map<NotifyIdManagement>(
                    (item) => NotifyIdManagement.fromJson(item))
                .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notify_id_managements'] =
        this.notifyIdManagements?.map((item) => item.toJson()).toList();
    return data;
  }
}
