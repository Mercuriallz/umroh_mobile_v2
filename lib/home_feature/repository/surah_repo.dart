import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mobile_umroh_v2/home_feature/model/alquran/surah_model.dart';

class SurahRepository {
  final dio = Dio();
  
  Future<Either<String, SurahModel>> loadSurah(int surahNumber) async {
    try {
      final response = await dio.get(
        "https://quran-api.santrikoding.com/api/surah/$surahNumber"
      );
      
      if (response.statusCode == 200) {
        final SurahModel surah = SurahModel.fromJson(response.data);
        return Right(surah);
      } else {
        return Left("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      return Left('Exception: $e');
    }
  }
}