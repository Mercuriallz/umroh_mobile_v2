import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/package/package_model_by_id.dart';

abstract class PackageIdState extends Equatable {
  @override
  List<Object> get props => [];
}

class PackageIdInitial extends PackageIdState {}

class PackageIdLoading extends PackageIdState {}

class PackageLoadedById extends PackageIdState {
  final DataPackageById packageId;

  PackageLoadedById(this.packageId);

  @override
  List<Object> get props => [packageId];
}

class PackageIdError extends PackageIdState {
  final String message;

  PackageIdError(this.message);

  @override
  List<Object> get props => [message];
}