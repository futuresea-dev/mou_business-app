import 'dart:async';

import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/repositories/store_repository.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:rxdart/rxdart.dart';

class StoreViewModel extends BaseViewModel {
  final StoreRepository storeRepository;
  final selectedStoreSubject = BehaviorSubject<Shop?>();

  StoreViewModel(this.storeRepository);

  initData() async => await storeRepository.getListStores();

  Future<bool> createStore(String storeName) async {
    if (storeName.trim().isNotEmpty) {
      setLoading(true);
      final response = await storeRepository.createStore(storeName);
      setLoading(false);
      if (response.isSuccess) {
        showSnackBar(
          allTranslations.text(AppLanguages.storeAddedSuccessfully),
          isError: false,
        );
        return true;
      } else {
        showSnackBar(response.message);
      }
    } else {
      showSnackBar(allTranslations.text(AppLanguages.pleaseEnterStoreName));
    }
    return false;
  }

  void onSelectStoreToEdit(Shop store) {
    selectedStoreSubject.add(store);
  }

  Future<bool> editStore(String storeName, int storeId) async {
    if (storeName.trim().isNotEmpty) {
      setLoading(true);
      final response = await storeRepository.updateStore(storeId, storeName);
      setLoading(false);
      if (response.isSuccess) {
        showSnackBar(
          allTranslations.text(AppLanguages.storeUpdatedSuccessfully),
          isError: false,
        );
        return true;
      } else {
        showSnackBar(response.message);
      }
    } else {
      showSnackBar(allTranslations.text(AppLanguages.pleaseEnterStoreName));
    }
    return false;
  }

  FutureOr<void> deleteStore(int storeId) async {
    setLoading(true);
    final response = await storeRepository.deleteStore(storeId);
    setLoading(false);
    if (response.isSuccess) {
      showSnackBar(
        allTranslations.text(AppLanguages.storeDeletedSuccessfully),
        isError: false,
      );
    } else {
      showSnackBar(response.message);
    }
  }

  Stream<List<Shop>> watchStoresByName(String keyword) =>
      storeRepository.watchStoresByName(keyword);

  @override
  void dispose() {
    selectedStoreSubject.drain();
    selectedStoreSubject.close();
    super.dispose();
  }
}
