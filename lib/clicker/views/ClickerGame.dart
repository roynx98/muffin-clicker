import 'dart:ui' as ui;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_cubit.dart';
import 'package:muffin_clicker/clicker/views/background_painter.dart';
import 'package:muffin_clicker/clicker/views/clicker.dart';
import 'package:muffin_clicker/clicker/views/particles_painter.dart';

class ClickerGame extends StatefulWidget {
  const ClickerGame({super.key});

  @override
  State<ClickerGame> createState() => _ClickerGameState();
}

class _ClickerGameState extends State<ClickerGame> with SingleTickerProviderStateMixin {
  List<ClickerParticle> clickerParticles = [];
  List<ScoreParticle> scoreParticles = [];
  late final Ticker _ticker;
  ui.Image? imageParticle;

  @override
  void initState() {
    super.initState();
    loadImageParticle();
    var lastTick = const Duration();
    var timer = 0.0;

    _ticker = createTicker((elapsed) {
      final delta = (elapsed - lastTick).inMilliseconds / 1000.0;

      timer += delta;

      if (timer >= 1) {
        context.read<ClickerCubit>().applyClicksPerSecond();
        timer = 0;
      }

      for (var particle in clickerParticles) {
        particle.update(delta);
      }
      clickerParticles.removeWhere(
          (particle) => particle.pos.dy > MediaQuery.of(context).size.height);

      for (var particle in scoreParticles) {
        particle.update(delta);
      }
      scoreParticles.removeWhere((particle) => particle.opacity <= 0.0);
      lastTick = elapsed;

      setState(() {});
    });
    _ticker.start();
  }

  Future<void> loadImageParticle() async {
    final data = await rootBundle.load('assets/img/muffin.png');
    final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: 50,
        targetHeight: 50);
    final frameInfo = await codec.getNextFrame();
    imageParticle = frameInfo.image;
    setState(() {});
  }

  void playSound() async {
    final player = AudioPlayer();
    player.play(AssetSource('sound/pop.mp3'));
    player.onPlayerComplete.listen((event) {
      player.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: BackgroundPainter(),
        foregroundPainter: ParticlesPainter(
          clickerParticles: clickerParticles,
          scoreParticles: scoreParticles,
          image: imageParticle,
          clickIncrement: context.read<ClickerCubit>().state.clicksIncrement
        ),
        child: Clicker(
          onCick: (Offset origin) {
            clickerParticles.add(ClickerParticle(origin));
            scoreParticles.add(ScoreParticle(origin));
            context.read<ClickerCubit>().incrementClicks();
            playSound();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _ticker.dispose();
    imageParticle?.dispose();
  }
}
