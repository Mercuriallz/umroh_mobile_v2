import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/model/package/package_model.dart';
import 'package:mobile_umroh_v2/model/package/package_model_by_id.dart';

abstract class PackageState extends Equatable {
  @override
  List<Object> get props => [];
}

class PackageInitial extends PackageState {}

class PackageLoading extends PackageState {}

class PackageLoaded extends PackageState {
  final List<DataPackage> package;

  PackageLoaded(this.package);

  @override
  List<Object> get props => [package];
}

class PackageLoadedById extends PackageState {
  final DataPackageById packageId;

  PackageLoadedById(this.packageId);

  @override
  List<Object> get props => [packageId];
}

class PackageError extends PackageState {
  final String message;

  PackageError(this.message);

  @override 
  List<Object> get props => [message];
}