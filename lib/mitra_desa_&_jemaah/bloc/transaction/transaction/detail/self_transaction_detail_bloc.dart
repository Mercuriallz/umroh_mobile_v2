import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/transaction/transaction/detail/self_transaction_detail_state.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/transaction/self/self_transaction_detail_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/repository/transaction/transaction_repo.dart';

class SelfTransactionDetailBloc extends Cubit<SelfTransactionDetailState>{
  SelfTransactionDetailBloc() : super(SelfTransactionDetailInitial()); 

  void getTransactionDetail() async {
    emit(SelfTransactionDetailLoading());
    try {
      final response = await TransactionRepo().loadSelfTransactionDetail();
      if (response.statusCode == 200) {
        final model = SelfTransactionDetailModel.fromJson(response.data).data;
        // final dataTransaction = model.dataTransaction;
        // final dataPay = model.dataPay;
        // final dataPaket = model.dataPaket;

        if (model != null) {
          emit(SelfTransactionDetailLoaded(model));
        } else {
          emit(SelfTransactionDetailError("Data transaksi kosong"));
        }
      } else {
        emit(SelfTransactionDetailError(
            "Gagal memuat detail transaksi: ${response.statusCode}"));
      }
    } catch (e) {
      emit(SelfTransactionDetailError("Terjadi kesalahan: ${e.toString()}"));
    }
  }
}