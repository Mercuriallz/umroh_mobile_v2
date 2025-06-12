import 'package:dio/dio.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';

class ProvinsiRepository {
  Future<Response> loadProvinsi() async {
    final dio = Dio();
    final response = await dio.get("$baseUrl/wilayah/provinsi",
    options: Options(
      headers: {
        "umr_api_key": apiKey
      }
    )
    );
    return response;
  }
}