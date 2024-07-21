import 'package:mou_business_app/utils/types/app_types.dart';

class Company {
  int? id;
  String? name;
  String? email;
  String? address;
  String? countryCode;
  String? city;
  String? logo;
  List<int>? workingDays;
  Company({this.id, this.name, this.email, this.address, this.countryCode, this.city, this.logo, this.workingDays});

  Company.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.address = json['address'];
    this.countryCode = json['country_code'];
    this.city = json['city'];
    this.logo = json['logo'];
    this.workingDays = json['working_days'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['country_code'] = this.countryCode;
    data['city'] = this.city;
    data['logo'] = this.logo;
    data['working_days'] = this.workingDays;
    return data;
  }

  List<WeekDay> get convertedWorkingDays {
    if (workingDays?.isEmpty ?? true) return [];
    // API value: 1->7 = Monday->Sunday
    return workingDays!.map((e) => e == 7 ? WeekDay.Sunday : WeekDay.values[e]).toList();
  }
}
