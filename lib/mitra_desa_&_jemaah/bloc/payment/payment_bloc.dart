import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/payment/payment_state.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/payment/payment_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/payment/self_payment_model.dart';
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

    final paymentData = FormData.fromMap({
      "purchase_title": formData.purchaseTitle,
      "paket_id": formData.paketId,
      "price_final": formData.priceFinal,
      "amount": "0",
      "type_payment": formData.typePayment,
      "type_va_choice": formData.typeVaChoice,
      "type_payment_user": formData.typePaymentUser,
      // "kode_connect": "KDS91411",
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
    });

    try {
      // print("[PaymentBloc] Sending payment data: $paymentData");

      final response = await dio.post(
        "$baseUrl/reg-schedule-pay-kepdes",
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
        emit(PaymentSuccess());
      } else {
        emit(PaymentFailed(
            response.data["message"] ?? "Terjadi kesalahan dari server."));
      }
    } on DioException catch (dioError) {
      final statusCode = dioError.response?.statusCode;
      final message = dioError.message;
      emit(PaymentFailed(
          "Gagal menghubungi server. Status: $statusCode. Pesan: $message"));
    } catch (e) {
      emit(PaymentFailed("Terjadi kesalahan: $e"));
    }
  }

  Future<void> selfPayment(SelfPaymentModel formData) async {
  final token = await secureStorage.read("token");
  emit(PaymentLoading());

  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  ));

  // print("[PaymentBloc] Preparing JSON payload...");

  final paymentData = {
    "amount": "0",
    "price_final": formData.priceFinal,
    "purchase_title": formData.purchaseTitle,
    "paket_id": formData.paketId,
    "type_payment": formData.typePayment,
    "user_reg": formData.userReg?.map((v) => {
          "name": v.name,
          "email": v.email,
          "phone_number": v.phoneNumber,
          "nik": v.nik,
          "password": v.password,
          "hubungan_kerabat": v.hubunganKerabat,
          "img_ktp": v.imgKtp?.path ?? "",
          "img_passport": v.imgPassport?.path ?? "",
          "img_kk": v.imgKk?.path ?? "",
          "img_vaksin": v.imgVaksin?.path ?? "",
          "img_pas_foto": v.imgPasFoto?.path ?? "",
          "img_bpjs_kesehatan": v.imgBpjsKesehatan?.path ?? "",
        }).toList(),
    "type_payment_user": formData.typePaymentUser,
    "type_va_choice": formData.typeVaChoice,
    "kode_connect": formData.kodeConnect,
    "status_pay": "0"
  };

  try {
    // print("[PaymentBloc] Sending JSON payload: $paymentData");

    final response = await dio.post(
      "$baseUrl/trx/self-pay",
      data: paymentData,
      options: Options(
        validateStatus: (status) => status != null && status < 600,
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    // print("[PaymentBloc] Response status: ${response.statusCode}");
    // print("[PaymentBloc] Response data: ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(PaymentSuccess());
    } else {
      emit(PaymentFailed(
          response.data["message"] ?? "Terjadi kesalahan dari server."));
    }
  } on DioException catch (dioError) {
    final statusCode = dioError.response?.statusCode;
    final message = dioError.message;
    emit(PaymentFailed(
        "Gagal menghubungi server. Status: $statusCode. Pesan: $message"));
  } catch (e) {
    emit(PaymentFailed("Terjadi kesalahan: $e"));
  }
}
}
