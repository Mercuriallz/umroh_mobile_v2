import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/region/kelurahan/kelurahan_state.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/region/kelurahan_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/repository/region/kelurahan_repo.dart';

class KelurahanBloc extends Cubit<KelurahanState> {
  KelurahanBloc() : super(KelurahanInitial());

  void getKelurahan(String id) async {
    var response = await KelurahanRepository().loadKelurahan(id);
    var kelurahanData = KelurahanModel.fromJson(response.data).data;
    emit(KelurahanLoaded(kelurahanData!));
  }
  
}