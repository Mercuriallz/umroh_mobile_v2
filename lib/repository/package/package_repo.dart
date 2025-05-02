import 'package:dio/dio.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class PackageRepository {

  final secureStorage = SecureStorageService();
  
  Future<Response> loadPackage() async {
    final dio = Dio();
    final token = await secureStorage.read("token");
    final response = await dio.get("$baseUrl/paket",
    options: Options(
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {
        "Authorization": "Bearer $token"
      }
    )
    );
    return response;
  }

  Future<Response> loadPackageById(String id) async {
    final dio = Dio();
    final token = await secureStorage.read("token");
    final response = await dio.get("$baseUrl/paket/$id",
    options: Options(
      headers: {
        "Authorization": "Bearer $token"
      }
    )
    );
    return response;
  }
  
}