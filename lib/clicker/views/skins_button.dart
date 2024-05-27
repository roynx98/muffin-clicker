import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_cubit.dart';
import 'package:muffin_clicker/mutiplier/cubit/multiplier_cubit.dart';
import 'package:muffin_clicker/shared_widgets/ink_well_container.dart';
import 'package:muffin_clicker/skins/cubit/selected_skin_cubit.dart';
import 'package:muffin_clicker/skins/cubit/skins_cubit.dart';
import 'package:muffin_clicker/skins/views/skins_page.dart';

class SkinsButton extends StatefulWidget {
  const SkinsButton({super.key});

  @override
  State<SkinsButton> createState() => _SkinsButtonState();
}

class _SkinsButtonState extends State<SkinsButton> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    animationController.stop();

    animation = Tween<double>(begin: 0, end: 0.1).animate(animationController);
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
      fontSize: 15,
      shadows: shadows,
    );

    return InkWellContainer(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<SelectedSkinCubit>(),
                ),
                BlocProvider.value(
                  value: context.read<ClickerCubit>(),
                ),
                BlocProvider.value(
                  value: context.read<SkinsCubit>(),
                ),
                BlocProvider.value(
                  value: context.read<MultiplierCubit>(),
                ),
              ],
              child: const SkinsPage(),
            );
          }),
        );
      },
      width: 80,
      child: Stack(
        children: [
          const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.leaderboard_rounded,
                  size: 22,
                  color: Colors.white,
                ),
                Text("SKINS", style: buttonTextStyle),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {  
              return Opacity(
                  opacity: animation.value,
                  child: Container(
                    color: Colors.white,
                  ),
                );
            },
          )
        ],
      ),
    );
  }
}
