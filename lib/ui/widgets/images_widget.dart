import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/creator.dart';
import 'package:mou_business_app/utils/app_images.dart';

class ImagesWidget extends StatelessWidget {
  final List<Creator> users;

  const ImagesWidget({Key? key, this.users = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: _buildImages(constraints.maxWidth),
      ),
    );
  }

  List<Widget> _buildImages(double widthParent) {
    final length = users.length;
    final maxSize = min(6, length);
    final images = List.generate(
      maxSize,
      (index) => _buildImage(widthParent: widthParent, index: index),
    );
    if (length > maxSize) {
      images.add(_buildButtonAdd());
    }
    return images;
  }

  Widget _buildButtonAdd() {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0),
      child: Image.asset(
        AppImages.icAdd,
        height: 12,
        width: 12,
        color: Color(0xff939597),
      ),
    );
  }

  Widget _buildImage({required double widthParent, required int index}) {
    final width = (widthParent - 33) / 7;
    final height = width / 36 * 25;
    final avatar = users.elementAt(index).avatar;
    return Container(
      width: width + (index == 0 ? 3 : 6),
      height: height + 6,
      padding: index == 0 ? EdgeInsets.only(top: 0, right: 0, bottom: 0) : EdgeInsets.all(3),
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: avatar == null
              ? null
              : DecorationImage(
                  image: NetworkImage(avatar),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
