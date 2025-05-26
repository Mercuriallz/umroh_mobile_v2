import 'package:dio/dio.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class TransactionRepo {
  final secureStorage = SecureStorageService();
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  ));

  Future<Response> loadTransactionDetail(String id) async {
    final token = await secureStorage.read("token");
    final response = await dio.get("$baseUrl/trx/status/$id",
        options: Options(
            validateStatus: (status) {
              return status! < 600;
            },
            headers: {"Authorization": "Bearer $token"}));
    return response;
  }

  Future<Response> loadSelfTransaction() async {
    final token = await secureStorage.read("token");
    final response = await dio.get(
        "$baseUrl/trx/schedule-assign-user",
        options: Options(
            validateStatus: (status) {
              return status! < 600;
            },
            headers: {"Authorization": "Bearer $token"}));
    return response;
  }

  Future<Response> loadSelfTransactionDetail() async {
    final token = await secureStorage.read("token");
    final response = await dio.get(
        "$baseUrl/trx/self",
        options: Options(
            validateStatus: (status) {
              return status! < 600;
            },
            headers: {"Authorization": "Bearer $token"}));
    return response;
  }
}
