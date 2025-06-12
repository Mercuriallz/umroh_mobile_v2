import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/profile/get_profile/profile_state.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/profile/profile_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/repository/profile/profile_repo.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  void getProfile() async {
    var response = await ProfileRepository().loadProfile();

    try{
      if (response.statusCode == 200) {
        var dataModel = ProfileModel.fromJson(response.data).data!;
        emit(ProfileLoaded(dataModel));
      } else {
        emit(ProfileError("Ada error pas dapetin image"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}