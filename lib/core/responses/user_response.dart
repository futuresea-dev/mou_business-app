class UserResponse {
  int? id;
  String? name;
  String? email;
  DateTime? birthDay;
  int? gender;
  String? countryCode;
  String? city;
  String? phoneNumber;
  String? dialCode;
  String? avatar;

  UserResponse(
      {this.id,
      this.name,
      this.email,
      this.birthDay,
      this.gender,
      this.countryCode,
      this.city,
      this.phoneNumber,
      this.dialCode,
      this.avatar});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        birthDay: json["birthday"],
        gender: json["gender"],
        countryCode: json["country_code"],
        city: json["city"],
        phoneNumber: json["phone_number"],
        dialCode: json["dial_code"],
        avatar: json["avatar"]);
  }
}
