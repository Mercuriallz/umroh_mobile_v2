import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/package/package_model_by_id.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class PackageIdRepo {
  final dio = Dio();
  final secureStorage = SecureStorageService();
  Future<Either<String, PackageModelById>> loadPackageById(String id) async {
    try {
      final token = await secureStorage.read("token");

      final response = await dio.get(
        "$baseUrl/paket/$id",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final data = PackageModelById.fromJson(response.data);

      if (response.statusCode == 200) {
        return Right(data);
      } else {
        return Left(data.message ?? 'Terjadi kesalahan');
      }
    } catch (e) {
      return Left('Exception: $e');
    }
  }
}
