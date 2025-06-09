import 'package:equatable/equatable.dart';

abstract class UploadProfileState extends Equatable{
  @override  
  List<Object> get props => [];
}

class UploadProfileInitial extends UploadProfileState {}

class UploadProfileLoading extends UploadProfileState {}

class UploadProfileSuccess extends UploadProfileState {
  @override  
  List<Object> get props => [];
}

class UploadProfileError extends UploadProfileState {
  final String message; 

  UploadProfileError(this.message);

  @override  

  List<Object> get props => [message];


}