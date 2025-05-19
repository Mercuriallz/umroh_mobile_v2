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

      final dio = Dio();
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


      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailed("Registrasi gagal: ${response.statusMessage}"));
        print("Registrasi gagal: ${response.statusMessage}");
      }
    } catch (e) {
      String errorMessage = "Terjadi kesalahan saat registrasi";
      
      if (e is DioException) {
        if (e.response != null) {
          try {
            final responseData = e.response!.data;
            if (responseData is Map && responseData.containsKey('message')) {
              errorMessage = responseData['message'];

            } else if (responseData is Map && responseData.containsKey('error')) {
              errorMessage = responseData['error']; 
            }
          } catch (_) {
            errorMessage = e.response!.statusMessage ?? errorMessage;
          }
        } else if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = "Koneksi timeout. Silakan coba lagi.";
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage = "Tidak dapat terhubung ke server. Periksa koneksi internet Anda.";
        }
      }
      
      emit(RegisterFailed(errorMessage));
    }
  }
}