import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/area-manager/model/list_data_jemaah_kepdes_kabupaten.dart';

abstract class ListJemaahKepdesKabupatenState  extends Equatable {

  @override
  List<Object> get props => [];
}

class ListJemaahKepdesKabupatenInitial extends ListJemaahKepdesKabupatenState {}

class ListJemaahKepdesKabupatenLoading extends ListJemaahKepdesKabupatenState {}

class ListJemaahKepdesKabupatenLoaded extends ListJemaahKepdesKabupatenState {
  final DataListJemaahKepdesKabupaten dataListJemaahKepdesKabupaten;

  ListJemaahKepdesKabupatenLoaded( this.dataListJemaahKepdesKabupaten);

  @override
  List<Object> get props => [dataListJemaahKepdesKabupaten];
}

class ListJemaahKepdesKabupatenError extends ListJemaahKepdesKabupatenState {
  final String message;

  ListJemaahKepdesKabupatenError( this.message);

  @override
  List<Object> get props => [message];
}