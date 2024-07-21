class ListResponse<DataType> {
  MetaBean? meta;
  List<DataType>? data;

  ListResponse({this.meta, this.data});

  ListResponse.fromJson(Map<String, dynamic> json,
      DataType converter(Map<String, dynamic> element)) {
    this.data = List<DataType>.from(
        json["data"] == null ? null : json["data"].map((x) => converter(x)));
    this.meta = json["meta"] != null ? MetaBean.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data["meta"] = this.meta?.toJson();
    }
    return data;
  }
}

class MetaBean {
  String? path;
  int? currentPage;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  MetaBean(
      {this.path,
      this.currentPage,
      this.from,
      this.lastPage,
      this.perPage,
      this.to,
      this.total});

  MetaBean.fromJson(Map<String, dynamic> json) {
    this.path = json['path'];
    this.currentPage = json['current_page'];
    this.from = json['from'];
    this.lastPage = json['last_page'];
    this.perPage = json['per_page'];
    this.to = json['to'];
    this.total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
