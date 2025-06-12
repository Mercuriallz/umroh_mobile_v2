import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/transaction/payment/payment_transaction_state.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/transaction/payment/payment_transaction_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/transaction/payment/payment_transaction_request_model.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class PaymentTransactionBloc extends Cubit<PaymentTransactionState> {
  PaymentTransactionBloc() : super(PaymentTransactionInitial());
  final dio = Dio();
  final secureStorage = SecureStorageService();
  
  void sendPaymentTransaction(PaymentTransactionRequestModel formData) async {
    emit(PaymentTransactionLoading());

    try {
      final token = await secureStorage.read("token");
      debugPrint("[PAYMENT] Token: $token");

      Map<String, dynamic> paymentData = {
        "trx": formData.trx,
        "amount": formData.amount,
        "type_payment": formData.typePayment,
        "type_va": formData.typeVa,
      };

      debugPrint("[PAYMENT] Request Payload: $paymentData");

      var response = await dio.post(
        "$baseUrl/trx/self-pay-mobile",
        data: paymentData,
        options: Options(
          validateStatus: (status) => status! < 500,
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      debugPrint("[PAYMENT] Response Status: ${response.statusCode}");
      debugPrint("[PAYMENT] Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = PaymentTransactionModel.fromJson(response.data).data!;
        debugPrint("[PAYMENT] Payment Success: $data");
        emit(PaymentTransactionSuccess(data));
      } else {
        debugPrint("[PAYMENT] Payment Failed with Status: ${response.statusCode}");
        emit(PaymentTransactionFailed("Gagal melakukan pembayaran"));
      }
    } catch (e, stackTrace) {
      debugPrint("[PAYMENT] Error occurred: $e");
      debugPrint("[PAYMENT] Stack trace: $stackTrace");
      emit(PaymentTransactionFailed(e.toString()));
    }
  }
}
