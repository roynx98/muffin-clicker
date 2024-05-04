
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muffin_clicker/skins/cubit/skin_model.dart';

class SelectedSkinCubit extends HydratedCubit<SkinModel> {
  SelectedSkinCubit() : super(defaultSkin);

  setSelected(SkinModel model) {
    emit(model);
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
