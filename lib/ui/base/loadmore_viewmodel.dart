import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/list_response.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:rxdart/rxdart.dart';

import 'base_viewmodel.dart';

abstract class LoadMoreViewModel<DateType> extends BaseViewModel {
  final _dataSourceSubject = BehaviorSubject<List<DateType?>>();
  final loadMoreSubject = BehaviorSubject<bool>();

  int _page = AppConstants.FIRST_PAGE;
  int _totalPage = AppConstants.FIRST_PAGE;
  bool _stopLoad = false;

  setPage(int value) {
    _page = value;
  }

  setTotalPage(int value) {
    _totalPage = value;
  }

  setLoad(bool value) {
    loadMoreSubject.add(value);
  }

  bool get isLoad => loadMoreSubject.valueOrNull ?? false;

  setStopLoad(bool value) {
    _stopLoad = value;
  }

  bool onNotification(ScrollNotification scrollInfo) {
    var metrics = scrollInfo.metrics;
    if (metrics.pixels > 0 && metrics.pixels + 100 >= metrics.maxScrollExtent) {
      _onLoadResource();
    }
    return true;
  }

  void _onLoadResource() async {
    if (isLoad || _stopLoad || notHasPage()) return;
    this.setLoad(true);
    List<DateType?> currentData = _dataSourceSubject.valueOrNull ?? [];
    if (_page > AppConstants.FIRST_PAGE) {
      currentData.clear();
      _dataSourceSubject.add(currentData);
    }
    final resource = await this.onSyncResource(_page);
    if (_page > AppConstants.FIRST_PAGE && currentData.isNotEmpty) {
      currentData.removeAt(currentData.length - 1);
    }
    List<DateType> newData = resource.data?.data as List<DateType>? ?? [];
    if (newData.isNotEmpty) {
      currentData.addAll(newData);
      final lastPage = resource.data?.meta?.lastPage;
      final currentPage = resource.data?.meta?.currentPage ?? 0;
      this.setTotalPage(lastPage ?? 0);
      this.setPage(currentPage + 1);
    } else {
      this.setStopLoad(true);
    }
    if (resource.isError) showSnackBar(resource.message);

    _dataSourceSubject.add(currentData);
    this.onSyncSuccess(_page - 1);
    this.setLoad(false);
    this.setLoading(false);
  }

  void onSyncSuccess(int currentPage) {}

  Future<Resource<ListResponse<dynamic>>> onSyncResource(int page);

  Future<void> onRefresh() async {
    if (isLoad) return;
    this.setPage(AppConstants.FIRST_PAGE);
    this.setTotalPage(AppConstants.FIRST_PAGE);
    this.setLoading(true);
    this.setLoad(false);
    this.setStopLoad(false);
    _dataSourceSubject.add([]);
    this._onLoadResource();
  }

  @override
  void dispose() async {
    await _dataSourceSubject.drain();
    _dataSourceSubject.close();
    await loadMoreSubject.drain();
    loadMoreSubject.close();
    super.dispose();
  }

  bool notHasPage() => _page > _totalPage;
}
