import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/profile/profile_model.dart';

abstract class ProfileState extends Equatable {
  @override  
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final DataProfile dataProfile;

  ProfileLoaded(this.dataProfile);

  @override  
  List<Object> get props => [dataProfile];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override 

  List<Object> get props => [message];
}