import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/extensions/string_extension.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/calendar/calendar_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/pagination_listview.dart';
import 'package:mou_business_app/ui/widgets/widget_image_network.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class NotificationsOverlay extends StatelessWidget {
  final CalendarViewModel viewModel;
  final VoidCallback onHideOverlay;
  final double scale;
  final Widget? appBar;

  const NotificationsOverlay({
    super.key,
    required this.viewModel,
    required this.onHideOverlay,
    required this.scale,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        scale == 0 ? SizedBox() : appBar ?? const SizedBox(),
        Expanded(
          child: Transform.scale(
            alignment: Alignment.topCenter,
            scaleY: scale,
            child: CustomPaint(
              painter: _Painter(),
              child: ClipPath(
                clipper: _Clipper(),
                child: Material(
                  elevation: 0,
                  color: Colors.white,
                  child: LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      height: constraints.maxHeight * 0.8 * scale,
                      child: scale == 1
                          ? FutureBuilder<List<Notification>>(
                              future: viewModel.getLocalNotifications(),
                              builder: (context, snapshot) {
                                final List<Notification>? localNotifications = snapshot.data;
                                if (localNotifications == null) return SizedBox();
                                return PaginationListView<Notification>(
                                  emptyLabel: S.text(AppLanguages.thereIsNoNotification),
                                  padding: const EdgeInsets.only(bottom: 44),
                                  onScrollUpToClose: onHideOverlay,
                                  initLocalData: localNotifications,
                                  initRequester: () => viewModel.getNotifications(1),
                                  dataRequester: viewModel.getNotifications,
                                  itemBuilder: (data, context, index) {
                                    final Notification item = data[index];
                                    final bool isEnabled = item.routeName?.isNotEmpty ?? false;
                                    return InkWell(
                                      onTap: isEnabled
                                          ? () => viewModel.navigateNotification(item)
                                          : null,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 20,
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                                              child: WidgetImageNetwork(
                                                url: item.avatar ?? '',
                                                height: 40,
                                                width: 63,
                                                radius: 5,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                                child: Text(
                                                  item.body,
                                                  style: TextStyle(color: AppColors.textHint),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              item.timeAgo
                                                      .split(' ')
                                                      .firstWhereOrNull((e) => e.containsDigits) ??
                                                  '',
                                              style: TextStyle(color: AppColors.textHint),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(onTap: onHideOverlay, child: SizedBox(height: scale > 0 ? 100 : 0)),
      ],
    );
  }
}

Path _getPathShadow(Size size) {
  double w = size.width;
  double h = size.height;
  Path path = Path()
    ..lineTo(0, h)
    ..lineTo(w, h - 35);
  path.close();
  return path;
}

Path _getPath(Size size) {
  double w = size.width;
  double h = size.height;
  Path path = Path()
    ..lineTo(0, h)
    ..lineTo(w, h - 35)
    ..lineTo(w, 0)
    ..lineTo(0, 0);
  path.close();
  return path;
}

class _Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawShadow(_getPathShadow(size), Colors.black54, 12, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return _getPath(size);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
