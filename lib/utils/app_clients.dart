import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:mou_business_app/core/services/firebase_service.dart';
import 'package:mou_business_app/helpers/resource_type.dart';
import 'package:mou_business_app/utils/app_apis.dart';
import 'package:mou_business_app/utils/app_globals.dart';
import 'package:mou_business_app/utils/app_shared.dart';

const String KEY_ACCEPT = 'Accept';
const String KEY_AUTH = 'Authorization';
const String KEY_CONTENT_TYPE = "Content-Type";

class AppClients extends DioForNative {
  bool multiPart;

  AppClients({
    String baseUrl = AppApis.domainAPI,
    BaseOptions? options,
    this.multiPart = false,
  }) : super(options) {
    this.interceptors.add(InterceptorsWrapper(
          onRequest: _requestInterceptor,
          onError: _errorInterceptor,
        ));
    this.options.baseUrl = baseUrl;
  }

  _requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey(KEY_AUTH)) {
      options.headers.remove(KEY_AUTH);
    }

    final accessToken = await AppShared.getAccessToken() ?? '';

    if (accessToken.isNotEmpty) {
      print('access token: $accessToken');
      options.headers[KEY_AUTH] = 'Bearer $accessToken';
    }

    options.headers[KEY_ACCEPT] = 'application/json';

    if (!multiPart) {
      options.headers[KEY_CONTENT_TYPE] = "application/json";
    }

    options.connectTimeout = const Duration(seconds: 60);
    options.receiveTimeout = const Duration(seconds: 60);

    handler.next(options);
  }

  void _errorInterceptor(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == ResourceType.ERROR_TOKEN) {
      // If a 401 response is received, refresh the access token
      await FirebaseService().refreshToken();
      final accessToken = await AppShared.getAccessToken() ?? '';
      if (accessToken.isNotEmpty) {
        // Update the request header with the new access token
        options.headers[KEY_AUTH] = accessToken;

        // Repeat the request with the updated header
        return handler.resolve(await fetch(error.requestOptions));
      } else {
        AppGlobals.setSessionExpired(true);
      }
    }
    return handler.next(error);
  }
}
