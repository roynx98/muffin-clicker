import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint oddPaint = Paint()..color = const Color(0xFF86C6FA);
    final Paint evenPaint = Paint()..color = const Color(0xFF76B8F9);

    const numbersOfRects = 8.0;
    final rectSize = size.width / numbersOfRects;

    for (var i = 0; i < numbersOfRects; i++) {
      canvas.drawRect(
        Rect.fromPoints(
          Offset(i * rectSize, 0),
          Offset(i * rectSize + rectSize, size.height),
        ),
        i % 2 == 0 ? oddPaint : evenPaint,
      );
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => false;
}
