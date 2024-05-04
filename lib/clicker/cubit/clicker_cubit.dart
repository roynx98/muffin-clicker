import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_model.dart';

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

  @override
  ClickerModel fromJson(Map<String, dynamic> json) {
    return ClickerModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ClickerModel state) {
    return state.toJson();
  }
}
