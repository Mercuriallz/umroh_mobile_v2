import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/region/provinsi_model.dart';

abstract class ProvinsiState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProvinsiInitial extends ProvinsiState {}

class ProvinsiLoading extends ProvinsiState {}

class ProvinsiLoaded extends ProvinsiState {
  final List<DataProvince> provinsi;

  ProvinsiLoaded(this.provinsi);

  @override
  List<Object> get props => [provinsi];
}

class ProvinsiError extends ProvinsiState {
  final String message;

  ProvinsiError(this.message);

  @override
  List<Object> get props => [message];
}