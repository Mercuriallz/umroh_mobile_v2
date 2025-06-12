import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/profile/upload/upload_profile_state.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/model/profile/profile_update_request_model.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class UploadProfileBloc extends Cubit<UploadProfileState> {
  UploadProfileBloc() : super(UploadProfileInitial());

  void uploadProfile(ProfileUpdateRequestModel formData) async {
    // print('[UploadProfileBloc] Mulai upload foto profil...');
    emit(UploadProfileLoading());
    // print('[UploadProfileBloc] State: UploadProfileLoading');

    final dio = Dio();
    final secureStorage = SecureStorageService();
    final token = await secureStorage.read("token");

    // print('[UploadProfileBloc] Token: $token');
    // print('[UploadProfileBloc] File path: ${formData.img?.path}');

    if (formData.img == null) {
      // print('[UploadProfileBloc] Error: Gambar tidak ditemukan');
      emit(UploadProfileError("Gambar tidak ditemukan"));
      return;
    }

    try {
      final data = FormData.fromMap({
        "img": await MultipartFile.fromFile(formData.img!.path),
      });

      // print('[UploadProfileBloc] FormData siap dikirim');

      final response = await dio.post(
        "$baseUrl/profile-update-pic",
        data: data,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token",
          },
        ),
      );

      // print('[UploadProfileBloc] Response status: ${response.statusCode}');
      // print('[UploadProfileBloc] Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UploadProfileSuccess());
        // print('[UploadProfileBloc] State: UploadProfileSuccess');
      } else {
        emit(UploadProfileError("Upload gagal: ${response.statusCode}"));
        // print('[UploadProfileBloc] State: UploadProfileError');
      }
    } catch (e) {
      emit(UploadProfileError("Terjadi kesalahan: ${e.toString()}"));
      // print('[UploadProfileBloc] Exception: ${e.toString()}');
    }
  }
}
