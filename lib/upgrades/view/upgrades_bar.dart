import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_cubit.dart';
import 'package:muffin_clicker/shared_widgets/ink_well_container.dart';
import 'package:muffin_clicker/upgrades/cubit/upgrade_model.dart';
import 'package:muffin_clicker/upgrades/cubit/upgrades_cubit.dart';

class UpgradesBar extends StatelessWidget {
  const UpgradesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpgradesCubit(),
      child: Builder(
        builder: (context) {
          final upgrades = context.watch<UpgradesCubit>().state;
          final clicker = context.watch<ClickerCubit>().state;

          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: upgrades.length,
                itemBuilder: (context, index) {
                  return _Upgrade(upgrades[index], clicker.clicks);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Upgrade extends StatelessWidget {
  final UpgradeModel upgradeModel;
  final int availableClicks;

  const _Upgrade(
    this.upgradeModel,
    this.availableClicks,
  );

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: InkWellContainer(
        onTap: () {
          final canBuy = availableClicks >= upgradeModel.price;

          if (canBuy) {
            context.read<UpgradesCubit>().buy(upgradeModel);
            context.read<ClickerCubit>().applyUpgrade(upgradeModel);
          } else {}
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '${upgradeModel.level}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  Tooltip(
                    message: upgradeModel.description,
                    showDuration: const Duration(hours: 1),
                    triggerMode: TooltipTriggerMode.tap,
                    child: const Icon(
                      Icons.help,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      upgradeModel.iconName,
                      height: 40,
                    ),
                    Text(
                      upgradeModel.name,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Text(
                '${upgradeModel.price}',
                style: TextStyle(
                    color: availableClicks >= upgradeModel.price
                        ? Colors.green
                        : Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}
