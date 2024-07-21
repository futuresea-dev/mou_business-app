import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/table/shops.dart';

part 'shop_dao.g.dart';

@DriftAccessor(tables: [Shops])
class ShopDao extends DatabaseAccessor<AppDatabase> with _$ShopDaoMixin {
  final AppDatabase db;

  ShopDao(this.db) : super(db);

  Future insertShops(List<Shop> elements) =>
      batch((batch) => batch.insertAll(shops, elements, mode: InsertMode.insertOrReplace));

  Stream<List<Shop>> watchAllShopsByName(String keyword) =>
      (select(shops)..where((t) => t.name.contains(keyword))).watch();

  Future deleteAll() => delete(shops).go();

  Future deleteShopById(int id) => (delete(shops)..where((shop) => shop.id.equals(id))).go();

  Future insertShop(Shop shop) => into(shops).insert(shop, mode: InsertMode.insertOrReplace);

  Future<Shop?> getShopById(int storeId) =>
      (select(shops)..where((t) => t.id.equals(storeId))).getSingleOrNull();
}
