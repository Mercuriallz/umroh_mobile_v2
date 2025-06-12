import 'package:dio/dio.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';

class KecamatanRepository {
  Future<Response> loadKecamatan(String id) async {
    final dio = Dio();
    final response = await dio.get("$baseUrl/wilayah/kecamatan/$id",
    options: Options(
      headers: {
        "umr_api_key": apiKey
      }
    )
    );
    return response;
  }
}