import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/roster_check_dao.dart';
import 'package:mou_business_app/core/databases/dao/roster_dao.dart';
import 'package:mou_business_app/core/databases/dao/shop_dao.dart';
import 'package:mou_business_app/core/models/list_response.dart';
import 'package:mou_business_app/core/models/roster_response.dart';
import 'package:mou_business_app/core/network_bound_resource.dart';
import 'package:mou_business_app/core/requests/add_or_update_roster_request.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/core/services/api_service.dart';
import 'package:mou_business_app/utils/app_utils.dart';

class RosterRepository {
  final RosterDao rosterDao;
  final RosterCheckDao rosterCheckDao;
  final ShopDao shopDao;

  RosterRepository(this.rosterDao, this.rosterCheckDao, this.shopDao);

  CancelToken _cancelToken = CancelToken();

  Future<Resource<dynamic>> addRoster(AddOrUpdateRosterRequest request) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource =
        NetworkBoundResource<Map<String, dynamic>, Map<String, dynamic>>(
      createCall: () => APIService.addRoster(request, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (json) async {
        final shop = Shop.fromJson(json["store"]);
        shopDao.insertShop(shop);
        json.remove("store");
        final data = Roster.fromJson(json);
        await rosterDao.insertRoster(data);
      },
    );

    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> updateRoster(
      int rosterId, AddOrUpdateRosterRequest request) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource =
        NetworkBoundResource<Map<String, dynamic>, Map<String, dynamic>>(
      createCall: () =>
          APIService.updateRoster(rosterId, request, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (json) async {
        final shop = Shop.fromJson(json["store"]);
        shopDao.insertShop(shop);
        json.remove("store");
        final data = Roster.fromJson(json);
        final roster = data.copyWith(page: Value(0));
        await rosterDao.insertRoster(roster);
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<ListResponse<Roster>>> getListRosters(
      String date, int page) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource =
        NetworkBoundResource<ListResponse<Roster>, ListResponse<Roster>>(
      createCall: () => APIService.getListRosters(date, page, _cancelToken),
      parsedData: (json) => ListResponse<Roster>.fromJson(
          json,
          (e) => RosterResponse.fromJson(e)
              .toRoster(page: json["meta"]["current_page"] ?? 0)),
      saveCallResult: (response) async {
        List<Roster> rosters = response.data ?? [];
        if (response.meta?.currentPage == 1) {
          await rosterDao.deleteAll();
        }
        List<Shop> shops = rosters.map((e) => Shop.fromJson(e.store!)).toList();
        shopDao.insertShops(shops);
        rosterDao.insertRosters(rosters);
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<Roster>> getRosterDetail(int rosterId) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<Roster, Roster>(
      createCall: () => APIService.getRosterDetail(rosterId, _cancelToken),
      parsedData: (json) => Roster.fromJson(json),
      saveCallResult: (roster) async => await rosterDao.insertRoster(roster),
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> deleteRoster(int rosterId) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.deleteRoster(rosterId, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (data) async {
        rosterDao.deleteRosterById(rosterId);
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<Map<String, dynamic>>> checkRosterDateOfMonth(
    DateTime fromDate,
    DateTime toDate,
  ) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource =
        NetworkBoundResource<Map<String, dynamic>, Map<String, dynamic>>(
      createCall: () =>
          APIService.checkRosterDateOfMonth(fromDate, toDate, _cancelToken),
      parsedData: (json) => json as Map<String, dynamic>,
      saveCallResult: (response) async {
        response.forEach((key, value) => rosterCheckDao
            .insertRosterCheck(RosterCheck(key: key, value: value)));
      },
      loadFromDb: () async {
        Map<String, dynamic> eventChecks = {};
        int days = AppUtils.countDays(fromDate, toDate);
        for (int i = 0; i <= days; i++) {
          final rosterCheck = await rosterCheckDao
              .getRosterCheckByDate(fromDate.add(Duration(days: i)));
          if (rosterCheck != null) {
            eventChecks[rosterCheck.key] = rosterCheck.value;
          }
        }
        return eventChecks;
      },
    );
    return resource.getAsObservable();
  }

  cancel() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  Future<Shop?> getShopByIdLocal(int storeId) => shopDao.getShopById(storeId);
}
