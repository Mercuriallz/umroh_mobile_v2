import 'package:dio/dio.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class ProfileRepository {
  final secureStorage = SecureStorageService();

  Future<Response> loadProfile() async {
    final dio = Dio();
    final token = await secureStorage.read("token");
    final response = await dio.get("$baseUrl/profile",
        options: Options(
            validateStatus: (status) {
              return status! < 600;
            },
            headers: {"Authorization": "Bearer $token"}));

    return response;
  }
}
