import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/country_phone_code.dart';
import 'package:mou_business_app/helpers/common_helper.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_utils.dart';

import '../../utils/app_colors.dart';

typedef void PhoneCodeSelectedCallBack(CountryPhoneCode phoneCode);

class CountryPhoneCodeDialog extends StatefulWidget {
  final PhoneCodeSelectedCallBack phoneCodeCallBack;
  final bool isPhoneCode;
  final String title;

  CountryPhoneCodeDialog({
    required this.phoneCodeCallBack,
    required this.isPhoneCode,
    required this.title,
  });

  @override
  State<StatefulWidget> createState() => _CountryPhoneCodeDialogState();
}

class _CountryPhoneCodeDialogState extends State<CountryPhoneCodeDialog> {
  List<CountryPhoneCode> phoneCodesFilter = AppUtils.appCountryCodes;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        titlePadding: const EdgeInsets.only(left: 23, right: 10, top: 5),
        title: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  color: AppColors.normal,
                  fontFamily: AppConstants.fontQuickSand,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
                iconSize: 24,
                color: AppColors.normal,
              )
            ],
          ),
        ),
        content: Container(
          width: width,
          child: Column(
            children: <Widget>[
              _buildSearchText(),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 10),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: Colors.transparent),
                  itemCount: phoneCodesFilter.length,
                  itemBuilder: (context, index) => _buildListItem(context, phoneCodesFilter[index]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchText() {
    return TextField(
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          prefixIcon: Icon(Icons.search),
          hintText: allTranslations.text(AppLanguages.searchInputText),
          hintStyle: TextStyle(
              color: Colors.transparent,
              fontWeight: FontWeight.normal,
              fontFamily: AppConstants.fontQuickSand)),
      onChanged: (text) {
        if (text.trim().isNotEmpty) {
          final dataFilter = AppUtils.appCountryCodes
              .where((phoneCode) =>
                  phoneCode.code.toLowerCase().contains(text.toLowerCase()) ||
                  phoneCode.name.toLowerCase().contains(text.toLowerCase()))
              .toList();
          setState(() {
            phoneCodesFilter = dataFilter;
          });
        } else {
          setState(() {
            phoneCodesFilter = AppUtils.appCountryCodes;
          });
        }
      },
    );
  }

  //Build list item phone code
  ListTile _buildListItem(BuildContext context, CountryPhoneCode phoneCode) {
    return ListTile(
      onTap: () {
        widget.phoneCodeCallBack(phoneCode);
        Navigator.of(context).pop();
      },
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        CommonHelper.getFlagPath(phoneCode.code),
        fit: BoxFit.cover,
        height: 35,
      ),
      title: Text(
        phoneCode.name,
        style: TextStyle(
          color: AppColors.normal,
          fontSize: 15,
          fontWeight: FontWeight.normal,
          fontFamily: AppConstants.fontQuickSand,
        ),
      ),
    );
  }
}
