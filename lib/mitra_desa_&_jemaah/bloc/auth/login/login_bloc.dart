import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/auth/login/login_state.dart';
import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/auth/area-manager/area_manager_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/auth/area-manager/area_manager_request_model.dart';

import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/auth/login/chief/login_chief_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/auth/login/chief/login_chief_request_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/auth/login/jemaah/login_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/auth/login/jemaah/login_request_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/auth/regional-manager/regional_manager_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/auth/regional-manager/regional_manager_request_model.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginInitial());

  final secureStorage = SecureStorageService();

  Future<void> login({LoginRequestModel? formData}) async {
    if (formData == null) {
      emit(LoginError("Data login tidak boleh kosong"));
      return;
    }

    emit(LoginLoading());

    final dio = Dio();
    Map<String, dynamic> dataLogin = {
      'nik': formData.nik,
      'password': formData.password,
    };

    try {
      final response = await dio.post(
        "$baseUrl/auth/user/sign-in",
        data: dataLogin,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "umr_api_key": apiKey,
          },
        ),
      );

      if (response.statusCode == 200) {
        var loginModel = LoginModel.fromJson(response.data);
        var token = loginModel.token;
        var name = loginModel.data?.name;
        var role = loginModel.data?.roleId;

        if (token == null || name == null) {
          emit(LoginError("Data token atau nama tidak ditemukan"));
          return;
        }

        await secureStorage.write("token", token);
        await secureStorage.write("name", name);
        await secureStorage.write("role", role!.toString());

        emit(LoginSuccess());
      } else if (response.statusCode == 400) {
        String errorMessage =
            response.data?['message'] ?? "Email atau password salah.";
        emit(LoginError(errorMessage));
      } else {
        String errorMessage =
            "Login gagal dengan status code: ${response.statusCode}";
        emit(LoginError(errorMessage));
      }
    } catch (e) {
      String errorMessage = "Terjadi kesalahan saat login";

      if (e is DioException) {
        if (e.response != null) {
          try {
            final responseData = e.response!.data;
            if (responseData is Map && responseData.containsKey('message')) {
              errorMessage = responseData['message'];
            } else if (responseData is Map &&
                responseData.containsKey('error')) {
              errorMessage = responseData['error'];
            }
          } catch (_) {
            errorMessage = e.response!.statusMessage ?? errorMessage;
          }
        } else if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = "Koneksi timeout. Silakan coba lagi.";
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage =
              "Tidak dapat terhubung ke server. Periksa koneksi internet Anda.";
        }
      }

      emit(LoginError(errorMessage));
    }
  }

  Future<void> loginChief({LoginChiefRequestModel? formData}) async {
    if (formData == null) {
      emit(LoginError("Data login tidak boleh kosong"));
      return;
    }

    emit(LoginLoading());

    final dio = Dio();
    Map<String, dynamic> dataLogin = {
      'username': formData.username,
      'password': formData.password,
    };

    try {
      final response = await dio.post(
        "$baseUrl/kepdes/sign-in",
        data: dataLogin,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "umr_api_key": apiKey,
          },
        ),
      );

      if (response.statusCode == 200) {
        var loginModel = LoginChiefModel.fromJson(response.data);
        var token = loginModel.token;
        var name = loginModel.data?.name;
        var role = loginModel.data?.idRole.toString();

        if (token == null || name == null) {
          emit(LoginError("Data token atau nama tidak ditemukan"));
          return;
        }

        await secureStorage.write("token", token);
        await secureStorage.write("name", name);
        await secureStorage.write("role", role!.toString());

        emit(LoginSuccess());
      } else if (response.statusCode == 400) {
        String errorMessage =
            response.data?['message'] ?? "Email atau password salah.";
        emit(LoginError(errorMessage));
      } else {
        String errorMessage =
            "Login gagal dengan status code: ${response.statusCode}";
        emit(LoginError(errorMessage));
      }
    } catch (e) {
      String errorMessage = "Terjadi kesalahan saat loginChief";

      if (e is DioException) {
        if (e.response != null) {
          try {
            final responseData = e.response!.data;
            if (responseData is Map && responseData.containsKey('message')) {
              errorMessage = responseData['message'];
            } else if (responseData is Map &&
                responseData.containsKey('error')) {
              errorMessage = responseData['error'];
            }
          } catch (_) {
            errorMessage = e.response!.statusMessage ?? errorMessage;
          }
        } else if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = "Koneksi timeout. Silakan coba lagi.";
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage =
              "Tidak dapat terhubung ke server. Periksa koneksi internet Anda.";
        }
      }

      emit(LoginError(errorMessage));
    }
  }

  Future<void> loginAreaManager(
      {LoginAreaManagerRequestModel? formData}) async {
    if (formData == null) {
      emit(LoginError("Data login tidak boleh kosong"));
      return;
    }

    emit(LoginLoading());

    final dio = Dio();
    Map<String, dynamic> dataLogin = {
      'username': formData.username,
      'password': formData.password,
    };

    try {
      final response = await dio.post(
        "$baseUrl/spv-kab/sign-in",
        data: dataLogin,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        var loginModel = AreaManagerModel.fromJson(response.data);
        var token = loginModel.token;
        var name = loginModel.data?.name;
        var role = loginModel.data?.idRole.toString();
        var idProvinsi = loginModel.data?.idProvinsi.toString();
        var idKabupaten = loginModel.data?.idKabupaten.toString();

        if (token == null || name == null) {
          emit(LoginError("Data token atau nama tidak ditemukan"));
          return;
        }

        await secureStorage.write("token", token);
        await secureStorage.write("name", name);
        await secureStorage.write("role", role!.toString());
        await secureStorage.write("idProvinsi", idProvinsi!.toString());
        await secureStorage.write("idKabupaten", idKabupaten!.toString());

        emit(LoginSuccess());
      } else if (response.statusCode == 400) {
        String errorMessage =
            response.data?['message'] ?? "Email atau password salah.";
        emit(LoginError(errorMessage));
      } else {
        String errorMessage =
            "Login gagal dengan status code: ${response.statusCode}";
        emit(LoginError(errorMessage));
      }
    } catch (e) {
      String errorMessage = "Terjadi kesalahan saat loginChief";

      if (e is DioException) {
        if (e.response != null) {
          try {
            final responseData = e.response!.data;
            if (responseData is Map && responseData.containsKey('message')) {
              errorMessage = responseData['message'];
            } else if (responseData is Map &&
                responseData.containsKey('error')) {
              errorMessage = responseData['error'];
            }
          } catch (_) {
            errorMessage = e.response!.statusMessage ?? errorMessage;
          }
        } else if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = "Koneksi timeout. Silakan coba lagi.";
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage =
              "Tidak dapat terhubung ke server. Periksa koneksi internet Anda.";
        }
      }

      emit(LoginError(errorMessage));
    }
  }

  Future<void> loginRegionalManager(
      {LoginRegionalManagerRequestModel? formData}) async {
    if (formData == null) {
      emit(LoginError("Data login tidak boleh kosong"));
      return;
    }

    emit(LoginLoading());

    final dio = Dio();
    Map<String, dynamic> dataLogin = {
      'username': formData.username,
      'password': formData.password,
    };

    try {
      final response = await dio.post(
        "$baseUrl/spv-provinsi/sign-in",
        data: dataLogin,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        var loginModel = RegionalManagerModel.fromJson(response.data);
        var token = loginModel.token;
        var name = loginModel.data?.name;
        var role = loginModel.data?.idRole.toString();
        var idProvinsiRegional = loginModel.data?.idProvinsi.toString();

        if (token == null || name == null) {
          emit(LoginError("Data token atau nama tidak ditemukan"));
          return;
        }

        await secureStorage.write("token", token);
        await secureStorage.write("name", name);
        await secureStorage.write("role", role!.toString());
        await secureStorage.write("idProvinsiRegional", idProvinsiRegional!.toString());

        emit(LoginSuccess());
      } else if (response.statusCode == 400) {
        String errorMessage =
            response.data?['message'] ?? "Email atau password salah.";
        emit(LoginError(errorMessage));
      } else {
        String errorMessage =
            "Login gagal dengan status code: ${response.statusCode}";
        emit(LoginError(errorMessage));
      }
    } catch (e) {
      String errorMessage = "Terjadi kesalahan saat loginChief";

      if (e is DioException) {
        if (e.response != null) {
          try {
            final responseData = e.response!.data;
            if (responseData is Map && responseData.containsKey('message')) {
              errorMessage = responseData['message'];
            } else if (responseData is Map &&
                responseData.containsKey('error')) {
              errorMessage = responseData['error'];
            }
          } catch (_) {
            errorMessage = e.response!.statusMessage ?? errorMessage;
          }
        } else if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = "Koneksi timeout. Silakan coba lagi.";
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage =
              "Tidak dapat terhubung ke server. Periksa koneksi internet Anda.";
        }
      }

      emit(LoginError(errorMessage));
    }
  }

  Future<String?> getToken() async {
    try {
      final token = await secureStorage.read("token");
      return token;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    final result = token != null && token.isNotEmpty;
    return result;
  }
}
