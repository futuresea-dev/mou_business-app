import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/ui/widgets/app_loading.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';

typedef DataRequester<T> = Future<List<T>> Function(int offset);
typedef InitRequester<T> = Future<List<T>> Function();
typedef ItemBuilder<T> = Widget Function(List<T> data, BuildContext context, int index);

class PaginationListView<T> extends StatefulWidget {
  final ItemBuilder itemBuilder;
  final List<T> initLocalData;
  final DataRequester<T> dataRequester;
  final InitRequester<T> initRequester;
  final String emptyLabel;
  final EdgeInsetsGeometry? padding;
  final Widget? widgetLoading;
  final int limit;
  final VoidCallback? onScrollUpToClose;

  const PaginationListView({
    super.key,
    required this.itemBuilder,
    required this.dataRequester,
    required this.initRequester,
    this.initLocalData = const [],
    this.padding,
    this.emptyLabel = 'No Data',
    this.widgetLoading,
    this.limit = 10,
    this.onScrollUpToClose,
  });

  @override
  State createState() => PaginationListViewState<T>();
}

class PaginationListViewState<T> extends State<PaginationListView<T>> {
  final ScrollController _controller = ScrollController();
  List<T>? _dataList;
  bool _isLoading = false;
  bool _isStoppedLoadMore = false;
  bool _isClosed = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final position = _controller.position;
      final pixels = position.pixels;
      final maxScrollExtent = position.maxScrollExtent;
      if (pixels == maxScrollExtent) {
        if (_isLoading) return;
        if (_isStoppedLoadMore) {
          if (_isClosed) return;
          _isClosed = true;
          widget.onScrollUpToClose?.call();
        } else {
          _loadMore();
        }
      }
    });
    _onRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<T> dataList = _dataList ?? widget.initLocalData;
    return _dataList == null && widget.initLocalData.isEmpty
        ? widget.widgetLoading ?? const AppLoadingIndicator()
        : dataList.isNotEmpty
            ? RefreshIndicator(
                onRefresh: _onRefresh,
                child: AnimationList(
                  duration: AppConstants.ANIMATION_LIST_DURATION,
                  reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
                  controller: _controller,
                  padding: widget.padding ?? EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    ...dataList
                        .map((e) => widget.itemBuilder(dataList, context, dataList.indexOf(e)))
                        .toList(),
                    _isStoppedLoadMore ? const SizedBox() : const AppLoadingIndicator(),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: _onRefresh,
                child: Stack(
                  children: [
                    ListView(),
                    Center(
                      child: Text(
                        widget.emptyLabel,
                        style: TextStyle(color: AppColors.normal, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
  }

  Future<void> _onRefresh() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      _isStoppedLoadMore = false;
      _isClosed = false;
      _dataList = null;
    });
    final List<T> initDataList = await widget.initRequester();
    if (mounted) {
      setState(() {
        _isLoading = false;
        _dataList = initDataList;
      });
    }
  }

  Future<void> _loadMore() async {
    setState(() => _isLoading = true);
    final List<T> dataList = _dataList ?? [];
    if (dataList.length % widget.limit == 0) {
      final int currentPage = dataList.length ~/ widget.limit + 1;
      final List<T> newDataList = await widget.dataRequester(currentPage);
      if (newDataList.isNotEmpty) {
        dataList.addAll(newDataList);
        _dataList = dataList;
      } else {
        _isStoppedLoadMore = true;
      }
    } else {
      _isStoppedLoadMore = true;
    }
    _isLoading = false;
    if (mounted) setState(() {});
  }
}
