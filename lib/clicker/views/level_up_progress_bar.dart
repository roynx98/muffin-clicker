import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muffin_clicker/skins/cubit/selected_skin_cubit.dart';
import 'package:muffin_clicker/skins/cubit/skin_model.dart';

class LevelUpProgressBar extends StatefulWidget {
  const LevelUpProgressBar({super.key});

  @override
  State<LevelUpProgressBar> createState() => _LevelUpProgressBarState();
}

class _LevelUpProgressBarState extends State<LevelUpProgressBar> {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SelectedSkinCubit, SkinModel>(
      builder: (context, skin) {
        return LinearProgressIndicator(
          minHeight: 10,
          backgroundColor: Colors.black.withOpacity(0.8),
          color: Colors.blue,
          value: skin.levelProgress,
          semanticsLabel: 'Linear progress indicator',
        );
      }
    );
  }
}
