import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';

class ParticlesPainter extends CustomPainter {
  List<ClickerParticle> clickerParticles;
  List<ScoreParticle> scoreParticles;
  int clickIncrement;
  ui.Image? image;

  ParticlesPainter({
    required this.clickerParticles,
    required this.scoreParticles,
    required this.clickIncrement,
    this.image,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size / 2;
    final paint = Paint()..color = Colors.white.withOpacity(0.6);

    for (var particle in clickerParticles) {
      canvas.save();
      canvas.translate(particle.pos.dx, particle.pos.dy);
      canvas.rotate(particle.getAngle());
      canvas.translate(-particle.pos.dx, -particle.pos.dy);
      if (image != null) {
        canvas.drawImage(
          image!,
          Offset(particle.pos.dx - image!.width / 2,
              particle.pos.dy - image!.height / 2),
          paint,
        );
      }
      canvas.restore();
    }

    for (var particle in scoreParticles) {
      final paragraphStyle = ui.ParagraphStyle(
        textDirection: TextDirection.ltr,
      );

      final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
        ..pushStyle(ui.TextStyle(
          color: Colors.white.withOpacity(particle.opacity),
          fontSize: 25.0,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(particle.opacity),
              offset: const Offset(2, 2),
              blurRadius: 2,
            ),
          ],
        ))
        ..addText('+$clickIncrement');

      final constraints = ui.ParagraphConstraints(width: 300.0);
      final paragraph = paragraphBuilder.build();
      paragraph.layout(constraints);

      canvas.drawParagraph(paragraph, particle.pos);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ScoreParticle {
  Offset pos;
  double opacity = 1.0;
  late Offset vel;

  ScoreParticle(this.pos) {
    vel = const Offset(0, -100);
    var rng = Random();
    final offset = (-20 * rng.nextDouble() - 10);
    pos = pos.translate(offset, 0);
  }

  void update(double delta) {
    pos += vel * delta;
    opacity -= delta ;
  }
}

class ClickerParticle {
  final double scale = 10;
  Offset pos;
  late Offset vel;
  late Offset gravity;

  ClickerParticle(this.pos) {
    var rng = Random();
    vel = Offset((rng.nextBool() ? 1 : -1) * (10 * rng.nextDouble() + 10),
        -100 * rng.nextDouble() - 50);
    gravity = const Offset(0, 250.0);

    vel *= scale;
    gravity *= scale;
  }

  void update(double delta) {
    pos += vel * delta;
    vel += gravity * delta;
  }

  double getAngle() {
    var angle = atan2(vel.dy, vel.dy);
    if (angle < 0) {
      angle += 2 * pi;
    }
    return vel.direction + pi / 2;
  }
}
