import 'package:flutter/material.dart';
import 'package:mou_business_app/ui/base/loadmore_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/app_loading.dart';

class LoadMoreBuilder<DataType> extends StatelessWidget {
  final LoadMoreViewModel<DataType> viewModel;
  final Stream<List<DataType>> stream;
  final Widget Function(
    BuildContext context,
    AsyncSnapshot<List<DataType>> snapshot,
    bool isLoadMore,
  ) builder;

  const LoadMoreBuilder({
    super.key,
    required this.viewModel,
    required this.stream,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: viewModel.loadingSubject,
      builder: (context, snapshot) {
        bool loading = snapshot.data ?? true;
        return loading
            ? const AppLoadingIndicator()
            : NotificationListener(
                onNotification: viewModel.onNotification,
                child: StreamBuilder<bool>(
                  stream: viewModel.loadMoreSubject,
                  builder: (context, snapshot) {
                    bool loadMore = snapshot.data ?? false;
                    return StreamBuilder<List<DataType>>(
                      stream: stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const AppLoadingIndicator();
                        }
                        return builder(context, snapshot, loadMore);
                      },
                    );
                  },
                ),
              );
      },
    );
  }
}
