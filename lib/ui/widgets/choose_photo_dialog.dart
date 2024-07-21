import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_languages.dart';

import '../../utils/app_colors.dart';

class PickerPhotoDialog extends StatelessWidget {
  final void Function(File file)? onSelected;
  final List<CropAspectRatioPreset>? presets;
  final CropAspectRatioPreset? initAspectRatio;
  final CropAspectRatio? aspectRatio;
  final bool hasCrop;

  const PickerPhotoDialog(
      {Key? key,
      this.onSelected,
      this.presets,
      this.initAspectRatio,
      this.hasCrop = true,
      this.aspectRatio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      backgroundColor: Colors.white,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            allTranslations.text(AppLanguages.choosePhoto),
            style: TextStyle(color: AppColors.normal, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        InkWell(
          onTap: _onPressedTakeAPhoto(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 48,
            alignment: Alignment.centerLeft,
            child: Text(
              allTranslations.text(AppLanguages.takeAPhoto),
              style: TextStyle(color: AppColors.normal, fontSize: 16),
            ),
          ),
        ),
        InkWell(
          onTap: _onPressedChoosePhoto(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 48,
            alignment: Alignment.centerLeft,
            child: Text(
              allTranslations.text(AppLanguages.chooseFromTheLibrary),
              style: TextStyle(color: AppColors.normal, fontSize: 16),
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 48,
            alignment: Alignment.centerLeft,
            child: Text(
              allTranslations.text(AppLanguages.cancel),
              style: TextStyle(color: AppColors.normal, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  void Function()? _onPressedTakeAPhoto(BuildContext context) {
    return () async {
      Navigator.pop(context);
      final file = (await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
      ));
      if(file != null)_onCropImage(File(file.path));
    };
  }

  void Function()? _onPressedChoosePhoto(BuildContext context) {
    return () async {
      Navigator.pop(context);
      final file =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (file == null || onSelected == null) return;
      if (hasCrop) {
        _onCropImage(File(file.path));
      } else {
        onSelected!(File(file.path));
      }
    };
  }

  _onCropImage(File file) async {
    final image = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: presets ??
          [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
      aspectRatio: aspectRatio ?? CropAspectRatio(ratioX: 1, ratioY: 0.63),
      // androidUiSettings: AndroidUiSettings(
      //     toolbarTitle: 'Cropper',
      //     toolbarColor: Colors.blue,
      //     toolbarWidgetColor: Colors.white,
      //     initAspectRatio: initAspectRatio ?? CropAspectRatioPreset.original,
      //     lockAspectRatio: false),
      // iosUiSettings: IOSUiSettings(
      //   minimumAspectRatio: 1.0,
      // ),
    );
    if (image != null) {
      onSelected!(File(image.path));
    }
  }
}
