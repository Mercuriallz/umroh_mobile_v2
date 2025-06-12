import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_umroh_v2/area-manager/bloc/list_area_manager_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/auth/login/login_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/auth/register/register_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/package/package/package_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/package/package_active/package_active_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/package/package_id/package_id_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/payment/payment_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/profile/get_profile/profile_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/profile/upload/upload_profile_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/region/kabupaten/kabupaten_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/region/kecamatan/kecamatan_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/region/kelurahan/kelurahan_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/region/provinsi/provinsi_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/transaction/payment/payment_transaction_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/transaction/transaction/detail/self_transaction_detail_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/transaction/transaction/self_transaction_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/transaction/transaction_detail/transaction_detail_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/transaction/upload/upload_bloc.dart';
import 'package:mobile_umroh_v2/constant/on_boarding/on_boarding_main.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/transaction/payment/payment_transaction_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/schedule/payment/transaction/transaction_page.dart';
import 'package:mobile_umroh_v2/regional-manager/bloc/list-regional-manager/list_regional_manager_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode) {
    await dotenv.load(fileName: ".env.production");
  } else {
    await dotenv.load(fileName: ".env.development");
  }

  final prefs = await SharedPreferences.getInstance();
  bool isOngoing = prefs.getBool('isTransactionOngoing') ?? false;

  String? trxId = prefs.getString('trxId');
  String? vaNumber = prefs.getString('vaNumber');
  String? amount = prefs.getString('amount');

  // final secureStorage = SecureStorageService();
  // final token = await secureStorage.read("token");

  // if (token != null) {
  //   debugPrint("📦 Token ditemukan: $token");
  //   SocketService().connect(token: token);
  // } else {
  //   debugPrint("🔒 Token belum tersedia, user belum login");
  // }

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => LoginBloc()),
      BlocProvider(create: (_) => PackageBloc()),
      BlocProvider(create: (_) => ProvinsiBloc()),
      BlocProvider(create: (_) => KabupatenBloc()),
      BlocProvider(create: (_) => KecamatanBloc()),
      BlocProvider(create: (_) => KelurahanBloc()),
      BlocProvider(create: (_) => RegisterBloc()),
      BlocProvider(create: (_) => PaymentBloc()),
      BlocProvider(create: (_) => TransactionDetailBloc()),
      BlocProvider(create: (_) => SelfTransactionBloc()),
      BlocProvider(create: (_) => PackageIdBloc()),
      BlocProvider(create: (_) => SelfTransactionDetailBloc()),
      BlocProvider(create: (_) => PaymentTransactionBloc()),
      BlocProvider(create: (_) => UploadBloc()),
      BlocProvider(create: (_) => PackageActiveBloc()),
      BlocProvider(create: (_) => UploadProfileBloc()),
      BlocProvider(create: (_) => ProfileBloc()),
      BlocProvider(create: (_) => ListRegionalManagerBloc()),
      BlocProvider(create: (_) => ListAreaManagerBloc()),
      

      // BlocProvider(create: (_) => LoginAreaManagerBloc()),
      // BlocProvider(create: (_) => LoginRegionalManagerBloc()),
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isOngoing && trxId != null
          ? TransactionPage(
              paymentData: PaymentData(
                trxId: trxId,
                vaNumber: vaNumber,
                amount: amount,
              ),
            )
          : OnBoardingMain(),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: false,
      ),
    ),
  ));
}
