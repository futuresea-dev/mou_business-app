import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/store/store_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/input_text_field.dart';
import 'package:mou_business_app/ui/widgets/input_text_field_container.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';

class WidgetAddStore extends StatefulWidget {
  const WidgetAddStore({
    super.key,
    this.store,
    this.onCancel,
  });

  final Shop? store;
  final VoidCallback? onCancel;

  @override
  State<WidgetAddStore> createState() => _WidgetAddStoreState();
}

class _WidgetAddStoreState extends State<WidgetAddStore> {
  final TextEditingController nameController = TextEditingController();
  late StoreViewModel _viewModel;
  bool isAdd = false;
  final ValueNotifier<bool> isTypingName = ValueNotifier(false);
  final ValueNotifier<int> wordCounter = ValueNotifier(0);

  final _maxLength = 25;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.store?.name ?? '';
    nameController.addListener(() {
      wordCounter.value = nameController.text.length;
    });
  }

  @override
  void didUpdateWidget(covariant WidgetAddStore oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.store?.id != oldWidget.store?.id) {
      setState(() {
        isAdd = true;
      });
      nameController.text = widget.store?.name ?? '';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    isTypingName.dispose();
    wordCounter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<StoreViewModel>(
      viewModel: StoreViewModel(Provider.of(context)),
      onViewModelReady: (viewModel) => _viewModel = viewModel,
      builder: (context, _, __) {
        return Column(
          children: <Widget>[
            _buildHeader(),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.topCenter,
              child: isAdd
                  ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: InputTextFieldContainer(
                        height: 45,
                        child: Row(
                          children: [
                            Expanded(
                              child: InputTextField(
                                controller: nameController,
                                hintText: allTranslations.text(AppLanguages.storeName),
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.normal,
                                ),
                                prefixIcon: ValueListenableBuilder<bool>(
                                  valueListenable: isTypingName,
                                  builder: (_, value, __) {
                                    return value
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8),
                                            child: Lottie.asset(
                                              AppImages.animStore,
                                              fit: BoxFit.contain,
                                              repeat: false,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            child: Image.asset(
                                              AppImages.icStore,
                                              fit: BoxFit.contain,
                                            ),
                                          );
                                  },
                                ),
                                inputFormatters: [LengthLimitingTextInputFormatter(_maxLength)],
                                onSubmitted: (value) =>
                                    isTypingName.value = value?.trim().isNotEmpty ?? false,
                              ),
                            ),
                            ValueListenableBuilder<int>(
                              valueListenable: wordCounter,
                              builder: (context, value, child) {
                                return value > 0
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text(
                                          '$value/$_maxLength',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.header,
                                          ),
                                        ),
                                      )
                                    : SizedBox();
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                isAdd = !isAdd;
              });
              widget.onCancel?.call();
              isTypingName.value = false;
              nameController.clear();
            },
            child: Container(
              width: 40,
              alignment: Alignment.centerLeft,
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 350),
                turns: (isAdd ? 0 : -45) / 360,
                child: Image.asset(
                  AppImages.icClose,
                  height: 16,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedAlign(
              alignment: isAdd ? Alignment.center : Alignment.centerLeft,
              duration: const Duration(milliseconds: 350),
              child: Text(
                allTranslations.text(
                    widget.store != null && isAdd ? AppLanguages.editStore : AppLanguages.addStore),
                style: TextStyle(
                  fontSize: AppFontSize.textDatePicker,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
          if (isAdd)
            InkWell(
              onTap: () async {
                bool isSuccess = false;
                if (widget.store != null) {
                  isSuccess = await _viewModel.editStore(
                    nameController.text,
                    widget.store!.id,
                  );
                } else {
                  isSuccess = await _viewModel.createStore(nameController.text);
                }
                if (isSuccess) {
                  setState(() {
                    isAdd = !isAdd;
                  });
                  nameController.clear();
                }
              },
              child: Container(
                alignment: Alignment.centerRight,
                width: 50,
                child: Image.asset(
                  AppImages.icAccept,
                  height: 13,
                  fit: BoxFit.cover,
                ),
              ),
            )
        ],
      ),
    );
  }
}
