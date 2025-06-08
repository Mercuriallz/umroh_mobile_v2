// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:get/get.dart' as gets;

// import 'package:mobile_umroh_v2/bloc/payment/payment_state.dart';
// import 'package:mobile_umroh_v2/bloc/payment/payment_bloc.dart';
// import 'package:mobile_umroh_v2/bloc/transaction/transaction_detail/transaction_detail_bloc.dart';
// import 'package:mobile_umroh_v2/bloc/transaction/transaction_detail/transaction_detail_state.dart';
// import 'package:mobile_umroh_v2/constant/color_constant.dart';
// import 'package:mobile_umroh_v2/constant/rupiah.dart';
// import 'package:mobile_umroh_v2/model/transaction/transaction_detail_model.dart';
// import 'package:mobile_umroh_v2/presentation/bottombar/bottom_bar.dart';
// import 'package:mobile_umroh_v2/presentation/detail/transaction/result_transaction_page.dart';

// class DetailOrderPage extends StatefulWidget {
//   const DetailOrderPage({super.key});

//   @override
//   State<DetailOrderPage> createState() => _DetailOrderPageState();
// }

// class _DetailOrderPageState extends State<DetailOrderPage> {
//   @override
//   void initState() {
//     super.initState();

//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   final paymentState = context.read<PaymentBloc>().state;
//     //   if (paymentState is PaymentDataLoaded) {
//     //     final trx = paymentState.dataModel.trx;
//     //     if (trx != null) {
//     //       context.read<TransactionDetailBloc>().getTransactionDetail(trx);
//     //     }
//     //   }
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
//           builder: (context, state) {
//             if (state is TransactionDetailLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is TransactionDetailError) {
//               return Center(child: Text('Error: ${state.message}'));
//             } else if (state is TransactionDetailLoaded) {
//               return _buildTransactionDetails(state.transactionDetailModel);
//             } else {
//               return const Center(child: Text('Unknown state'));
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildTransactionDetails(DataTransactionDetail transactionDetail) {
//     final rupiahConverter = RupiahConverter();
//     final features = transactionDetail.paketAdditionalFeature
//             ?.map((e) => e.toLowerCase())
//             .toList() ??
//         [];

//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text(
//             'Pemesanan Selesai',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 24),
//           Image.asset(
//             'assets/icons/check.png',
//             width: 120,
//             height: 120,
//           ),
//           const SizedBox(height: 24),
//           const Text(
//             'Selamat pemesanan Anda telah selesai. Segera lanjutkan pembayaran melalui menu Jadwal. Pastikan pembayaran lunas 2 bulan sebelum jadwal keberangkatan.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.black54,
//               fontSize: 14,
//             ),
//           ),
//           const SizedBox(height: 32),

//           // Card Paket
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 6,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.asset(
//                     'assets/image/kabah.png',
//                     width: 60,
//                     height: 60,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         transactionDetail.paketName ?? '-',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       transactionDetail.paketClass == "VIP"
//                           ? Row(
//                               children: [
//                                 const Icon(Icons.star,
//                                     size: 16, color: Colors.amber),
//                                 const SizedBox(width: 4),
//                                 Text(transactionDetail.paketClass ?? 'VIP',
//                                     style: const TextStyle(fontSize: 12)),
//                               ],
//                             )
//                           : Text("Reguler"),
//                       const SizedBox(height: 8),
//                       Wrap(
//                         spacing: 8,
//                         runSpacing: 8,
//                         children: [
//                           if (features.contains("pesawat"))
//                             _buildIconText(Icons.flight_takeoff, "Pesawat"),
//                           if (features.contains("antar"))
//                             _buildIconText(Icons.directions_car, "Antar"),
//                           if (features.contains("hotel"))
//                             _buildIconText(Icons.hotel, "Hotel"),
//                           if (features.contains("bis"))
//                             _buildIconText(Icons.directions_bus, "Bus"),
//                           if (features.contains("konsumsi"))
//                             _buildIconText(Icons.food_bank, "Konsumsi"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 24),

//           // Card Transaksi
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 6,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Transaksi',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     // Text(
//                     //   '#${transactionDetail.id ?? '4152436345'}',
//                     //   style: const TextStyle(color: Colors.black54),
//                     // ),
//                   ],
//                 ),
//                 const Divider(height: 24),
//                 _buildTransactionItem(
//                     'Transaksi', transactionDetail.transaksiTrx ?? "-"),
//                 _buildTransactionItem(
//                     'Harga /Paket',
//                     rupiahConverter.formatToRupiah(
//                         int.tryParse('${transactionDetail.pricePaket}') ?? 0)),
//                 _buildTransactionItem('Jenis Paket',
//                     transactionDetail.paketClass == "VIP" ? "VIP" : "Reguler"),
//                 _buildTransactionItem('Jumlah Seat',
//                     '${transactionDetail.amountSeat ?? '2'} seat'),
//                 _buildTransactionItem('Hotel',
//                     transactionDetail.hotelName ?? 'Hotel Hilton Makkah (B-5)'),
//                 _buildTransactionItem('Penerbangan',
//                     transactionDetail.airplaneName ?? 'Saudi Airlines'),
//                 _buildTransactionItem('Bandara',
//                     transactionDetail.airportName ?? 'Soekarno Hatta (CGK)'),
//                 _buildTransactionItem(
//                     'Tanggal Keberangkatan',
//                     transactionDetail.tanggalKeberangkatan ??
//                         '11 Desember 2025'),
//                 _buildTransactionItem('Tanggal Pemesanan',
//                     transactionDetail.tanggalPemesanan ?? '11 April 2025'),
//                 const Divider(height: 24),
//                 _buildTransactionItem(
//                     'Sub Harga',
//                     rupiahConverter.formatToRupiah(
//                         int.tryParse('${transactionDetail.finalPrice}') ?? 0)),
//                 // _buildTransactionItem('Promo', '-${transactionDetail.promo ?? '0'}'),
//                 // _buildTransactionItem('Diskon', '-${transactionDetail.diskon ?? '0'}'),
//                 const Divider(height: 24),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Total',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       rupiahConverter.formatToRupiah(
//                           int.tryParse('${transactionDetail.finalPrice}') ?? 0),
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 24),

//           // Catatan
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Text(
//               transactionDetail.notes?.isNotEmpty == true
//                   ? transactionDetail.notes!
//                   : 'Tidak ada catatan',
//               style: const TextStyle(color: Colors.black54),
//             ),
//           ),

//           const SizedBox(height: 32),

//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: () {
//                     // final paymentState = context.read<PaymentBloc>().state;
//                     // String? trx;
//                     // if (paymentState is PaymentDataLoaded) {
//                     //   trx = paymentState.dataModel.trx;
//                     // }

//                     Get.offAll(() => BottomMain());
//                   },
//                   child: const Text('Selesai'),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Get.to(
//                         transition: gets.Transition.rightToLeft,
//                         () => const ResultTransactionPage(),
//                         duration: const Duration(milliseconds: 500));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorConstant.primaryBlue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: Text(
//                     'Lihat Transaksi',
//                     style: TextStyle(
//                       color: ColorConstant.secondary100,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTransactionItem(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               title,
//               style: const TextStyle(color: Colors.black87),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value,
//               style: const TextStyle(
//                   color: Colors.black87, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.right,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildIconText(IconData icon, String text) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(8),
//       color: Colors.white,
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 16),
//         const SizedBox(width: 4),
//         Text(
//           text,
//           style: const TextStyle(fontSize: 12),
//         ),
//       ],
//     ),
//   );
// }
