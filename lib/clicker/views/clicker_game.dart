import 'dart:async';
import 'dart:ui' as ui;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_cubit.dart';
import 'package:muffin_clicker/clicker/views/clicker.dart';
import 'package:muffin_clicker/clicker/views/particles_painter.dart';
import 'package:muffin_clicker/skins/cubit/selected_skin_cubit.dart';
import 'package:muffin_clicker/skins/cubit/skin_model.dart';
import 'package:muffin_clicker/skins/cubit/skins_cubit.dart';

class ClickerGame extends StatefulWidget {
  const ClickerGame({super.key});

  @override
  State<ClickerGame> createState() => _ClickerGameState();
}

class _ClickerGameState extends State<ClickerGame>
    with SingleTickerProviderStateMixin {
  List<ClickerParticle> clickerParticles = [];
  List<ScoreParticle> scoreParticles = [];
  late final Ticker _ticker;
  ui.Image? imageParticle;
  String lastImagePath = '';
  Offset lastOrigin = const Offset(0, 0);

  @override
  void initState() {
    super.initState();
    var lastTick = const Duration();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      context.read<ClickerCubit>().applyClicksPerSecond();
    });

    _ticker = createTicker((elapsed) {
      final delta = (elapsed - lastTick).inMilliseconds / 1000.0;

      final selectedImageParticle =
          context.read<SelectedSkinCubit>().state.image;
      if (lastImagePath != selectedImageParticle) {
        lastImagePath = selectedImageParticle;
        changeImageParticle(lastImagePath);
      }

      for (var particle in clickerParticles) {
        particle.update(delta);
      }
      clickerParticles.removeWhere(
          (particle) => particle.pos.dy > MediaQuery.of(context).size.height);

      for (var particle in scoreParticles) {
        particle.update(delta);
      }
      scoreParticles.removeWhere((particle) => particle.duration <= 0.0);
      lastTick = elapsed;

      final selectedSkinCubit = context.read<SelectedSkinCubit>();
      final difficulty = -(delta * 5.0) / 60;
      selectedSkinCubit.addToLevelProgress(difficulty);

      setState(() {});
    });
    _ticker.start();
  }

  Future<void> changeImageParticle(String image) async {
    final data = await rootBundle.load(image);
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
    final selectedSkinCubit = context.read<SelectedSkinCubit>();
    final selectedSkin = context.read<SelectedSkinCubit>().state;
    final clickerCubit = context.read<ClickerCubit>();
    final skinsCubit = context.read<SkinsCubit>();
    final clickIncrement =
        clickerCubit.state.multiplier * clickerCubit.state.clicksIncrement;

    return BlocListener<SelectedSkinCubit, SkinModel>(
      listenWhen: (previous, current) {
        return previous.level != current.level && previous.name == current.name;
      },
      listener: (BuildContext context, SkinModel state) {
         scoreParticles.add(ScoreParticle(
          val: '!Level Up! +${state.level}%',
          pos: lastOrigin,
          color: Colors.white,
          fontSize: 28,
          duration: 3,
        ));
        clickerCubit.applyLevelUp(state.level);

        skinsCubit.changeLevel(selectedSkin.name, state.level);
        // Play sound
      },
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: mapBackgorundIdToPainter[selectedSkin.backgroundId],
          foregroundPainter: ParticlesPainter(
            clickerParticles: clickerParticles,
            scoreParticles: scoreParticles,
            image: imageParticle,
          ),
          child: Clicker(
            onCick: (Offset origin) {
              lastOrigin = origin;
              clickerParticles.add(ClickerParticle(origin));
              scoreParticles.add(ScoreParticle(
                val: '+$clickIncrement',
                pos: origin,
              ));
              clickerCubit.incrementClicks();
              selectedSkinCubit.gainExperience();
              playSound();
            },
          ),
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
