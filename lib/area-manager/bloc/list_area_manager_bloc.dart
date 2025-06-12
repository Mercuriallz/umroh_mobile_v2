import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/area-manager/bloc/list_area_manager_state.dart';
import 'package:mobile_umroh_v2/area-manager/list_area_manager_repo/list_area_manager_repo.dart';
import 'package:mobile_umroh_v2/area-manager/model/list_area_manager_model.dart';


class ListAreaManagerBloc extends Cubit<ListAreaManagerState> {
  ListAreaManagerBloc() : super(ListAreaManagerInitial());

  void getListAreaManager() async {
    emit(ListAreaManagerLoading());

    final response = await ListAreaManagerRepo().loadListAreaManager();
    try {
      if (response.statusCode == 200) {
        var listRegionalManagerData = ListAreaManagerModel.fromJson(response.data).data!;
        emit(ListAreaManagerLoaded(listRegionalManagerData));
      } else {
        emit(ListAreaManagerError("Failed to load list regional manager"));
      }
    } catch (e) {
      emit(ListAreaManagerError("Error: $e"));
    }
  }
}
