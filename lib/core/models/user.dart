class User {
  int? id;
  String? name;
  String? avatar;
  String? fullAddress;
  bool? isAccepted;

  User({
    this.id,
    this.name,
    this.avatar,
    this.fullAddress,
    this.isAccepted,
  });

  User.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.avatar = json['avatar'];
    this.fullAddress = json['full_address'];
    this.isAccepted = json['is_accepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['full_address'] = this.fullAddress;
    data['is_accepted'] = this.isAccepted;
    return data;
  }
}
