import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/bloc/transaction/upload/upload_state.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/model/transaction/upload/upload_model.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class UploadBloc extends Cubit<UploadState> {
  UploadBloc() : super(UploadInitial());

  final dio = Dio();
  final secureStorage = SecureStorageService();

 void uploadImage({required String id, required UploadModel formData}) async {
  emit(UploadLoading());
  // print("🔄 Mulai upload gambar untuk transaksi ID: $id");

  final data = FormData.fromMap({
    "img_trx": await MultipartFile.fromFile(formData.imgTrx!.path),
  });

  try {
    final token = await secureStorage.read("token");
    // print("🔐 Token ditemukan: ${token != null}");

    final response = await dio.post(
      "$baseUrl/bukti-tf/$id",
      data: data,
      options: Options(
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        validateStatus: (status) => status! < 500,
        followRedirects: false,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
        },
      ),
    );

    // print("📡 Status Code: ${response.statusCode}");
    // print("📄 Response Type: ${response.data.runtimeType}");
    // print("📄 Raw Response: ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(UploadSuccess());
      // print("✅ Upload berhasil.");
    } else {
      if (response.data is Map) {
        final errorMsg = response.data['message'] ?? 'Unknown error';
        // print("⚠️ Error message dari server: $errorMsg");
        emit(UploadError("Gagal mengunggah gambar: $errorMsg"));
      } else {
        // print("⚠️ Response bukan JSON, kemungkinan error HTML: ${response.data}");
        emit(UploadError("Gagal mengunggah gambar: Server mengembalikan respons tidak valid."));
      }
    }
  } catch (e) {
    // print("❗ Exception saat upload: $e");
    // print("📌 Stacktrace: $stacktrace");
    emit(UploadError("Gagal mengunggah gambar: ${e.toString()}"));
  }
}
}