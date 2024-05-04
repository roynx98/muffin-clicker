import 'package:flutter/material.dart';

class ZombieBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint oddPaint = Paint()..color = Color.fromARGB(255, 172, 31, 219);
    final Paint evenPaint = Paint()..color = Color.fromARGB(255, 55, 25, 59);

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
  bool shouldRepaint(ZombieBackground oldDelegate) => false;
}
