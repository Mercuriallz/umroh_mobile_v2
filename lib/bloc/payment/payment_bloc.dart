import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/payment/payment_state.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/model/payment/payment_data_model.dart';
import 'package:mobile_umroh_v2/model/payment/payment_model.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class PaymentBloc extends Cubit<PaymentState> {
  PaymentBloc() : super(PaymentInitial());

  final secureStorage = SecureStorageService();

  Future<void> sendPayment(PaymentModel formData) async {
    emit(PaymentLoading());

    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    ));

    final token = await secureStorage.read("token");

    Map<String, dynamic> paymentData = {
      "purchase_title": formData.purchaseTitle,
      "paket_id": formData.paketId,
      "price_final": formData.priceFinal,
      "amount": formData.amount,
      "type_payment": formData.typePayment,
      "type_payment_user": formData.typePaymentUser,
      "notes": formData.notes,
      "user_reg": formData.userReg != null
          ? formData.userReg!
              .map((v) => {
                    "name": v.name,
                    "email": v.email,
                    "phone_number": v.phoneNumber,
                    "nik": v.nik,
                    "password": v.password,
                    "hubungan_kerabat": v.hubunganKerabat
                  })
              .toList()
          : [],
    };

    try {
      // print("[PaymentBloc] Sending payment data: $paymentData");

      final response = await dio.post(
        "$baseUrl/pay",
        data: paymentData,
        options: Options(
          validateStatus: (status) {
            return status != null && status < 600;
          },
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print("[PaymentBloc] Response status: ${response.statusCode}");
      print("[PaymentBloc] Response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var paymentData = PaymentDataModel.fromJson(response.data).data!;
        emit(PaymentSuccess());
        emit(PaymentDataLoaded(paymentData));
      } else {
        emit(PaymentFailed(response.data["message"] ?? "Terjadi kesalahan dari server."));
        // print("[PaymentBloc] Payment failed: ${response.data["message"]}");
      }
    } on DioException catch (dioError) {
      final statusCode = dioError.response?.statusCode;
      final message = dioError.message;
      emit(PaymentFailed("Gagal menghubungi server. Status: $statusCode. Pesan: $message"));
      // print("[PaymentBloc] DioException caught: $dioError");
    } catch (e) {
      emit(PaymentFailed("Terjadi kesalahan: $e"));
      // print("[PaymentBloc] Exception caught: $e");
    }
  }
}
