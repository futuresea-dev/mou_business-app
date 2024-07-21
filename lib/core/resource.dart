import 'package:dio/dio.dart';
import 'package:mou_business_app/helpers/resource_type.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class Resource<DataType> {
  int? status;
  String? message;
  DataType? data;

  Resource({this.message, this.data, this.status});

  Resource.fromJson(Map<String, dynamic> json) {
    this.message = json['message'];
    this.status = json['status'];
    this.data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }

  Resource.withError(DioException error, {dynamic data}) {
    String? message;
    int? code;
    print("=========== ERROR ===========");
    print("${error.type}");
    print("=========== message ===========");
    print("${error.message}");
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        code = ResourceType.CONNECT_TIMEOUT;
        message = allTranslations.text(AppLanguages.alertConnectTimeout);
        break;
      case DioExceptionType.sendTimeout:
        code = ResourceType.SEND_TIMEOUT;
        message = allTranslations.text(AppLanguages.alertSendTimeout);
        break;
      case DioExceptionType.receiveTimeout:
        code = ResourceType.RECEIVE_TIMEOUT;
        message = allTranslations.text(AppLanguages.alertDisconnect);
        break;
      case DioExceptionType.badResponse:
        Response? response = error.response;
        print("=========== Status Code ===========");
        print("${response?.statusCode}");
        code = response?.statusCode;
        print("=========== Data ===========");
        print("${response?.data.toString()}");
        if (response?.statusCode == ResourceType.ERROR_TOKEN) {
          message = '';
        } else if (response?.data != null) {
          message = response?.data is String
              ? response?.data
              : response?.data is Map<String, dynamic>
                  ? response?.data["message"] ?? ''
                  : '';
        }
        break;
      case DioExceptionType.cancel:
        code = ResourceType.CANCEL;
        break;
      case DioExceptionType.unknown:
        print("=========== error ===========");
        print("${error.error}");
        code = ResourceType.ERROR_SERVER;
        message = error.message ?? "";
        break;
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        break;
      case DioExceptionType.connectionError:
        // TODO: Handle this case.
        break;
    }

    this.message = message;
    this.status = code;
    this.data = data;
  }

  Resource.withDisconnect() {
    print("=========== DISCONNECT ===========");
    this.message = allTranslations.text(AppLanguages.alertDisconnect);
    this.status = ResourceType.DISCONNECT;
    this.data = null;
  }

  Resource.withNotData() {
    print("=========== DATA NULL ===========");
    this.message = '';
    this.status = ResourceType.NULL_DATA;
    this.data = null;
  }

  Resource.withHasData(DataType data) {
    print("=========== HAS DATA ===========");
    this.message = allTranslations.text(AppLanguages.alertDataSuccess);
    this.status = ResourceType.SUCCESS;
    this.data = data;
  }

  bool get isSuccess => status == ResourceType.SUCCESS;

  bool get isError => status != ResourceType.SUCCESS;

  bool get isErrorToken => status == ResourceType.ERROR_TOKEN;
}
