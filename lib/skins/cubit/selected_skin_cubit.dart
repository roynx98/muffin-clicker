import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muffin_clicker/skins/cubit/skin_model.dart';

class SelectedSkinCubit extends HydratedCubit<SkinModel> {
  SelectedSkinCubit() : super(defaultSkin);

  setSelected(SkinModel model) {
    emit(model);
  }

  gainExperience() {
    final delta = 1.0 / (10.0 * (1 + state.level.toDouble() * 0.2));
    addToLevelProgress(delta);
  }

  addToLevelProgress(double delta) {
    var nextLevelProgress = state.levelProgress + delta;
    var nextLevel = state.level;

    if (nextLevelProgress < 0) {
      nextLevelProgress = 0;
    } else if (nextLevelProgress > 1) {
      nextLevelProgress = 0;
      nextLevel = nextLevel + 1;
    }

    emit(state.copyWith(
      levelProgress: nextLevelProgress,
      level: nextLevel,
    ));
  }

  @override
  SkinModel fromJson(Map<String, dynamic> json) {
    return SkinModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(SkinModel state) {
    return state.toJson();
  }
}
