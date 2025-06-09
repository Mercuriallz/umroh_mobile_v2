import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/profile/upload/upload_profile_state.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/model/profile/profile_update_request_model.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class UploadProfileBloc extends Cubit<UploadProfileState> {
  UploadProfileBloc() : super(UploadProfileInitial());

  void uploadProfile(ProfileUpdateRequestModel formData) async {
    emit(UploadProfileLoading());

    var dio = Dio();
    final secureStorage = SecureStorageService();
    final token = secureStorage.read("token");

    final data = FormData.fromMap({
      "img": await MultipartFile.fromFile(formData.img!.path)
    });

    try {
      final response = await dio.post("$baseUrl/profile-update-pic",
      data: data,
      options: Options(
        headers: {
          "Content-type": "multipart/form-data",
          "Authorization": "Bearer $token"
        }
      )
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        emit(UploadProfileSuccess());
      }
    } catch (e) {
      emit(UploadProfileError(e.toString()));
    }
  }
}