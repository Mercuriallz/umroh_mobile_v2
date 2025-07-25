import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/payment/payment_self/payment_self_state.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/payment/self_payment_model.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class PaymentSelfBloc extends Cubit<PaymentSelfState>{
  PaymentSelfBloc() : super(PaymentSelfInitial());
  final secureStorage = SecureStorageService();

  Future<void> selfPayment(SelfPaymentModel formData) async {

    final token = await secureStorage.read("token");
    emit(PaymentSelfLoading());

    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    ));

    // final token = await secureStorage.read("token");
    // print("User Reg --> ${formData.userReg}");
    // print("[PaymentBloc] Sending payment data: $formData");

    final paymentData = FormData.fromMap({
      "amount": "0",
      "price_final": formData.priceFinal,
      "purchase_title": formData.purchaseTitle,
      "paket_id": formData.paketId,
      "type_payment": formData.typePayment,
      "user_reg": formData.userReg != null
          ? await Future.wait(formData.userReg!.map((v) async => {
                "name": v.name,
                "email": v.email,
                "phone_number": v.phoneNumber,
                "nik": v.nik,
                "password": v.password,
                "hubungan_kerabat": v.hubunganKerabat,
                "img_ktp": v.imgKtp != null
                    ? await MultipartFile.fromFile(v.imgKtp!.path)
                    : null,
                "img_passport": v.imgPassport != null
                    ? await MultipartFile.fromFile(v.imgPassport!.path)
                    : null,
                "img_kk": v.imgKk != null
                    ? await MultipartFile.fromFile(v.imgKk!.path)
                    : null,
                "img_vaksin": v.imgVaksin != null
                    ? await MultipartFile.fromFile(v.imgVaksin!.path)
                    : null,
                "img_pas_foto": v.imgPasFoto != null
                    ? await MultipartFile.fromFile(v.imgPasFoto!.path)
                    : null,
                "img_bpjs_kesehatan": v.imgBpjsKesehatan != null
                    ? await MultipartFile.fromFile(v.imgBpjsKesehatan!.path)
                    : null,
              }))
          : [],
      "type_payment_user": formData.typePaymentUser,
      "type_va_choice": formData.typeVaChoice,
      "kode_connect": formData.kodeConnect,
    });

    try {
      // print("[PaymentBloc] Sending payment data: $paymentData");

      final response = await dio.post(
        "$baseUrl/trx/self-pay",
        data: paymentData,
        options: Options(
          validateStatus: (status) {
            return status != null && status < 600;
          },
          headers: {
             "Content-Type": "x-www-form-urlencoded",
            "Authorization": "Bearer $token",
          },
        ),
      );

      // print("[PaymentBloc] Response status: ${response.statusCode}");
      // print("[PaymentBloc] Response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(PaymentSelfSuccess());
      } else {
        emit(PaymentSelfFailed(
            response.data["message"] ?? "Terjadi kesalahan dari server."));
      }
    } on DioException catch (dioError) {
      final statusCode = dioError.response?.statusCode;
      final message = dioError.message;
      emit(PaymentSelfFailed(
          "Gagal menghubungi server. Status: $statusCode. Pesan: $message"));
    } catch (e) {
      emit(PaymentSelfFailed("Terjadi kesalahan: $e"));
    }
  }

}