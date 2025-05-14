import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/model/payment/payment_data_model.dart';

abstract class PaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  @override
  List<Object?> get props => [];
}

class PaymentDataLoaded extends PaymentState {
  final DataModel dataModel;

  PaymentDataLoaded(this.dataModel);

  @override  
  List<Object?> get props => [dataModel];
}

class PaymentFailed extends PaymentState {
  final String message;
  PaymentFailed(this.message);

  @override
  List<Object?> get props => [message];
}
