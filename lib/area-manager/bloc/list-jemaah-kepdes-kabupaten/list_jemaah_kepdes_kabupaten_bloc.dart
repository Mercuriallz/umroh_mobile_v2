import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/area-manager/bloc/list-jemaah-kepdes-kabupaten/list_jemaah_kepdes_kabupaten_state.dart';
import 'package:mobile_umroh_v2/area-manager/list_area_manager_repo/list_jemaah_kepdes_kabupaten_repo.dart';
import 'package:mobile_umroh_v2/area-manager/model/list_data_jemaah_kepdes_kabupaten.dart';

class ListJemaahKepdesKabupatenBloc extends Cubit<ListJemaahKepdesKabupatenState> {
  ListJemaahKepdesKabupatenBloc() : super(ListJemaahKepdesKabupatenInitial());

  void getListJemaahKepdesKabupaten(String id) async {
    final response = await ListJemaahKepdesKabupatenRepo().loadListJemaahKepdesKabupaten(id);
    try {
      if (response.statusCode == 200) {
        var data = ListDataJemaahKepdesKabupatenModel.fromJson(response.data).data!;
        emit(ListJemaahKepdesKabupatenLoaded(data));
      } else {
        emit(ListJemaahKepdesKabupatenError("Failed to load list jemaah kepdes kabupaten"));
      }
    } catch (err) {
      emit(ListJemaahKepdesKabupatenError(err.toString()));
    }
  } 
}