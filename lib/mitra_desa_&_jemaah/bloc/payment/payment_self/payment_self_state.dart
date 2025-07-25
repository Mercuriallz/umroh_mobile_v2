import 'package:equatable/equatable.dart';

abstract class PaymentSelfState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentSelfInitial extends PaymentSelfState {}

class PaymentSelfLoading extends PaymentSelfState {}

class PaymentSelfSuccess extends PaymentSelfState {
  @override
  List<Object?> get props => [];
}

class PaymentSelfFailed extends PaymentSelfState {
  final String message;
  PaymentSelfFailed(this.message);

  @override
  List<Object?> get props => [message];
}