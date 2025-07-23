import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/home_feature/model/alquran/alquran_model.dart';

abstract class AlquranState extends Equatable {
  @override 

  List<Object?> get props => [];
}

class AlquranInitial extends AlquranState {}

class AlquranLoading extends AlquranState {}

class AlquranLoaded extends AlquranState {
  final List<AlquranModel> alquran;

  AlquranLoaded(this.alquran);

  @override
  List<Object?> get props => [alquran];
}

class AlquranError extends AlquranState {
  final String message;

  AlquranError(this.message);

  @override
  List<Object?> get props => [message];
}