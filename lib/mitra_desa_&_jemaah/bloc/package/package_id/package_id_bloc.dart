import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/package/package_id/package_id_state.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/repository/package/package_id_repo.dart';

class PackageIdBloc extends Cubit<PackageIdState> {
  PackageIdBloc() : super(PackageIdInitial());

  void getPackageById(String id) async {
    final result = await PackageIdRepo().loadPackageById(id);
    result.fold(
        (l) => emit(PackageIdError("Failed to load package: $l")),
        (r) => emit(PackageLoadedById(r.data!)));
  }
}
