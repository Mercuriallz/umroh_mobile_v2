import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override 
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterFailed extends RegisterState {
  final String message;

  RegisterFailed(this.message);

  @override
  List<Object> get props => [message];
}