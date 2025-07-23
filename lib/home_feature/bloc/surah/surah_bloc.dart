import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/home_feature/bloc/surah/surah_state.dart';
import 'package:mobile_umroh_v2/home_feature/repository/surah_repo.dart';

class SurahBloc extends Cubit<SurahState> {
  
  SurahBloc() : super(SurahInitial());
  
  void fetchSurah(int surahNumber) async {
    final response = SurahRepository();
    emit(SurahLoading());
    final result = await response.loadSurah(surahNumber);
    result.fold(
      (l) => emit(SurahError(l)),
      (r) => emit(SurahLoaded(r)),
    );
  }
  
  void reset() {
    emit(SurahInitial());
  }
}