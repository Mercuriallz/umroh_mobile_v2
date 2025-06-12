import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/regional-manager/model/list_data_jemaah_kepdes_provinsi_model.dart';

abstract class ListJemaahKepdesProvinsiState extends Equatable{
  @override  

  List<Object> get props => [];
}

class ListJemaahKepdesProvinsiInitial extends ListJemaahKepdesProvinsiState{}

class ListJemaahKepdesProvinsiLoading extends ListJemaahKepdesProvinsiState{}

class ListJemaahKepdesProvinsiLoaded extends ListJemaahKepdesProvinsiState{
  final DataJemaahKepdesProvinsi dataJemaahKepdesProvinsi;

  ListJemaahKepdesProvinsiLoaded( this.dataJemaahKepdesProvinsi);

  @override
  List<Object> get props => [dataJemaahKepdesProvinsi];
}

class ListJemaahKepdesProvinsiError extends ListJemaahKepdesProvinsiState{
  final String message; 

  ListJemaahKepdesProvinsiError(this.message);

  @override
  List<Object> get props => [message];
}