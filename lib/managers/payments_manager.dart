import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_shared.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaymentsManager {
  static Future<void> initialize() async {
    await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.info);
    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      debugPrint('[PaymentsManager] addCustomerInfoUpdateListener');
    });

    final String purchaseKey =
        Platform.isAndroid ? AppConstants.PURCHASE_ANDROID_KEY : AppConstants.PURCHASE_IOS_KEY;
    final PurchasesConfiguration configuration = PurchasesConfiguration(purchaseKey);
    await Purchases.configure(configuration).then((value) {
      AppShared.watchUserID().listen((userId) async {
        if (userId != null) {
          Purchases.logIn(userId.toString()).then((value) {
            print(value.created);
          }).catchError((error) {
            print(error);
          });
        } else if (!(await Purchases.isAnonymous)) {
          Purchases.logOut().then((value) {
            print(value.toJson());
          }).catchError((error) {
            print(error);
          });
        }
      });
    }).catchError((error) {
      if (error is PlatformException) {
        print(error.message);
      }
    });
  }

  String getProductIdByNumberOfUsers(int number) => 'add_${number}_user${number == 1 ? '' : 's'}';

  int getNumberOfUsers(String productId) {
    if (productId.isNotEmpty && productId.contains('add_')) {
      return int.tryParse(productId.replaceAll('add_', '').split('_').first) ?? 0;
    }
    return 0;
  }

  Future<List<StoreProduct>> getProducts() {
    final List<String> productIdentifiers = List.generate(
      30,
      (index) => getProductIdByNumberOfUsers(index + 1),
    ).toList();
    return Purchases.getProducts(productIdentifiers).then((value) {
      value.sort((a, b) => a.price.compareTo(b.price));
      return value;
    });
  }

  Future<StoreProduct?> getProductByNumberOfUsers(int number) {
    final String purchaseId = getProductIdByNumberOfUsers(number);
    return getProductByPurchaseId(purchaseId);
  }

  Future<StoreProduct?> getProductByPurchaseId(String purchaseId) {
    return Purchases.getProducts([purchaseId]).then((value) => value.lastOrNull);
  }

  Future<bool> makePurchase(StoreProduct product) async {
    try {
      final String oldProductId = await getPurchasedProductId();
      final String newProductId = product.defaultOption?.productId ?? '';

      GoogleProductChangeInfo? changeInfo;
      if (oldProductId.isNotEmpty && oldProductId != newProductId) {
        changeInfo = GoogleProductChangeInfo(oldProductId);
      }

      final CustomerInfo customerInfo = await Purchases.purchaseStoreProduct(
        product,
        googleProductChangeInfo: changeInfo,
      );
      return customerInfo.entitlements.active[newProductId]?.isActive ?? false;
    } on PlatformException catch (e) {
      final PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        print(e.message ?? e.toString());
      }
      return false;
    }
  }

  Future<String> getPurchasedProductId() {
    return Purchases.getCustomerInfo().then((customerInfo) {
      return customerInfo.entitlements.active.entries.map((key) => key.key).firstOrNull ?? '';
    });
  }

  Future<bool> checkPurchased(BuildContext context, int currentUsers) async {
    if (currentUsers >= AppConstants.LIMIT_MEMBERS) {
      final bool needSubscription;
      final int nextNumberOfUsers = currentUsers + 1;
      final String purchasedProductId = await getPurchasedProductId();
      if (purchasedProductId.isNotEmpty) {
        final int numberOfUsers = getNumberOfUsers(purchasedProductId);
        needSubscription = numberOfUsers < nextNumberOfUsers;
      } else {
        needSubscription = true;
      }
      if (needSubscription) {
        final String productId = getProductIdByNumberOfUsers(nextNumberOfUsers);
        return Navigator.pushNamed(
          context,
          Routers.SUBSCRIPTION,
          arguments: productId,
        ).then((value) => value is bool ? value : false);
      }
    }
    return true;
  }

  Future<StoreProduct?> getNextProduct() {
    return getPurchasedProductId().then((productId) {
      if (productId.isNotEmpty) {
        final int numberOfUsers = getNumberOfUsers(productId);
        final int nextNumberOfUsers = numberOfUsers + 1;
        final String nextProductId = getProductIdByNumberOfUsers(nextNumberOfUsers);
        return getProductByPurchaseId(nextProductId);
      }
      return null;
    });
  }
}
