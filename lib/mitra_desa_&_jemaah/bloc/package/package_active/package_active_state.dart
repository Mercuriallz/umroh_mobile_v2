import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/package/package_active.dart';

abstract class PackageActiveState extends Equatable {
  @override
  List<Object> get props => [];
}

class PackageActiveInitial extends PackageActiveState {}

class PackageActiveLoading extends PackageActiveState {}

class PackageActiveLoaded extends PackageActiveState { 
  final List<DataPackageActive> dataPackageActive;

  PackageActiveLoaded(this.dataPackageActive);

  @override
  List<Object> get props => [dataPackageActive];
}

class PackageActiveError extends PackageActiveState {
  final String message;
  PackageActiveError(this.message);

  @override
  List<Object> get props => [message];
}