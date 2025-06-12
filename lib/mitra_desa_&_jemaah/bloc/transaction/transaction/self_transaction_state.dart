import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/transaction/self/self_transaction_model.dart';

abstract class SelfTransactionState extends Equatable {
  @override
  List<Object> get props => [];
}

class SelfTransactionInitial extends SelfTransactionState {}

class SelfTransactionLoading extends SelfTransactionState {}

// class SelfTransactionLoaded extends SelfTransactionState {
//   final List<DataTransaction> selfTransaction;
//   final DataPay dataPay;

//   SelfTransactionLoaded(this.selfTransaction, this.dataPay);

//   @override
//   List<Object> get props => [selfTransaction, dataPay];
// }

class SelfTransactionLoaded extends SelfTransactionState {
  final TransactionList selfTransaction;
  // final List<TransactionHistory> transactionHistory;

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
