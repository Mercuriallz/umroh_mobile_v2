import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/home_feature/bloc/alquran/alquran_state.dart';
import 'package:mobile_umroh_v2/home_feature/repository/alquran_repo.dart';

class AlquranBloc extends Cubit<AlquranState>{
  AlquranBloc() : super(AlquranInitial());

  void fetchAlquran() async {
    emit(AlquranLoading());
    final result = await AlquranRepo().loadAlquran();

    result.fold(  
      (l) => emit(AlquranError(l)),
      (r) => emit(AlquranLoaded(r)),
    );
  }
}