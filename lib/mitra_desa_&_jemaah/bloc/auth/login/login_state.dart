import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState{}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginChief extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);

  @override
  List<Object?> get props => [];
}
