import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muffin_clicker/upgrades/cubit/upgrade_model.dart';

class UpgradesCubit extends HydratedCubit<List<UpgradeModel>> {
  UpgradesCubit() : super(initialUpgrades);

  void buy(UpgradeModel boughtUpgrade) {
    final newState = [...state];
    final updateIndex =
        newState.indexWhere((upgrade) => upgrade.name == boughtUpgrade.name);
    newState[updateIndex] = newState[updateIndex].copyWith(
      price: (boughtUpgrade.price * boughtUpgrade.priceMultiplier).floor(),
      level: boughtUpgrade.level + 1,
    );

    emit(newState);
  }
  
  @override
  List<UpgradeModel> fromJson(Map<String, dynamic> json) {
    final upgrades = json['upgrades'] as List<dynamic>;
    final list = upgrades.map((e) => UpgradeModel.fromJson(e)).toList();
    return list;
  }
  
  @override
  Map<String, dynamic>? toJson(List<UpgradeModel> state) {
    return {'upgrades': state.map((e) => e.toJson()).toList()};
  }
}
