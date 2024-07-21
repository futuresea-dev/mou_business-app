import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';

import 'contact_list_dialog_viewmodel.dart';

class ContactListDialog extends StatelessWidget {
  final List<Contact>? contactsSelected;
  final Function(List<Contact> contacts)? onCallBack;

  ContactListDialog({this.contactsSelected, this.onCallBack});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ContactListDialogViewModel>(
      viewModel: ContactListDialogViewModel(
          contactRepository: Provider.of(context), contactDao: Provider.of(context)),
      onViewModelReady: (viewModel) => viewModel..initData(contactsSelected ?? []),
      builder: (context, viewModel, child) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.only(left: 30, right: 10, top: 10),
            child: Column(
              children: <Widget>[
                this._buildHeader(context, viewModel),
                this._buildBody(context, viewModel)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ContactListDialogViewModel viewModel) {
    return Expanded(
      child: StreamBuilder<List<Contact>>(
        stream: viewModel.contactsSubject,
        builder: (context, snapShot) {
          var data = snapShot.data ?? null;
          if (data == null) {
            return Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              child: LoadingAnimationWidget.staggeredDotsWave(color: AppColors.menuBar, size: 40),
            );
          } else {
            if (data.length == 0) {
              return SizedBox();
            } else {
              return AnimationList(
                duration: AppConstants.ANIMATION_LIST_DURATION,
                reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
                children: data.map((e) => _buildItem(e, viewModel)).toList(),
              );
            }
          }
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ContactListDialogViewModel viewModel) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 35,
            color: AppColors.bgSearchContact,
            padding: const EdgeInsets.only(left: 10),
            child: TextField(
              style: TextStyle(fontSize: AppFontSize.textDatePicker),
              decoration: InputDecoration(
                  hintText: allTranslations.text(AppLanguages.searchInputText),
                  suffixIcon: Icon(Icons.search),
                  isDense: true,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      fontSize: AppFontSize.textQuestion, color: AppColors.textPlaceHolder)),
              onChanged: viewModel.search,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            this.onCallBack!(viewModel.contactsSelected ?? []);
            Navigator.of(context).pop();
          },
          icon: Image.asset(AppImages.icAccept),
        )
      ],
    );
  }

  Widget _buildItem(Contact contact, ContactListDialogViewModel viewModel) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0),
      leading: Container(
        height: 41,
        width: 65,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: contact.avatar == null
              ? null
              : DecorationImage(
                  image: NetworkImage(contact.avatar ?? ""),
                  fit: BoxFit.cover,
                ),
        ),
      ),
      title: StreamBuilder<List<Contact>>(
        stream: viewModel.contactsSelectedSubject,
        builder: (context, snapShot) {
          var name = contact.name ?? "";
          return Text(
            name,
            style: TextStyle(
                fontSize: AppFontSize.nameList,
                fontWeight: viewModel.checkSelected(contact) ? FontWeight.bold : FontWeight.normal),
          );
        },
      ),
      onTap: () {
        viewModel.setContactSelected(contact);
      },
    );
  }
}
