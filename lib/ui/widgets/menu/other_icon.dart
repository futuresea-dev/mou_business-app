import 'package:flutter/material.dart';

class OtherIcon extends StatefulWidget {
  final String img;
  final VoidCallback onTap;
  final bool isEvents;

  const OtherIcon({
    super.key,
    required this.img,
    required this.onTap,
    this.isEvents = false,
  });

  @override
  State<OtherIcon> createState() => _OtherIconState();
}

class _OtherIconState extends State<OtherIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 150),
    );
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap.call,
      borderRadius: BorderRadius.circular(22),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _animationController.value,
            alignment: Alignment.center,
            child: child,
          );
        },
        child: CircleAvatar(
          radius: 23,
          backgroundColor: const Color(0xffb78f4d),
          child: Padding(
            padding: EdgeInsets.all(widget.isEvents ? 7 : 9),
            child: Image.asset(
              widget.img,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
