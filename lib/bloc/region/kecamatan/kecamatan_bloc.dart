import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/region/kecamatan/kecamatan_state.dart';
import 'package:mobile_umroh_v2/model/region/kecamatan_model.dart';
import 'package:mobile_umroh_v2/repository/region/kecamatan_repo.dart';

class KecamatanBloc extends Cubit<KecamatanState> {
  KecamatanBloc() : super(KecamatanInitial());

  void getKecamatan(String id) async {
    var response = await KecamatanRepository().loadKecamatan(id);
    var kecamatanData = KecamatanModel.fromJson(response.data).data;
    emit(KecamatanLoaded(kecamatanData!));
  }
}