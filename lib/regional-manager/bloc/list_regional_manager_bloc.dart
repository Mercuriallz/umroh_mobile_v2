import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/regional-manager/bloc/list_regional_manager_state.dart';
import 'package:mobile_umroh_v2/regional-manager/model/list_regional_manager_model.dart';
import 'package:mobile_umroh_v2/regional-manager/regional-manager-repo/list_regional_manager_repo.dart';

class ListRegionalManagerBloc extends Cubit<ListRegionalManagerState> {
  ListRegionalManagerBloc() : super(ListRegionalManagerInitial());

  void getListRegionalManager() async {
    emit(ListRegionalManagerLoading());

    final response = await ListRegionalManagerRepo().loadListRegionalManager();
    try {
      if (response.statusCode == 200) {
        var listRegionalManagerData = ListRegionalManagerModel.fromJson(response.data).data!;
        emit(ListRegionalManagerLoaded(listRegionalManagerData));
      } else {
        emit(ListRegionalManagerError("Failed to load list regional manager"));
      }
    } catch (e) {
      emit(ListRegionalManagerError("Error: $e"));
    }
  }
}
