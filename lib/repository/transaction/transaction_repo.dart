import 'package:dio/dio.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class TransactionRepo {
  final secureStorage = SecureStorageService();
  final dio = Dio();

  Future<Response> loadTransactionDetail(String id) async {
    
    final token = await secureStorage.read("token");
    final response = await dio.get("$baseUrl/trx/status/$id",
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {"Authorization": "Bearer $token"}));
    return response;
  }
}