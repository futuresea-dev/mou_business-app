import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mou_business_app/utils/app_colors.dart';

class InputTextField extends StatelessWidget {
  final FocusNode? initFocusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final TextInputType inputType;
  final String hintText;
  final TextInputAction textInputAction;
  final bool autoValidate;
  final double fontSize;
  final EdgeInsets? contentPadding;
  final List<TextInputFormatter> inputFormatters;
  final bool isReadOnly;
  final bool isDense;
  final void Function(String?)? onSubmitted;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final bool enableInteractiveSelection;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  InputTextField({
    Key? key,
    this.initFocusNode,
    this.nextFocusNode,
    this.controller,
    this.validation,
    this.inputType = TextInputType.text,
    this.hintText = "",
    this.textInputAction = TextInputAction.done,
    this.autoValidate = false,
    this.fontSize = 16,
    this.inputFormatters = const [],
    this.contentPadding,
    this.isReadOnly = false,
    this.isDense = false,
    this.onSubmitted,
    this.onSaved,
    this.onChanged,
    this.enableInteractiveSelection = true,
    this.suffixIcon,
    this.prefixIcon,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation,
      focusNode: initFocusNode,
      controller: controller,
      keyboardType: inputType,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      autovalidateMode:
          autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      style: textStyle ?? TextStyle(color: AppColors.normal,fontSize: 14),
      readOnly: isReadOnly,
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: this.isDense,
        hintText: hintText,
        hintStyle:
            TextStyle(color: AppColors.textPlaceHolder, fontSize: 14),
        border: InputBorder.none,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      enableInteractiveSelection: enableInteractiveSelection,
      onFieldSubmitted: (text) {
        if (initFocusNode != null) initFocusNode?.unfocus();
        if (this.onSubmitted != null) {
          this.onSubmitted!(text);
        }
        if (nextFocusNode == null) return;
        if (textInputAction == TextInputAction.next) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
    );
  }
}
