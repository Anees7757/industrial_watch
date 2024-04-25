import 'dart:math' as math;

import 'package:flutter/material.dart';

class SemicirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    double radius = size.width / 1.9;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, -55), radius: radius),
      0,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
