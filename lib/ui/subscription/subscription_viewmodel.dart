import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/core/repositories/employee_repository.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/managers/payments_manager.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:rxdart/rxdart.dart';

class SubscriptionViewModel extends BaseViewModel {
  final EmployeeRepository _employeeRepository;
  final EmployeeDao _employeeDao;
  final PaymentsManager _paymentsManager;
  final String? _productId;

  final productSubs = BehaviorSubject<StoreProduct?>();

  SubscriptionViewModel(
    this._employeeRepository,
    this._employeeDao,
    this._paymentsManager,
    this._productId,
  );

  Future<int> get totalMembers => _employeeDao.getLocalEmployees().then((value) => value.length);

  void fetchProducts() {
    setLoading(true);
    _paymentsManager.getProducts().then((products) async {
      if (products.isEmpty) {
        setLoading(false);
        showSnackBar(allTranslations.text(AppLanguages.notFoundProduct));
        Navigator.pop(context, false);
        return;
      }
      StoreProduct? product;
      if (_productId == null) {
        final StoreProduct? nextProduct = await _paymentsManager.getNextProduct();
        if (nextProduct == null) {
          await _employeeRepository.getEmployeeList();
          final int currentUsers = await _employeeDao.getLocalEmployees().then((e) => e.length);
          final int nextNumberOfUsers = currentUsers >= AppConstants.LIMIT_MEMBERS
              ? currentUsers + 1
              : AppConstants.LIMIT_MEMBERS + 1;
          // Get product by number of users
          product = await _paymentsManager.getProductByNumberOfUsers(nextNumberOfUsers);
        } else {
          // Set product is next product
          product = nextProduct;
        }
      } else {
        // Get product by product Id
        product = products.firstWhereOrNull((e) {
          final String productId = e.defaultOption?.productId ?? e.identifier;
          if (productId.isEmpty) return false;
          return _productId == productId || productId.contains(_productId!);
        });
      }
      setLoading(false);
      if (product != null) {
        productSubs.add(product);
      } else {
        showSnackBar(allTranslations.text(AppLanguages.notFoundProduct));
        Navigator.pop(context, false);
      }
    }).catchError((error) {
      setLoading(false);
      if (error is PlatformException) {
        showSnackBar(error.message ?? error.toString());
      } else {
        showSnackBar(error.toString());
      }
      Navigator.pop(context, false);
    });
  }

  void onPurchase() {
    setLoading(true);
    final StoreProduct? product = productSubs.valueOrNull;
    if (product != null) {
      _paymentsManager.makePurchase(product).then((isPurchased) {
        setLoading(false);
        if (isPurchased) {
          Navigator.pop(context, true);
        }
      });
    } else {
      setLoading(false);
      showSnackBar(allTranslations.text(AppLanguages.notFoundProduct));
    }
  }

  @override
  void dispose() {
    productSubs.close();
    super.dispose();
  }
}
