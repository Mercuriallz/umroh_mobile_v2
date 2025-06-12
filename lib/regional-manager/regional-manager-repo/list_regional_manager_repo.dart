import 'package:dio/dio.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class ListRegionalManagerRepo {
  final secureStorage = SecureStorageService();

  Future<Response> loadListRegionalManager() async {
    final dio = Dio();
    final token = await secureStorage.read("token");
    final response = await dio.get("$baseUrl/spv-prov-list",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    return response;
  }
}
