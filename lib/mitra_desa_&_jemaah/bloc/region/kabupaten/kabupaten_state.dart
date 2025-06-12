import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/region/kabupaten_model.dart';

abstract class KabupatenState extends Equatable {
  @override
  List<Object> get props => [];
}

class KabupatenInitial extends KabupatenState {}

class KabupatenLoading extends KabupatenState {}

class KabupatenLoaded extends KabupatenState {
  final List<DataKabupaten> kabupaten;

  KabupatenLoaded(this.kabupaten);

  @override
  List<Object> get props => [kabupaten];
}

class KabupatenError extends KabupatenState {
  final String message;

  KabupatenError(this.message);

  @override
  List<Object> get props => [message];
}