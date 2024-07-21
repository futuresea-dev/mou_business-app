import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/app_loading.dart';
import 'package:mou_business_app/ui/widgets/contact_dialog/contact_dialog_viewmodel.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';

class ContactDialog extends StatelessWidget {
  final Contact? contactSelected;
  final Function(Contact? contact)? onCallBack;

  ContactDialog({this.contactSelected, this.onCallBack});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ContactDialogViewModel>(
      viewModel: ContactDialogViewModel(
          contactRepository: Provider.of(context), contactDao: Provider.of(context)),
      onViewModelReady: (viewModel) => viewModel..initData(contactSelected),
      builder: (context, viewModel, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: AppColors.bgColor,
            padding: EdgeInsets.only(left: 0, right: 10, top: 50),
            child: Column(
              children: <Widget>[_buildHeader(context, viewModel), _buildBody(context, viewModel)],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ContactDialogViewModel viewModel) {
    return Expanded(
      child: StreamBuilder<Map<String, List<Contact>>>(
        stream: viewModel.mapContactsSubject,
        builder: (context, snapShot) {
          final Map<String, List<Contact>>? data = snapShot.data ?? null;
          if (data == null) {
            return const AppLoadingIndicator();
          } else {
            final List<dynamic> items = [];
            for (final entry in data.entries) {
              items.add(entry.key);
              items.addAll(entry.value);
            }
            return RefreshIndicator(
              color: AppColors.normal,
              backgroundColor: Colors.white,
              onRefresh: viewModel.onRefresh,
              child: AnimationList(
                duration: AppConstants.ANIMATION_LIST_DURATION,
                reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
                padding: EdgeInsets.only(left: 30),
                children: items.map((e) => _buildItem(e, viewModel)).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ContactDialogViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 7),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              AppImages.icClose,
              height: 15,
              fit: BoxFit.cover,
              color: AppColors.normal,
            ),
          ),
        ),
        Expanded(
          child: Container(
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.bgColor,
              ),
              margin: const EdgeInsets.only(left: 10),
              child: TextField(
                style: TextStyle(fontSize: AppFontSize.textDatePicker, color: AppColors.normal),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 17),
                  hintText: allTranslations.text(AppLanguages.searchInputText),
                  suffixIcon: Icon(Icons.search),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: AppColors.textPlaceHolder,
                      width: 1.0,
                    ),
                  ),
                  hintStyle: TextStyle(
                    fontSize: AppFontSize.textQuestion,
                    color: AppColors.bgColor,
                  ),
                ),
                onChanged: viewModel.search,
              )),
        ),
        SizedBox(width: 10),
        StreamBuilder<Contact?>(
            stream: viewModel.contactSelectedSubject,
            builder: (context, snapshot) {
              return IconButton(
                onPressed: () {
                  onCallBack?.call(viewModel.contactSelected);
                  Navigator.of(context).pop();
                },
                icon: Image.asset(
                  AppImages.icAccept,
                  height: 14,
                  fit: BoxFit.cover,
                  color: snapshot.data != null ? Colors.lightGreen : null,
                ),
              );
            })
      ],
    );
  }

  Widget _buildItem(dynamic data, ContactDialogViewModel viewModel) {
    if (data is String) {
      return Text(
        data.toUpperCase(),
        style: TextStyle(
          fontSize: AppFontSize.nameList,
          color: AppColors.header,
          fontWeight: FontWeight.w500,
        ),
      );
    } else if (data is Contact) {
      return ListTile(
        contentPadding: const EdgeInsets.only(left: 0),
        onTap: () => viewModel.setContactSelected(data),
        leading: Container(
          height: 44,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: data.avatar == null
                ? null
                : DecorationImage(
                    image: NetworkImage(data.avatar ?? ""),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        title: StreamBuilder<Contact?>(
          stream: viewModel.contactSelectedSubject,
          builder: (context, snapshot) {
            final contactSelected = snapshot.data;
            return Text(
              data.name ?? "",
              style: TextStyle(
                fontSize: AppFontSize.nameList,
                color: contactSelected?.id == data.id ? AppColors.normal : AppColors.header,
                fontWeight: contactSelected?.id == data.id ? FontWeight.bold : FontWeight.normal,
              ),
            );
          },
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
