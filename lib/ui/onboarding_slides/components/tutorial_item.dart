import 'package:flutter/material.dart';

class TutorialItem extends StatelessWidget {
  final String asset;
  final String text;

  const TutorialItem({required this.asset, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(asset, width: 180),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              text,
              style: TextStyle(color: Color(0xFF545252), fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
