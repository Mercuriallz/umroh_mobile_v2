import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/home_feature/model/alquran/surah_model.dart';

abstract class SurahState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SurahInitial extends SurahState {}

class SurahLoading extends SurahState {}

class SurahLoaded extends SurahState {
  final SurahModel surah;
  @override
  List<Object?> get props => [surah];

  SurahLoaded(this.surah);
}

class SurahError extends SurahState {
  final String message;
  @override
  List<Object?> get props => [message];

  SurahError(this.message);
}
