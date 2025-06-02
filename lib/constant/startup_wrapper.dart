// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobile_umroh_v2/constant/on_boarding/on_boarding_main.dart';
// import 'package:mobile_umroh_v2/constant/transaction_helper.dart';
// import 'package:mobile_umroh_v2/presentation/schedule/payment/transaction/transaction_page.dart';

// class StartupWrapper extends StatefulWidget {
//   const StartupWrapper({super.key});

//   @override
//   State<StartupWrapper> createState() => _StartupWrapperState();
// }

// class _StartupWrapperState extends State<StartupWrapper> {
//   @override
//   void initState() {
//     super.initState();

//     // Cek apakah ada transaksi pending setelah build selesai
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await _checkPendingTransactionOrRedirect();
//     });
//   }

//   Future<void> _checkPendingTransactionOrRedirect() async {
//     final hasTransaction = await TransactionHelper.hasPendingTransaction();
//     if (hasTransaction) {
//       await TransactionHelper.checkAndNavigateToPendingTransaction();
//     } else {
//       // Kalau tidak ada transaksi, arahkan ke halaman awal normal
//       Get.offAll(() => const OnBoardingMain());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Bisa ganti loading UI kalau mau
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
