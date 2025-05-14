import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/model/transaction/transaction_detail_model.dart';

abstract class TransactionDetailState extends Equatable{
  @override  
  List<Object> get props => [];
}

class TransactionDetailInitial extends TransactionDetailState{}

class TransactionDetailLoading extends TransactionDetailState{}

class TransactionDetailLoaded extends TransactionDetailState{
  final DataTransactionDetail transactionDetailModel;

  TransactionDetailLoaded(this.transactionDetailModel);

  @override  
  List<Object> get props => [transactionDetailModel];
}

class TransactionDetailError extends TransactionDetailState{
  final String message;

  TransactionDetailError(this.message);

  @override  
  List<Object> get props => [message];
}