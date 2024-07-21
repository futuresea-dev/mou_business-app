import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class ContactRequest {
  String? name;
  String? phoneNumber;
  String? dialCode;
  File? avatar;

  ContactRequest({this.name, this.phoneNumber, this.dialCode, this.avatar});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': this.name,
      'phone_number': this.phoneNumber,
      'avatar': avatar != null
          ? MultipartFile.fromFileSync(
              avatar?.path ?? "",
              filename: path.basename(avatar?.path ?? ""),
            )
          : null,
      'dial_code': this.dialCode
    };
  }
}
