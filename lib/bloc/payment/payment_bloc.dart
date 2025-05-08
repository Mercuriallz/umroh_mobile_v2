import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/payment/payment_state.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/model/payment/payment_model.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class PaymentBloc extends Cubit<PaymentState> {
  PaymentBloc() : super(PaymentInitial());

  final secureStorage = SecureStorageService();

  Future<void> sendPayment(PaymentModel formData) async {
    emit(PaymentInitial());
    final dio = Dio();
    final token = secureStorage.read("token");

    Map<String, dynamic> paymentData = {
      "purchase_title": formData.purchaseTitle,
      "paket_id": formData.paketId,
      "price_final": formData.priceFinal,
      "amount": formData.amount,
      "type_payment": formData.typePayment,
      "notes": formData.notes,
      "user_reg": formData.userReg != null
          ? formData.userReg!
              .map((v) => {
                    "name": v.name,
                    "email": v.email,
                    "phone_number": v.phoneNumber,
                    "nik": v.nik,
                    "password": v.password,
                  })
              .toList()
          : [],
    };

    try {
      final response = await dio.post("$baseUrl/pay",
          data: paymentData, options: Options(
            validateStatus: (status) {
              return status! < 500;
            },
            headers: {
            "Authorization": "Bearer $token",
          }));

          if (response.statusCode == 200 || response.statusCode == 201) {
            emit(PaymentSuccess());
          } else {
            emit(PaymentFailed(response.data["message"]));
          }
    } catch (e) {
      emit(PaymentFailed("Error: $e"));
    }
  }
}
