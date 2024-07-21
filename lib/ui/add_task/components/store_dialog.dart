import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/store/store_viewmodel.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StoreDialog extends StatefulWidget {
  final Function(Shop? shop)? onTap;
  final Shop? selectedShop;

  const StoreDialog({
    super.key,
    this.onTap,
    this.selectedShop,
  });

  @override
  State<StoreDialog> createState() => _StoreDialogState();
}

class _StoreDialogState extends State<StoreDialog> {
  final ValueNotifier<Shop?> selectedShop = ValueNotifier(null);
  final searchSubject = BehaviorSubject<String>.seeded('');

  @override
  void initState() {
    super.initState();
    selectedShop.value = widget.selectedShop;
  }

  @override
  void dispose() {
    selectedShop.dispose();
    searchSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<StoreViewModel>(
      viewModel: StoreViewModel(Provider.of(context)),
      onViewModelReady: (viewModel) => viewModel..initData(),
      builder: (context, viewModel, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: AppColors.bgColor,
            padding: const EdgeInsets.only(left: 30, right: 10, top: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: AppColors.textPlaceHolder, width: 1.0),
                        ),
                        child: Container(
                          height: 35,
                          color: AppColors.bgColor,
                          padding: const EdgeInsets.only(left: 17),
                          child: TextField(
                            style: TextStyle(
                              fontSize: AppFontSize.textDatePicker,
                              color: AppColors.normal,
                            ),
                            decoration: InputDecoration(
                              hintText: allTranslations.text(AppLanguages.searchInputText),
                              suffixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: AppFontSize.textQuestion,
                                color: AppColors.bgColor,
                              ),
                            ),
                            onChanged: (value) => searchSubject.add(value),
                          ),
                        ),
                      ),
                    ),
                    ValueListenableBuilder<Shop?>(
                      valueListenable: selectedShop,
                      builder: (_, shop, __) {
                        return IconButton(
                          onPressed: () {
                            widget.onTap?.call(shop);
                            Navigator.of(context).pop();
                          },
                          icon: Image.asset(
                            AppImages.icAccept,
                            height: 14,
                            width: 23.5,
                            fit: BoxFit.cover,
                            color: shop != null ? Colors.lightGreen : null,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: StreamBuilder<String>(
                    stream: searchSubject,
                    builder: (_, snapshot) {
                      return StreamBuilder<List<Shop>>(
                        stream: viewModel.watchStoresByName(snapshot.data ?? ''),
                        builder: (context, storeSnapshot) {
                          if (storeSnapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              padding: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: AppColors.menuBar, size: 40),
                            );
                          }
                          List<Shop> shops = storeSnapshot.data ?? [];
                          return ValueListenableBuilder<Shop?>(
                            valueListenable: selectedShop,
                            builder: (_, _selectedShop, __) {
                              return AnimationList(
                                duration: AppConstants.ANIMATION_LIST_DURATION,
                                reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
                                children: shops.map((shop) {
                                  bool isSelected = _selectedShop?.id == shop.id;
                                  return ListTile(
                                    contentPadding: const EdgeInsets.only(left: 0),
                                    title: Text(
                                      shop.name ?? '',
                                      style: TextStyle(
                                        color: AppColors.normal,
                                        fontSize: AppFontSize.nameList,
                                        fontWeight:
                                            isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                    onTap: () {
                                      selectedShop.value = isSelected ? null : shop;
                                    },
                                  );
                                }).toList(),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
