import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package_active/package_active_state.dart';
import 'package:mobile_umroh_v2/model/package/package_active.dart';
import 'package:mobile_umroh_v2/repository/package/package_active_repo.dart';

class PackageActiveBloc extends Cubit<PackageActiveState> {
  PackageActiveBloc() : super (PackageActiveInitial());

  void getActivePackage () async {
    final response = await PackageActiveRepository().loadActivePackage();
    try {
      if(response.statusCode == 200) {
        var packageData = PackageActiveModel.fromJson(response.data).data!;
        emit(PackageActiveLoaded(packageData));
      }
    } catch (e) {
      emit(PackageActiveError("Error: $e"));
    }
  }
}