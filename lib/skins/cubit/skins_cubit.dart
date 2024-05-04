
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muffin_clicker/skins/cubit/skin_model.dart';

class SkinsCubit extends HydratedCubit<List<SkinModel>> {
  SkinsCubit() : super(skins);

  @override
  List<SkinModel> fromJson(Map<String, dynamic> json) {
      final skins = json['skins'] as List<dynamic>;
      return skins.map((e) => SkinModel.fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson(List<SkinModel> state) {
    return {'skins': state.map((e) => e.toJson()).toList()};
  }

}
