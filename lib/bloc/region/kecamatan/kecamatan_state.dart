import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/model/region/kecamatan_model.dart';

abstract class KecamatanState extends Equatable {
  @override
  List<Object> get props => [];
}

class KecamatanInitial extends KecamatanState {}

class KecamatanLoading extends KecamatanState {}

class KecamatanLoaded extends KecamatanState {
  final List<DataKecamatan> kecamatan;

  KecamatanLoaded(this.kecamatan);

  @override
  List<Object> get props => [kecamatan];
}

class KecamatanError extends KecamatanState {
  final String message;

  KecamatanError(this.message);

  @override
  List<Object> get props => [message];
}