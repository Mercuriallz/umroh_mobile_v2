import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/regional-manager/bloc/list-jemaah-kepdes-provinsi/list_jemaah_kepdes_provinsi_state.dart';
import 'package:mobile_umroh_v2/regional-manager/model/list_data_jemaah_kepdes_provinsi_model.dart';
import 'package:mobile_umroh_v2/regional-manager/regional-manager-repo/list_jemaah_kepdes_provinsi_repo.dart';

class ListJemaahKepdesProvinsiBloc
    extends Cubit<ListJemaahKepdesProvinsiState> {
  ListJemaahKepdesProvinsiBloc() : super(ListJemaahKepdesProvinsiInitial());

  void getListJemaahKepdesProvinsi(String id) async {
    final response =
        await ListJemaahKepdesProvinsiRepo().loadListJemaahKepdesProvinsi(id);
    try {
      if (response.statusCode == 200) {
        var data =
            ListDataJemaahKepdesProvinsiModel.fromJson(response.data).data!;
        emit(ListJemaahKepdesProvinsiLoaded(data));
      } else {
        emit(ListJemaahKepdesProvinsiError(
            "Failed to load list jemaah kepdes provinsi"));
      }
    } catch (err) {
      emit(ListJemaahKepdesProvinsiError(err.toString()));
    }
  }
}
