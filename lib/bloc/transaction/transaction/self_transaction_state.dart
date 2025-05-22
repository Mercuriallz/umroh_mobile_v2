import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/model/transaction/self_transaction_model.dart';

abstract class SelfTransactionState extends Equatable {
  @override
  List<Object> get props => [];
}

class SelfTransactionInitial extends SelfTransactionState {}

class SelfTransactionLoading extends SelfTransactionState {}

class SelfTransactionLoaded extends SelfTransactionState {
  final List<DataTransaction> selfTransaction;

  SelfTransactionLoaded(this.selfTransaction);

  @override
  List<Object> get props => [selfTransaction];
}

class SelfTransactionError extends SelfTransactionState {
  final String message;

  SelfTransactionError(this.message);

  @override
  List<Object> get props => [message];
}