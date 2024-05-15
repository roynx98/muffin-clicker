import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_cubit.dart';
import 'package:muffin_clicker/clicker/views/clicker_game.dart';
import 'package:muffin_clicker/clicker/views/skins_button.dart';
import 'package:muffin_clicker/mutiplier/cubit/multiplier_cubit.dart';
import 'package:muffin_clicker/mutiplier/views/multiplier_button.dart';
import 'package:muffin_clicker/shared_widgets/status_bar.dart';
import 'package:muffin_clicker/skins/cubit/selected_skin_cubit.dart';
import 'package:muffin_clicker/skins/cubit/skins_cubit.dart';
import 'package:muffin_clicker/upgrades/view/upgrades_bar.dart';

class ClickerPage extends StatelessWidget {
  const ClickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ClickerCubit()),
          BlocProvider(create: (context) => SelectedSkinCubit()),
          BlocProvider(create: (context) => SkinsCubit()),
          BlocProvider(create: (context) => MultiplierCubit()),
        ],
        child: Stack(
          children: [
            const ClickerGame(),
            Column(
              children: [
                StatusBar(
                  onPressSettings: () {},
                ),
                const _Actions(),
                const Spacer(),
                const SafeArea(child: UpgradesBar()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    const gap = 10.0;

    return const Padding(
      padding: EdgeInsets.only(top: gap, left: gap, right: gap),
      child: Row(
        children: [
          SkinsButton(),
          SizedBox(width: gap),
          MultiplierButton(),
        ],
      ),
    );
  }

}
