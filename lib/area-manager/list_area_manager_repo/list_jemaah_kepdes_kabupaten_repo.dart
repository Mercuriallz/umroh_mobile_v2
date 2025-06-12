import 'package:dio/dio.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class ListJemaahKepdesKabupatenRepo {
  final secureStorage = SecureStorageService();

  Future<Response> loadListJemaahKepdesKabupaten(String id) async {
    final dio = Dio();
    final token = await secureStorage.read("token");
    final response = await dio.get("$baseUrl/user-mitra-jemaah-kab/$id",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    return response;
  }
}
