import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package/package_state.dart';
import 'package:mobile_umroh_v2/model/package/package_model.dart';
import 'package:mobile_umroh_v2/repository/package/package_repo.dart';

class PackageBloc extends Cubit<PackageState> {
  PackageBloc() : super(PackageInitial());

  void getPackage() async {
    try {
      final response = await PackageRepository().loadPackage();
      if (response.statusCode == 200) {
        var packageData = PackageModel.fromJson(response.data).data!;
        emit(PackageLoaded(packageData));
      } else {
        var packageMessage = PackageModel.fromJson(response.data).message!;
        emit(PackageError(packageMessage));
      }
    } catch (e) {
      emit(PackageError("Error: $e"));
    }
  }

  
}
