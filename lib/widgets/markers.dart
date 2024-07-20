import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_test/utils/exports.dart';

class MarkerWidget extends StatefulWidget {
  const MarkerWidget({super.key});

  @override
  State<MarkerWidget> createState() => _MarkerWidgetState();
}

class _MarkerWidgetState extends State<MarkerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _markerAnimation;

  late Timer _timer;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _markerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _timer = Timer(const Duration(milliseconds: 1000), () {
      _controller.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(15);
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _markerAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: appColors.primaryColors,
                borderRadius: const BorderRadius.only(
                  topLeft: radius,
                  topRight: radius,
                  bottomRight: radius,
                ),
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 700),
                opacity: _controller.isCompleted ? 1 : 0,
                child: const Text(
                  '6,95 mn P',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
