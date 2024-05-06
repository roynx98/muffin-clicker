import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_model.dart';
import 'package:muffin_clicker/upgrades/cubit/upgrade_model.dart';

class ClickerCubit extends HydratedCubit<ClickerModel> {
  ClickerCubit() : super(const ClickerModel());

  void incrementClicks() {
    emit(state.copyWith(
      clicks: state.clicks + state.clicksIncrement,
    ));
  }

  void applyClicksPerSecond() {
    emit(state.copyWith(
      clicks: state.clicks + state.clicksPerSecond,
    ));
  }

  void spend(int price) {
    emit(state.copyWith(
      clicks: state.clicks - price,
    ));
  }

  void applyUpgrade(UpgradeModel upgrade) {
    emit(state.copyWith(
      clicks: state.clicks - upgrade.price,
      clicksIncrement:
          state.clicksIncrement * upgrade.clicksIncrementMultiplier,
      clicksPerSecond: state.clicksPerSecond + upgrade.clicksPerSecondIncrement,
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
