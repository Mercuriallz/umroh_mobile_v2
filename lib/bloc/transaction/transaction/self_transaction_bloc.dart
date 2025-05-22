import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/transaction/transaction/self_transaction_state.dart';
import 'package:mobile_umroh_v2/model/transaction/self_transaction_model.dart';
import 'package:mobile_umroh_v2/repository/transaction/transaction_repo.dart';

class SelfTransactionBloc extends Cubit<SelfTransactionState> {
  SelfTransactionBloc() : super(SelfTransactionInitial());

  void getSelfTransaction() async {
    emit(SelfTransactionLoading());
    try {
      final response = await TransactionRepo().loadSelfTransaction();

      // print("[SelfTransactionBloc] Status Code: ${response.statusCode}");
      // print("[SelfTransactionBloc] Response Data: ${response.data}");

      if (response.statusCode == 200) {
        final model = SelfTransactionModel.fromJson(response.data).dataTransaction;
        final dataPay = SelfTransactionModel.fromJson(response.data).dataPay!;

        // print("[SelfTransactionBloc] Parsed Model: ${model.toJson()}");

        if (model != null) {
          emit(SelfTransactionLoaded(model, dataPay));
         
        } else {
          // print("[SelfTransactionBloc] ❌ dataTransaction null");
          emit(SelfTransactionError("Data transaksi kosong"));
        }
      } else {
        String errorMessage =
            "Failed to load self transaction : ${response.statusCode}";
        // print("[SelfTransactionBloc] ❌ $errorMessage");
        emit(SelfTransactionError(errorMessage));
      }
    } catch (e) {
      // print("[SelfTransactionBloc] Exception: $e");
      // print("[SelfTransactionBloc] Stacktrace: $stacktrace");
      emit(SelfTransactionError("Error: ${e.toString()}"));
    }
  }
}
