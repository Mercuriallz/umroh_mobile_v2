import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package_state.dart';
import 'package:mobile_umroh_v2/model/package/package_model.dart';
import 'package:mobile_umroh_v2/repository/package/package_repo.dart';

class PackageBloc extends Cubit<PackageState> {
  PackageBloc() : super(PackageInitial());

 void getPackage() async {
  emit(PackageLoading());
  try {
    final response = await PackageRepository().loadPackage();
    if (response.statusCode == 200) {
      var packageData = PackageModel.fromJson(response.data).data!;
      emit(PackageLoaded(packageData));
    } else {
      emit(PackageError("Failed to load package"));
    }
  } catch (e) {
    emit(PackageError("Error: $e"));
  }
}

  void getPackageById(String id) async {
    final response = await PackageRepository().loadPackageById(id);
    var packageData = PackageModel.fromJson(response.data).data!;
    emit(PackageLoaded(packageData));
  }
}
