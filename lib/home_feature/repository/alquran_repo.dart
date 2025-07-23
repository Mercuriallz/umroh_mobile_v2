import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mobile_umroh_v2/home_feature/model/alquran/alquran_model.dart';

class AlquranRepo {
  final dio = Dio();
  
  Future<Either<String, List<AlquranModel>>> loadAlquran() async {
    try {
      final response = await dio.get("https://quran-api.santrikoding.com/api/surah");
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        
        final List<AlquranModel> alquranList = jsonList
            .map((json) => AlquranModel.fromJson(json as Map<String, dynamic>))
            .toList();
            
        return Right(alquranList);
      } else {
        return Left("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      return Left('Exception: $e');
    }
  }
}