import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_cubit.dart';
import 'package:muffin_clicker/shared_widgets/ink_well_container.dart';
import 'package:muffin_clicker/shared_widgets/status_bar.dart';
import 'package:muffin_clicker/skins/cubit/selected_skin_cubit.dart';
import 'package:muffin_clicker/skins/cubit/skin_model.dart';
import 'package:muffin_clicker/skins/cubit/skins_cubit.dart';
import 'package:muffin_clicker/utils/text_styles.dart';

class SkinsPage extends StatefulWidget {
  const SkinsPage({
    super.key,
  });

  @override
  State<SkinsPage> createState() => _SkinsPageState();
}

class _SkinsPageState extends State<SkinsPage> {
  BannerAd? bannerAd;
  bool isAdLoaded = false;
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  void loadAd() {
    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (BuildContext context) {
          final skinsState = context.watch<SkinsCubit>().state;
          context.watch<ClickerCubit>();
          context.watch<SelectedSkinCubit>();

          return Column(
            children: [
              StatusBar(
                onPressBack: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(0),
                  crossAxisCount: 2,
                  children: List.generate(
                    skinsState.length,
                    (index) => _SkinCard(skinModel: skinsState[index]),
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  if (bannerAd != null) {
                    return SafeArea(
                      child: SizedBox(
                        width: bannerAd!.size.width.toDouble(),
                        height: bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: bannerAd!),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd?.dispose();
  }

}

class _SkinCard extends StatelessWidget {
  final SkinModel skinModel;

  const _SkinCard({required this.skinModel});

  final textStyle = const TextStyle(color: Colors.white);
  final redTextStyle = const TextStyle(color: Colors.red);

  @override
  Widget build(BuildContext context) {
    final selectedSkin = context.read<SelectedSkinCubit>().state;
    final isSelected = skinModel.name == selectedSkin.name;
    final canBuy = context.read<ClickerCubit>().state.clicks >= skinModel.price;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                CustomPaint(
                  painter: mapBackgorundIdToPainter[skinModel.backgroundId],
                  child: Center(
                    child: Image.asset(
                      skinModel.image,
                      width: 100,
                    ),
                  ),
                ),
                Center(
                  child: Builder(builder: (context) {
                    if (isSelected) {
                      return label(text: 'Selected');
                    }

                    if (!skinModel.isBought) {
                      return label(
                        text: 'Buy for ${skinModel.price}',
                        customTextStyle: canBuy ? textStyle : redTextStyle,
                      );
                    }
                    return const SizedBox();
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Lv ${skinModel.level}',
                    style: levelLabelTextStyle,
                  ),
                ),
                InkWellContainer(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                  onTap: () {
                    if (skinModel.isBought) {
                      select(context, skinModel);
                    } else {
                      tryToBuy(context, skinModel);
                    }
                  },
                )
              ],
            ),
          ),
        ),
        Text(skinModel.name, style: textStyle),
      ],
    );
  }

  select(BuildContext context, SkinModel skinModel) {
    SelectedSkinCubit selectedSkinCubit = context.read<SelectedSkinCubit>();
    selectedSkinCubit.setSelected(skinModel);
  }

  tryToBuy(BuildContext context, SkinModel skinModel) {
    ClickerCubit clickerCubit = context.read<ClickerCubit>();
    SelectedSkinCubit selectedSkinCubit = context.read<SelectedSkinCubit>();
    SkinsCubit skinsCubit = context.read<SkinsCubit>();

    final canBuy = clickerCubit.state.clicks >= skinModel.price;
    if (!canBuy) {
      return;
    }

    selectedSkinCubit.setSelected(skinModel);
    clickerCubit.spend(skinModel.price);
    skinsCubit.unlock(skinModel.name);
  }

  Padding label({required String text, TextStyle? customTextStyle}) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        color: Colors.black.withOpacity(0.7),
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: customTextStyle ?? textStyle,
        ),
      ),
    );
  }
}
