import 'package:flutter/material.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';

class WordCounterTextField extends StatefulWidget {
  const WordCounterTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.style,
    this.hintText,
    this.hintStyle,
    this.showCounter = true,
    this.maxLength = 25,
    this.onFieldSubmitted,
    this.onTap,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextStyle? style;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool showCounter;
  final int maxLength;
  final Function(String value)? onFieldSubmitted;
  final VoidCallback? onTap;

  @override
  State<WordCounterTextField> createState() => _WordCounterTextFieldState();
}

class _WordCounterTextFieldState extends State<WordCounterTextField> {
  final ValueNotifier<int> wordCounter = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    wordCounter.value = widget.controller.text.length;
  }

  @override
  void didUpdateWidget(covariant WordCounterTextField oldWidget) {
    wordCounter.value = widget.controller.text.length;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    wordCounter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            textCapitalization: TextCapitalization.sentences,
            style: widget.style ??
                TextStyle(
                  fontSize: AppFontSize.textButton,
                  fontWeight: FontWeight.normal,
                  color: AppColors.normal,
                ),
            decoration: InputDecoration(
              isDense: true,
              isCollapsed: true,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  TextStyle(
                    fontSize: AppFontSize.textButton,
                    color: AppColors.textPlaceHolder,
                  ),
            ),
            maxLength: widget.maxLength,
            buildCounter: (
              context, {
              required currentLength,
              required isFocused,
              maxLength,
            }) =>
                const SizedBox(),
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: (value) {
              wordCounter.value = value.length;
              setState(() {}); // Trigger a rebuild to update the UI.
            },
            onTap: widget.onTap?.call,
          ),
        ),
        if (widget.showCounter && widget.controller.text.isNotEmpty) ...[
          const SizedBox(width: 12),
          ValueListenableBuilder<int>(
            valueListenable: wordCounter,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  '$value/${widget.maxLength}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.header,
                  ),
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
