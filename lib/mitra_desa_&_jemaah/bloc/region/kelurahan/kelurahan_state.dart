import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/region/kelurahan_model.dart';

abstract class KelurahanState extends Equatable {
  @override
  List<Object> get props => [];
}

class KelurahanInitial extends KelurahanState {}

class KelurahanLoading extends KelurahanState {}

class KelurahanLoaded extends KelurahanState {
  final List<DataKelurahan> kelurahan;

  KelurahanLoaded(this.kelurahan);

  @override
  List<Object> get props => [kelurahan];
}

class KelurahanError extends KelurahanState {
  final String message;

  KelurahanError(this.message);

  @override
  List<Object> get props => [message];
}