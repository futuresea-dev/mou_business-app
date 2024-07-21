import 'dart:io';

class CompanyRequest {
  String? name;
  String? email;
  File? logo;
  String? countryCode;
  String? city;
  String? address;

  CompanyRequest(
      {this.name,
      this.email,
      this.logo,
      this.countryCode,
      this.city,
      this.address});
}
