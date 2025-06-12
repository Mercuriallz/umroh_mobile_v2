import 'package:dio/dio.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class PackageActiveRepository {
  final secureStorage = SecureStorageService();

  Future<Response> loadActivePackage() async {
    final dio = Dio();
    final token = await secureStorage.read("token");
    final response = await dio.get("$baseUrl/paket-active",
        options: Options(
          validateStatus: (status) {
            return status! < 600;
          },
          headers: {"Authorization": "Bearer $token"}));
    return response;
  }
}
