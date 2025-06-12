import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/transaction/payment/payment_transaction_model.dart';

abstract class PaymentTransactionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentTransactionInitial extends PaymentTransactionState {}

class PaymentTransactionLoading extends PaymentTransactionState {}

class PaymentTransactionSuccess extends PaymentTransactionState {
  final PaymentData paymentData;
  
  PaymentTransactionSuccess(this.paymentData);
  
  @override
  List<Object?> get props => [paymentData];
}

class PaymentTransactionFailed extends PaymentTransactionState {
  final String message;
  
  PaymentTransactionFailed(this.message);
  
  @override
  List<Object?> get props => [message];
}