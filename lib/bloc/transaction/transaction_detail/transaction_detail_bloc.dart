import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/transaction/transaction_detail/transaction_detail_state.dart';
import 'package:mobile_umroh_v2/model/transaction/transaction_detail_model.dart';
import 'package:mobile_umroh_v2/repository/transaction/transaction_repo.dart';

class TransactionDetailBloc extends Cubit<TransactionDetailState>{
  TransactionDetailBloc() : super(TransactionDetailInitial());

  void getTransactionDetail(String id) async {
    emit(TransactionDetailLoading());
   try {
    final response = await TransactionRepo().loadTransactionDetail(id);
    if (response.statusCode == 200) {
      var transactionData = TransactionDetailModel.fromJson(response.data).data!;
      emit(TransactionDetailLoaded(transactionData));
    } else {
      String errorMessage = "Failed to load transaction detail : ${response.statusCode}";
      emit(TransactionDetailError(errorMessage));
    }
   } catch (e) {
    emit(TransactionDetailError("Error: $e"));
   }
  }
}