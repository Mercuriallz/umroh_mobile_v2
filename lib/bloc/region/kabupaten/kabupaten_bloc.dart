import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/region/kabupaten/kabupaten_state.dart';
import 'package:mobile_umroh_v2/model/region/kabupaten_model.dart';
import 'package:mobile_umroh_v2/repository/region/kabupaten_repo.dart';

class KabupatenBloc extends Cubit<KabupatenState> {
  KabupatenBloc() : super(KabupatenInitial());

  void getKabupaten(String id) async {
    var response = await KabupatenRepository().loadKabupaten(id);
    var kabupatenData = KabupatenModel.fromJson(response.data).data;
    emit(KabupatenLoaded(kabupatenData!));
  }
}