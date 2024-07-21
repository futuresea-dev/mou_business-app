import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/store/components/list_stores.dart';
import 'package:mou_business_app/ui/store/components/store_header.dart';
import 'package:mou_business_app/ui/store/components/widget_add_store.dart';
import 'package:mou_business_app/ui/store/store_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool isAdd = false;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<StoreViewModel>(
      viewModel: StoreViewModel(Provider.of(context)),
      onViewModelReady: (viewModel) => viewModel..initData(),
      builder: (context, viewModel, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: viewModel.scaffoldKey,
          backgroundColor: Colors.white,
          body: AppBody(
            child: StreamBuilder<bool>(
              stream: viewModel.loadingSubject.stream,
              builder: (context, snapShot) {
                bool isLoading = snapShot.data ?? false;
                return LoadingFullScreen(
                  loading: isLoading,
                  child: AppContent(
                    headerBuilder: (_) => const StoreHeader(),
                    childBuilder: (hasInternet) => SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListStores(viewModel: viewModel, hasInternet: hasInternet),
                          if (hasInternet) ...[
                            const SizedBox(height: 34),
                            StreamBuilder<Shop?>(
                              stream: viewModel.selectedStoreSubject,
                              builder: (context, snapshot) {
                                Shop? store = snapshot.data;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  child: WidgetAddStore(
                                    store: store,
                                    onCancel: () => viewModel.selectedStoreSubject.add(null),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 100),
                          ],
                        ],
                      ),
                    ),
                    menuBar: const AppMenuBar(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
