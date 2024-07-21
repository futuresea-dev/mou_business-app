import 'package:mou_business_app/core/models/company.dart';
import 'package:mou_business_app/core/models/permission.dart';
import 'package:mou_business_app/core/models/setting.dart';

class RegisterResponse {
  int? id;
  String? name;
  String? email;
  String? birthDay;
  int? gender;
  String? countryCode;
  String? city;
  String? fullAddress;
  String? dialCode;
  String? phoneNumber;
  String? avatar;
  Setting? settings;
  Company? company;
  Permission? permission;

  RegisterResponse({
    this.id,
    this.name,
    this.email,
    this.birthDay,
    this.gender,
    this.countryCode,
    this.city,
    this.fullAddress,
    this.avatar,
    this.dialCode,
    this.phoneNumber,
    this.settings,
    this.company,
    this.permission,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        birthDay: json["birthday"],
        gender: json["gender"],
        countryCode: json["country_code"],
        city: json["city"],
        fullAddress: json["full_address"],
        avatar: json["avatar"],
        dialCode: json["dial_code"],
        phoneNumber: json["phone_number"],
        settings: Setting.fromJson(json["settings"]),
        company: Company.fromJson(json['company']),
        permission: Permission.fromJson(json['permission']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['birthday'] = this.birthDay;
    data['gender'] = this.gender;
    data['country_code'] = this.countryCode;
    data['city'] = this.city;
    data['full_address'] = this.fullAddress;
    data['avatar'] = this.avatar;
    data['phone_number'] = this.phoneNumber;
    data['dial_code'] = this.dialCode;
    data['settings'] = this.settings?.toJson();
    data['company'] = this.company?.toJson();
    data['permission'] = this.permission?.toJson();
    return data;
  }
}
