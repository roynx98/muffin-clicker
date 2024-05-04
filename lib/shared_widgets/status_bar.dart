import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_cubit.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_model.dart';

class StatusBar extends StatelessWidget {
  final Function()? onPressBack;
  final Function()? onPressSettings;

  const StatusBar({
    super.key,
    this.onPressBack,
    this.onPressSettings,
  });

  @override
  Widget build(BuildContext context) {
    const shadows = [
      Shadow(
        color: Colors.black,
        offset: Offset(2, 2),
        blurRadius: 2,
      )
    ];
    const titleStyle = TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        shadows: shadows);
    const subtitleStyle = TextStyle(
      color: Colors.white,
      fontSize: 13,
      shadows: shadows,
    );
   
    return Column(
      children: [
        Container(
          color: Colors.black.withOpacity(0.7),
          width: double.infinity,
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    if (onPressBack == null) {
                      return const SizedBox(width: 48);
                    } else {
                      return IconButton(
                        color: Colors.white,
                        onPressed: onPressBack,
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      );
                    }
                  },
                ),
                Expanded(
                  child: BlocBuilder<ClickerCubit, ClickerModel>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Text("${state.clicks} muffins", style: titleStyle),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                                "${state.clicksPerSecond} muffins per second",
                                style: subtitleStyle),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Builder(
                  builder: (BuildContext context) {
                    if (onPressSettings == null) {
                      return const SizedBox(width: 48);
                    } else {
                      return IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(Icons.settings, color: Colors.white),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
