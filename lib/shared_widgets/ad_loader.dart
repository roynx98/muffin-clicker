
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muffin_clicker/shared_widgets/ink_well_container.dart';

class AdLoader extends StatefulWidget {
  const AdLoader({super.key});

  @override
  State<AdLoader> createState() => _AdLoaderState();
}

class _AdLoaderState extends State<AdLoader> {
  InterstitialAd? _interstitialAd;
  final adUnitId = Platform.isAndroid
    ? 'ca-app-pub-3940256099942544/1033173712'
    : 'ca-app-pub-3940256099942544/4411468910';

  @override
  void initState() {
    loadAd();
  }

  void loadAd() {
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
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
      shadows: shadows
    );

    return InkWellContainer(
      onTap: () {
        _interstitialAd?.show();
      },
      width: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/img/chocolateMuffin.png',
            height: 35,
          ),
          Positioned(
            bottom: 0,
            right: 5,
            child: Text("2x", style: buttonTextStyle),
          ),
        ],
      ),
    );
  }
}
