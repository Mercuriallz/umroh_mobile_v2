import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/region/provinsi/provinsi_state.dart';
import 'package:mobile_umroh_v2/model/region/provinsi_model.dart';
import 'package:mobile_umroh_v2/repository/region/provinsi_repo.dart';

class ProvinsiBloc extends Cubit<ProvinsiState> {
  ProvinsiBloc() : super(ProvinsiInitial());

  void getProvinsi() async {
    var response = await ProvinsiRepository().loadProvinsi();
    var provinsiData = ProvinceModel.fromJson(response.data).data!;
    emit(ProvinsiLoaded(provinsiData));
  }
}