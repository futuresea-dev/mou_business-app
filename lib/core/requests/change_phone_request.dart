class ChangeNumberRequest {
  String action;
  String code;
  String phoneNumber;
  String dialCode;
  String email;

  ChangeNumberRequest({
    this.action = '',
    this.code = '',
    this.phoneNumber = '',
    this.dialCode = '',
    this.email = '',
  });

  ChangeNumberRequest copyWith({
    String? action,
    String? code,
    String? phoneNumber,
    String? dialCode,
    String? email,
  }) =>
      ChangeNumberRequest(
        action: action ?? this.action,
        code: code ?? this.code,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        dialCode: dialCode ?? this.dialCode,
        email: email ?? this.email,
      );

  factory ChangeNumberRequest.fromJson(Map<String, dynamic> json) =>
      ChangeNumberRequest(
        action: json["action"],
        code: json["code"],
        phoneNumber: json["phone_number"],
        dialCode: json["dial_code"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "code": code,
        "phone_number": phoneNumber,
        "dial_code": dialCode,
        "email": email,
      };
}
