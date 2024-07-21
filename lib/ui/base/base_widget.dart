import 'package:flutter/material.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;
  final T viewModel;
  final Widget? child;
  final Function(T)? onViewModelReady;

  BaseWidget({
    Key? key,
    required this.viewModel,
    required this.builder,
    this.child,
    this.onViewModelReady,
  }) : super(key: key);

  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> {
  T? viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    if (widget.onViewModelReady != null) {
      widget.onViewModelReady!(viewModel!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => viewModel!..setContext(context),
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
