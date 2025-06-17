import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/package/package_model.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class PackageRepository {
  final secureStorage = SecureStorageService();
  final dio = Dio();

  Future<Either<String, PackageModel>> loadPackage() async {
    try {
      final token = await secureStorage.read("token");
      final response = await dio.get("$baseUrl/paket",
          options: Options(headers: {"Authorization": "Bearer $token"}));

      var dataModel  = PackageModel.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(dataModel);
      } else {
        return Left(dataModel.message!);
      }
    } catch (e) {
      return Left(('Exception: $e'));
    }
  }

  
}
