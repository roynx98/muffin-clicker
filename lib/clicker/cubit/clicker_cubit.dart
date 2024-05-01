import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_model.dart';

class ClickerCubit extends HydratedCubit<ClickerModel> {
  ClickerCubit() : super(ClickerModel());

  void incrementClicks() {
    emit(state.copyWith(
      clicks: state.clicks + state.clicksIncrement,
    ));
  }

  // void applyUpgrade(UpgradeModel upgrade) {
  //   var newClicksIncrement = state.clicksIncrement;
  //   var newClicksPerSecond = state.clicksPerSecond;

  //   if (upgrade.name == muffinClickerUpgradeName) {
  //     newClicksIncrement *= 2;
  //   } else if (upgrade.name == autoMuffinUpgradeName) {
  //     newClicksPerSecond++;
  //   }

  //   emit(ClickerState(
  //     clicks: state.clicks - upgrade.price,
  //     clicksIncrement: newClicksIncrement,
  //     clicksPerSecond: newClicksPerSecond,
  //   ));
  // }

  void applyClicksPerSecond() {
    emit(state.copyWith(
      clicks: state.clicks + state.clicksPerSecond,
    ));
  }

  @override
  ClickerModel fromJson(Map<String, dynamic> json) {
    return ClickerModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ClickerModel state) {
    return state.toJson();
  }
}
