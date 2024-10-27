import 'dart:math';

import 'package:flutter/cupertino.dart';

class PolygonPainter extends CustomPainter {
  final int sides;
  final Color color;
  final double strokeWidth;
  final double padding;

  PolygonPainter({required this.sides, required this.color, this.strokeWidth = 2.0, this.padding = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();
    final angle = (2 * pi) / sides;
    final radius = (size.width - padding * 2) / 2;

    // Apply rotation to point the triangle upwards
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-pi / 2);

    if (sides == 3) {
      canvas.translate(-3, -0);
    }

    for (int i = 0; i < sides; i++) {
      final x = radius * cos(i * angle);
      final y = radius * sin(i * angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
