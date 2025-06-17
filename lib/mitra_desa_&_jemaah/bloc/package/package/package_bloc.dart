import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/package/package/package_state.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/repository/package/package_repo.dart';

class PackageBloc extends Cubit<PackageState> {
  final PackageRepository repository;

  PackageBloc(this.repository) : super(PackageInitial());

  void getPackage() async {
    emit(PackageLoading());

    final result = await repository.loadPackage();

    result.fold(
      (l) => emit(PackageError("Failed to load package: $l")),
      (r) => emit(PackageLoaded(r.data!)),
    );
  }
}
