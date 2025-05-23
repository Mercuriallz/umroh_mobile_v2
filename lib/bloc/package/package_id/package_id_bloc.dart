import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package_id/package_id_state.dart';
import 'package:mobile_umroh_v2/model/package/package_model_by_id.dart';
import 'package:mobile_umroh_v2/repository/package/package_id_repo.dart';

class PackageIdBloc extends Cubit<PackageIdState> {
  PackageIdBloc() : super(PackageIdInitial());

  void getPackageById(String id) async {
    try {
      emit(PackageIdLoading());
      final response = await PackageIdRepo().loadPackageById(id);
      if (response.statusCode == 200) {
        var packageData = PackageModelById.fromJson(response.data).data!;
        emit(PackageLoadedById(packageData));
      } else {
        emit(PackageIdError("Failed to load package"));
      }
    } catch (e) {
      emit(PackageIdError("Error: $e"));
    }
  }
}