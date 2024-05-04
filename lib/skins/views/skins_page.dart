import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_cubit.dart';
import 'package:muffin_clicker/shared_widgets/ink_well_container.dart';
import 'package:muffin_clicker/shared_widgets/status_bar.dart';
import 'package:muffin_clicker/skins/cubit/selected_skin_cubit.dart';
import 'package:muffin_clicker/skins/cubit/skin_model.dart';
import 'package:muffin_clicker/skins/cubit/skins_cubit.dart';

class SkinsPage extends StatelessWidget {
  const SkinsPage({
    super.key,
  });

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
            ],
          );
        },
      ),
    );
  }
}

class _SkinCard extends StatelessWidget {
  final SkinModel skinModel;

  const _SkinCard({required this.skinModel});

  final testStyle = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final selectedSkin = context.read<SelectedSkinCubit>().state;
    final isSelected = skinModel.name == selectedSkin.name;

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
                  child: Builder(
                    builder: (context) {
                      if (isSelected) {
                        return label('Selected');
                      }

                      if (!skinModel.isBought) {
                        return label('Buy for ${skinModel.price}');
                      }

                      return const SizedBox();
                    }
                  ),
                ),
                InkWellContainer(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                  onTap: () {
                    if (!skinModel.isBought) {
                      tryToBuy(context, skinModel);
                    }

                    select(context, skinModel);
                  },
                )
              ],
            ),
          ),
        ),
        Text(skinModel.name, style: testStyle),
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

  Padding label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        color: Colors.black.withOpacity(0.7),
        width: double.infinity,
        child: Text(text, textAlign: TextAlign.center, style: testStyle),
      ),
    );
  }
}
