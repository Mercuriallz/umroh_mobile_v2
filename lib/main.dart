import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_umroh_v2/bloc/auth/login/login_bloc.dart';
import 'package:mobile_umroh_v2/bloc/auth/register/register_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package/package_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package_id/package_id_bloc.dart';
import 'package:mobile_umroh_v2/bloc/payment/payment_bloc.dart';
import 'package:mobile_umroh_v2/bloc/region/kabupaten/kabupaten_bloc.dart';
import 'package:mobile_umroh_v2/bloc/region/kecamatan/kecamatan_bloc.dart';
import 'package:mobile_umroh_v2/bloc/region/kelurahan/kelurahan_bloc.dart';
import 'package:mobile_umroh_v2/bloc/region/provinsi/provinsi_bloc.dart';
import 'package:mobile_umroh_v2/bloc/transaction/transaction/self_transaction_bloc.dart';
import 'package:mobile_umroh_v2/bloc/transaction/transaction_detail/transaction_detail_bloc.dart';
import 'package:mobile_umroh_v2/constant/on_boarding/on_boarding_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode) {
    await dotenv.load(fileName: ".env.production");
  } else {
    await dotenv.load(fileName: ".env.development");
  }

  // final wsUrl = 'wss://ws.ifelse.io';
  final wsUrl = 'ws://umroh-be.floxy-it.cloud';
  // SocketService().connect(wsUrl);
  // SocketService.connect(wsUrl);

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
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingMain(),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: false,
      ),
    ),
  ));
}
