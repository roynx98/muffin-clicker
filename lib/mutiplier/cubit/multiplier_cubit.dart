
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muffin_clicker/mutiplier/cubit/multiplier_model.dart';

class MultiplierCubit extends HydratedCubit<MultiplierModel> {
  MultiplierCubit() : super(const MultiplierModel());

  start() {
    emit(state.copyWith(deltaTime: state.rewardTotalTime));
  }

  tick(int interval) {
    emit(state.copyWith(deltaTime: state.deltaTime - interval));
  }

  reset() {
    emit(state.copyWith(deltaTime: 0));
  }

  @override
  MultiplierModel fromJson(Map<String, dynamic> json) {
    return MultiplierModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(MultiplierModel state) {
    return state.toJson();
  }

}
