import 'package:flutter/material.dart';

class MokuBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint oddPaint = Paint()..color = Color(0xFFA22835);
    final Paint evenPaint = Paint()..color = Color(0xFFC04356);

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
  bool shouldRepaint(MokuBackground oldDelegate) => false;
}
