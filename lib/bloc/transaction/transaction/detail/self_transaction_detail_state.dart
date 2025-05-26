import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/model/transaction/self_transaction_detail_model.dart';

abstract class SelfTransactionDetailState extends Equatable {
  @override
  List<Object> get props => [];
}
class SelfTransactionDetailInitial extends SelfTransactionDetailState {}

class SelfTransactionDetailLoading extends SelfTransactionDetailState {}

class SelfTransactionDetailLoaded extends SelfTransactionDetailState {
  final List<DataTransaction> dataTransaction;
  final DataPay dataPay;
  final TPaket dataPaket;

  SelfTransactionDetailLoaded(this.dataTransaction, this.dataPay, this.dataPaket);

  @override
  List<Object> get props => [dataTransaction, dataPay, dataPaket];
}

class SelfTransactionDetailError extends SelfTransactionDetailState {
  final String message;

  SelfTransactionDetailError(this.message);

  @override
  List<Object> get props => [message];
}