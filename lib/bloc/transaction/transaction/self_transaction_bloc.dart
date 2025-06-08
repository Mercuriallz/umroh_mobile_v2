import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/transaction/transaction/self_transaction_state.dart';
import 'package:mobile_umroh_v2/model/transaction/self/self_transaction_model.dart';
import 'package:mobile_umroh_v2/repository/transaction/transaction_repo.dart';

class SelfTransactionBloc extends Cubit<SelfTransactionState> {
  SelfTransactionBloc() : super(SelfTransactionInitial());

  void getSelfTransaction() async {
    emit(SelfTransactionLoading());

    try {
      final response = await TransactionRepo().loadSelfTransaction();


      if (response.statusCode == 200) {
        final transactionModel = SelfTransactionModel.fromJson(response.data);
        final transactionList = transactionModel.data?.transactionList;


        if (transactionList != null) {
          emit(SelfTransactionLoaded(transactionList));
        } else {
          emit(SelfTransactionError("Data transaksi kosong"));
        }
      } else {
        emit(SelfTransactionError("Gagal memuat data transaksi: ${response.statusCode}"));
      }
    } catch (e) {
      print(e);
      emit(SelfTransactionError("Terjadi kesalahan: ${e.toString()}"));
      
    }
  }
}
