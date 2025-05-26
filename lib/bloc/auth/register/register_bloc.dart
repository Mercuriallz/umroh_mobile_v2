import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/auth/register/register_state.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/model/auth/register_model.dart';

class RegisterBloc extends Cubit<RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  void register(RegisterModel formData) async {
    emit(RegisterLoading());

    try {
      print("[RegisterBloc] Mulai proses registrasi...");

      final data = FormData.fromMap({
        "email": formData.email,
        "password": formData.password,
        "name": formData.name,
        "no_telp": formData.noTelp,
        "img_ktp": await MultipartFile.fromFile(formData.imgKtp!.path),
        "img_kk": await MultipartFile.fromFile(formData.imgKk!.path),
        "img_passport": await MultipartFile.fromFile(formData.imgPassport!.path),
        "img_vaksin": await MultipartFile.fromFile(formData.imgVaksin!.path),
        "nik": formData.nik,
        "address": formData.address,
        "img_pas_foto": await MultipartFile.fromFile(formData.imgPasFoto!.path),
        "img_bpjs_kesehatan": await MultipartFile.fromFile(formData.imgBpjsKesehatan!.path),
        "dob": formData.dob,
        "id_kabupaten": formData.idKabupaten,
        "id_kecamatan": formData.idKecamatan,
        "id_provinsi": formData.idProvinsi,
        "id_kelurahan": formData.idKelurahan
      });

      print("[RegisterBloc] Data Form berhasil dikonversi ke FormData.");
      print("[RegisterBloc] Data: ${data.fields.map((e) => '${e.key}: ${e.value}').toList()}");

      final dio = Dio();

      print("[RegisterBloc] Mengirim request POST ke: $baseUrl/auth/user/sign-up");

      final response = await dio.post(
        "$baseUrl/auth/user/sign-up",
        data: data,
        options: Options(
          headers: {
            'umr_api_key': apiKey,
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print("[RegisterBloc] Response status: ${response.statusCode}");
      print("[RegisterBloc] Response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("[RegisterBloc] Registrasi berhasil.");
        emit(RegisterSuccess());
      } else {
        print("[RegisterBloc] Registrasi gagal. Status Message: ${response.statusMessage}");
        emit(RegisterFailed("Registrasi gagal: ${response.statusMessage}"));
      }

    } catch (e) {
      String errorMessage = "Terjadi kesalahan saat registrasi: $e";
      print("[RegisterBloc] Exception ditangkap: $e");

      if (e is DioException) {
        print("[RegisterBloc] DioException Type: ${e.type}");

        if (e.response != null) {
          print("[RegisterBloc] Response error: ${e.response!.data}");
          try {
            final responseData = e.response!.data;
            if (responseData is Map && responseData.containsKey('message')) {
              errorMessage = responseData['message'];
              print("[RegisterBloc] Error message dari response: $errorMessage");
            } else if (responseData is Map && responseData.containsKey('error')) {
              errorMessage = responseData['error'];
              print("[RegisterBloc] Error dari response key 'error': $errorMessage");
            } else {
              print("[RegisterBloc] Tidak ada key 'message' atau 'error' ditemukan.");
            }
          } catch (_) {
            print("[RegisterBloc] Gagal parsing error response, fallback ke status message.");
            errorMessage = e.response!.statusMessage ?? errorMessage;
          }
        } else if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = "Koneksi timeout. Silakan coba lagi.";
          print("[RegisterBloc] Koneksi timeout.");
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage = "Tidak dapat terhubung ke server. Periksa koneksi internet Anda.";
          print("[RegisterBloc] Tidak ada koneksi internet.");
        } else {
          print("[RegisterBloc] Tipe error Dio lainnya: ${e.message}");
        }
      } else {
        print("[RegisterBloc] Error non-DioException: $e");
      }

      emit(RegisterFailed(errorMessage));
    }
  }
}
