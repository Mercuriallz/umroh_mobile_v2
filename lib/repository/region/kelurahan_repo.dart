import 'package:dio/dio.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';

class KelurahanRepository {
  Future<Response> loadKelurahan(String id) async {
    final dio = Dio();
    final response = await dio.get("$baseUrl/wilayah/kelurahan/$id",
    options: Options(
      headers: {
        "umr_api_key": apiKey
      }
    )
    );
    return response;
  }
}