import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class StoreInput extends StatelessWidget {
  final VoidCallback? onTap;
  final String name;

  const StoreInput({super.key, this.onTap, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 40,
            child: name.isNotEmpty
                ? Lottie.asset(AppImages.animStore,
                    width: 21, repeat: false
                    //repeat: false,
                    )
                : Image.asset(
                    AppImages.icStore,
                    height: 21,
                    fit: BoxFit.cover,
                  ),
          ),
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Container(
                child: Text(
                  name.isEmpty ? allTranslations.text(AppLanguages.shop) : name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: name == ""
                          ? AppColors.textPlaceHolder
                          : AppColors.normal),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
