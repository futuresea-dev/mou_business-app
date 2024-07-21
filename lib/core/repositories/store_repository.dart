import 'package:dio/dio.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/shop_dao.dart';
import 'package:mou_business_app/core/network_bound_resource.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/core/services/api_service.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';

class StoreRepository {
  CancelToken _cancelToken = CancelToken();

  final ShopDao shopDao;

  StoreRepository(this.shopDao);

  Future<Resource<Shop>> createStore(String name) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<Shop, Shop>(
      createCall: () => APIService.createStore(name),
      parsedData: (json) => Shop.fromJson(json),
      saveCallResult: (data) async {
        await shopDao.insertShop(data);
      },
    );

    return resource.getAsObservable();
  }

  Future<Resource<Shop>> updateStore(int id, String name) {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<Shop, Shop>(
      createCall: () => APIService.updateStore(id, name),
      parsedData: (json) => Shop.fromJson(json),
      saveCallResult: (data) async {
        await shopDao.insertShop(data);
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<String>> deleteStore(int id) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();

    final resource = NetworkBoundResource<String, String>(
      createCall: () => APIService.deleteStore(id),
      parsedData: (json) => json,
      saveCallResult: (data) async {
        await shopDao.deleteShopById(id);
      },
    );
    return resource.getAsObservable();
  }

  Future<Resource<List<Shop>>> getListStores() async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    Future<Response<dynamic>> service = APIService.getStoresBusiness();
    final resource = NetworkBoundResource<List<Shop>, List<Shop>>(
      createCall: () => service,
      parsedData: (json) {
        final data = json as List;
        return data.map((json) => Shop.fromJson(json)).toList();
      },
      saveCallResult: (response) async {
        List<Shop> shops = response;
        final newShops = shops.map((e) => e).toList();
        shopDao.insertShops(newShops);
      },
    );
    return resource.getAsObservable();
  }

  cancel() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  Stream<List<Shop>> watchStoresByName(String keyword) => shopDao.watchAllShopsByName(keyword);
}
