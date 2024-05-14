import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_cubit.dart';
import 'package:muffin_clicker/mutiplier/cubit/multiplier_cubit.dart';
import 'package:muffin_clicker/mutiplier/cubit/multiplier_model.dart';
import 'package:muffin_clicker/shared_widgets/ink_well_container.dart';
import 'package:muffin_clicker/skins/cubit/selected_skin_cubit.dart';

class MultiplierButton extends StatefulWidget {
  const MultiplierButton({super.key});

  @override
  State<MultiplierButton> createState() => _MultiplierButtonState();
}

class _MultiplierButtonState extends State<MultiplierButton> {
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/1712485313';
  RewardedAd? lastAddLodaded;
  bool wasRewarded = false;

  @override
  void initState() {
    super.initState();
  }

  showAd({required Function() onRewarded}) {
    return () {
      lastAddLodaded?.dispose();
      RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            lastAddLodaded = ad;
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                if (wasRewarded) {
                  onRewarded();
                }
                wasRewarded = false;
              },
            );
            ad.show(onUserEarnedReward: (ad, reward) {
              wasRewarded = true;
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ),
      );
    };
  }

  startMultiplierEffect(BuildContext context) {
    MultiplierCubit multiplierCubit = context.read<MultiplierCubit>();
    if (multiplierCubit.state.deltaTime != 0) {
      return;
    }

    ClickerCubit clickerCubit = context.read<ClickerCubit>();
    clickerCubit.setMultiplier(2);

    multiplierCubit.start();

    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      multiplierCubit.tick(10);

      if (multiplierCubit.state.deltaTime <= 0) {
        multiplierCubit.reset();
        clickerCubit.setMultiplier(1);
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const shadows = [
      Shadow(
        color: Colors.black,
        offset: Offset(2, 2),
        blurRadius: 2,
      )
    ];
    const buttonTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      shadows: shadows,
    );


    return BlocBuilder<MultiplierCubit, MultiplierModel>(
      builder: (context, multiplier) {
        final isMultiplierActive = multiplier.deltaTime != 0.0;

        return AbsorbPointer(
          absorbing: isMultiplierActive,
          child: CustomPaint(
            foregroundPainter: _TimeLeftPainter(
              time: multiplier.deltaTime.toDouble() / 1000,
              totalTime: multiplier.rewardTotalTime.toDouble() / 1000,
            ),
            child: InkWellContainer(
              onTap: showAd(
                onRewarded: () {
                  startMultiplierEffect(context);
                },
              ),
              width: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Builder(builder: (context) {
                    final selectedSkin = context.watch<SelectedSkinCubit>().state;
                    return Image.asset(
                      selectedSkin.image,
                      height: 35,
                    );
                  }),
                  const Positioned(
                    bottom: 0,
                    right: 5,
                    child: Text('2x', style: buttonTextStyle),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    lastAddLodaded?.dispose();
  }
}

class _TimeLeftPainter extends CustomPainter {
  final double time;
  final double totalTime;

  const _TimeLeftPainter({
    required this.totalTime,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.4);
    final angle = time / totalTime * 360.0;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      0,
      angle * math.pi / 180,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
