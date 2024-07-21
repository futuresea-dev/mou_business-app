import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/ui/store/store_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/slidable/app_slidable.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/types/slidable_action_type.dart';

class ListStores extends StatelessWidget {
  const ListStores({
    super.key,
    required this.viewModel,
    this.hasInternet = true,
  });

  final StoreViewModel viewModel;
  final bool hasInternet;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Shop>>(
      stream: viewModel.watchStoresByName(''),
      builder: (context, snapshot) {
        final List<Shop> stores = snapshot.data ?? [];
        return AnimationList(
          duration: AppConstants.ANIMATION_LIST_DURATION,
          reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 6),
          children: stores.map((e) => _buildItem(e, context)).toList(),
        );
      },
    );
  }

  Widget _buildItem(Shop store, BuildContext context) {
    return AppSlidable<SlidableActionType>(
      key: ValueKey(store.id),
      enabled: hasInternet,
      actions: [
        SlidableActionType.EDIT,
        SlidableActionType.DELETE,
      ],
      onActionPressed: (type) {
        return switch (type) {
          SlidableActionType.EXPORT => null,
          SlidableActionType.EDIT => viewModel.onSelectStoreToEdit(store),
          SlidableActionType.DELETE => viewModel.deleteStore(store.id),
          SlidableActionType.ACCEPT => null,
          SlidableActionType.DENY => null,
        };
      },
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          store.name ?? '',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.normal,
          ),
        ),
      ),
    );
  }
}
