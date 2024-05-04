import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_cubit.dart';
import 'package:muffin_clicker/clicker/views/clicker_game.dart';
import 'package:muffin_clicker/shared_widgets/ad_loader.dart';
import 'package:muffin_clicker/shared_widgets/ink_well_container.dart';
import 'package:muffin_clicker/shared_widgets/status_bar.dart';
import 'package:muffin_clicker/skins/cubit/selected_skin_cubit.dart';
import 'package:muffin_clicker/skins/cubit/skins_cubit.dart';
import 'package:muffin_clicker/skins/views/skins_page.dart';

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
        ],
        child: Stack(
          children: [
            const ClickerGame(),
            Column(
              children: [
                StatusBar(
                  onPressSettings: () {

                  },
                ),
                const _Actions(),
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
      fontSize: 15,
      shadows: shadows,
    );

    return Padding(
      padding: const EdgeInsets.only(top: gap, left: gap, right: gap),
      child: Row(
        children: [
          InkWellContainer(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (a) {
                  return ProvideMyBlocs(
                    blocContext: context,
                    child: const SkinsPage(),
                  );
                }),
              );
            },
            width: 80,
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.leaderboard_rounded,
                    size: 22,
                    color: Colors.white,
                  ),
                  Text("SKINS", style: buttonTextStyle)
                ],
              ),
            ),
          ),
          const SizedBox(width: gap),
          const AdLoader(),
        ],
      ),
    );
  }
}

class ProvideMyBlocs extends StatelessWidget {
  final Widget child;
  final BuildContext blocContext;

  const ProvideMyBlocs({
    super.key,
    required this.child,
    required this.blocContext,
  });

  @override
  Widget build(BuildContext context) {
     return BlocProvider.value(
      value: blocContext.read<SelectedSkinCubit>(),
       child: BlocProvider.value(
         value: blocContext.read<ClickerCubit>(),
         child: BlocProvider.value(
          value: blocContext.read<SkinsCubit>(),
          child: child,
             ),
       ),
     );
  }

}
