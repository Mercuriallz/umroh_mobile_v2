import 'package:dio/dio.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';

class KabupatenRepository {
  Future<Response> loadKabupaten(String id) async {
    final dio = Dio();
    final response = await dio.get("$baseUrl/wilayah/kabupaten/$id",
    options: Options(
      headers: {
        "umr_api_key": apiKey
      }
    )
    );
    return response;
  }
}