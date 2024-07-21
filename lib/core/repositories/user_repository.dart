import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mou_business_app/core/models/setting.dart';
// import 'package:mou_business_app/core/models/user.dart';
import 'package:mou_business_app/core/requests/company_request.dart';
import 'package:mou_business_app/core/responses/register_response.dart';
import 'package:mou_business_app/core/services/api_service.dart';
import 'package:mou_business_app/utils/app_shared.dart';

import '../network_bound_resource.dart';
import '../resource.dart';

class UserRepository {
  CancelToken _cancelToken = CancelToken();

  Future<Resource<RegisterResponse>> updateProfileCompany(CompanyRequest companyRequest) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<RegisterResponse, RegisterResponse>(
      createCall: () => APIService.updateProfileCompany(companyRequest, _cancelToken),
      parsedData: (json) => RegisterResponse.fromJson(json),
      saveCallResult: (registerResponse) async {
        AppShared.setUser(registerResponse);
      },
    );

    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> updateSetting({String languageCode = '', bool? busyMode}) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.updateSetting(languageCode, busyMode ?? false, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (registerResponse) async {
        RegisterResponse user = await AppShared.getUser();
        if (user.settings == null) user.settings = Setting();
        if (languageCode.isNotEmpty) {
          user.settings?.languageCode = languageCode;
        }
        if (busyMode != null) {
          user.settings?.busyMode = busyMode ? 1 : 0;
        }
        await AppShared.setUser(user);
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> updateFCMToken(
      {required String fcmToken, required String deviceOS}) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.upDateFCMToken(fcmToken, deviceOS, _cancelToken),
      parsedData: (json) {
        print(json);
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> deleteFCMToken(String fcmToken) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.deleteFCMToken(fcmToken, _cancelToken),
      parsedData: (json) => json,
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> sendFeedBack({required String feedBack}) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.sendFeedBack(feedBack, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (response) async => print(response),
    );
    return resource.getAsObservable();
  }

  Future<Resource<RegisterResponse>> updateLogo(File logoFile) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<RegisterResponse, RegisterResponse>(
      createCall: () => APIService.updateLogo(logoFile, _cancelToken),
      parsedData: (json) => RegisterResponse.fromJson(json),
      saveCallResult: (registerResponse) async {
        AppShared.setUser(registerResponse);
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> deleteAccount() async {
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.deleteAccount(),
      parsedData: (json) => json,
    );
    return resource.getAsObservable();
  }

  Future<Resource<RegisterResponse>> updateWorkingDays(List<int> workingDays) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<RegisterResponse, RegisterResponse>(
      createCall: () => APIService.updateWorkingDays(workingDays, _cancelToken),
      parsedData: (json) => RegisterResponse.fromJson(json),
      saveCallResult: (registerResponse) async {
        if (registerResponse.id != null) {
          AppShared.setUserID(registerResponse.id!);
        }
        await AppShared.setUser(registerResponse);
      },
    );
    return resource.getAsObservable();
  }

  cancel() {
    if (_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }
}
