import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mou_business_app/helpers/translations.dart';

class ContactField extends StatelessWidget {
  final void Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? icon;
  final String? pathIcon;
  final String? keyHint;
  final FocusNode? initFocusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final void Function(String?)? onSaved;

  const ContactField(
      {Key? key,
      this.onTap,
      this.controller,
      this.validator,
      this.pathIcon,
      this.keyHint,
      this.initFocusNode,
      this.nextFocusNode,
      this.textInputAction,
      this.keyboardType,
      this.inputFormatters,
      this.readOnly = false,
      this.onSaved,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      validator: validator,
      focusNode: initFocusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        icon: icon == null
            ? (pathIcon == null
                ? null
                : Image.asset(
                    pathIcon ?? "",
                    width: 32,
                    height: 28,
                    fit: BoxFit.scaleDown,
                  ))
            : icon,
        hintText: allTranslations.text(keyHint ?? ""),
        hintStyle: TextStyle(color: Color(0xffD3D3D3), fontSize: 18),
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      onFieldSubmitted: (text) {
        initFocusNode?.unfocus();
        if (textInputAction == TextInputAction.next) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      onSaved: onSaved,
    );
  }
}
