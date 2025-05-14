import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get.dart' as gets;

import 'package:mobile_umroh_v2/bloc/payment/payment_state.dart';
import 'package:mobile_umroh_v2/bloc/payment/payment_bloc.dart';
import 'package:mobile_umroh_v2/bloc/transaction/transaction_detail/transaction_detail_bloc.dart';
import 'package:mobile_umroh_v2/bloc/transaction/transaction_detail/transaction_detail_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/model/transaction/transaction_detail_model.dart';
import 'package:mobile_umroh_v2/presentation/bottombar/bottom_bar.dart';
import 'package:mobile_umroh_v2/presentation/detail/transaction/result_transaction_page.dart';

class DetailOrderPage extends StatefulWidget {
  const DetailOrderPage({super.key});

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  
 @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final paymentState = context.read<PaymentBloc>().state;
    if (paymentState is PaymentDataLoaded) {
      final trx = paymentState.dataModel.trx;
      if (trx != null) {
        context.read<TransactionDetailBloc>().getTransactionDetail(trx);
      }
    }
  });
}
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
          builder: (context, state) {
             if (state is TransactionDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is TransactionDetailLoaded) {
              return _buildTransactionDetails(state.transactionDetailModel);
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildTransactionDetails(DataTransactionDetail transactionDetail) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Pemesanan Selesai',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Image.asset(
            'assets/icons/check.png',
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 24),
          const Text(
            'Selamat pemesanan Anda telah selesai. Segera lanjutkan pembayaran melalui menu Jadwal. Pastikan pembayaran lunas 2 bulan sebelum jadwal keberangkatan.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 32),

          // Card Paket
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/image/kabah.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactionDetail.paketName ?? 'Paket Umrah Desa - Termasuk Madinah',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(transactionDetail.paketClass ?? 'VIP', style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.flight_takeoff, size: 16),
                          const SizedBox(width: 8),
                          const Icon(Icons.directions_bus, size: 16),
                          const SizedBox(width: 8),
                          const Icon(Icons.hotel, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Card Transaksi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Transaksi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   '#${transactionDetail.id ?? '4152436345'}',
                    //   style: const TextStyle(color: Colors.black54),
                    // ),
                  ],
                ),
                const Divider(height: 24),
                _buildTransactionItem('Harga /Paket', 'Rp. ${transactionDetail.pricePaket ?? '33.900.000'}'),
                _buildTransactionItem('Jenis Paket', transactionDetail.paketClass ?? 'VIP'),
                _buildTransactionItem('Jumlah Seat', '${transactionDetail.amountSeat ?? '2'} seat'),
                _buildTransactionItem('Hotel', transactionDetail.hotelName ?? 'Hotel Hilton Makkah (B-5)'),
                _buildTransactionItem('Penerbangan', transactionDetail.airplaneName ?? 'Saudi Airlines'),
                _buildTransactionItem('Bandara', transactionDetail.airportName ?? 'Soekarno Hatta (CGK)'),
                _buildTransactionItem(
                    'Tanggal Keberangkatan', transactionDetail.tanggalKeberangkatan ?? '11 Desember 2025'),
                _buildTransactionItem('Tanggal Pemesanan', transactionDetail.tanggalPemesanan ?? '11 April 2025'),
                const Divider(height: 24),
                _buildTransactionItem('Sub Harga', 'Rp. ${transactionDetail.finalPrice ?? '67.800.000'}'),
                // _buildTransactionItem('Promo', '-${transactionDetail.promo ?? '0'}'),
                // _buildTransactionItem('Diskon', '-${transactionDetail.diskon ?? '0'}'),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp. ${transactionDetail.finalPrice ?? '67.800.000'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Catatan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              transactionDetail.notes?.isNotEmpty == true 
                  ? transactionDetail.notes! 
                  : 'Tidak ada catatan',
              style: const TextStyle(color: Colors.black54),
            ),
          ),

          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.offAll(BottomMain());
                  },
                  child: const Text('Selesai'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                        transition: gets.Transition.rightToLeft,
                        () => const ResultTransactionPage(),
                        duration: const Duration(milliseconds: 500));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Lihat Transaksi',
                    style: TextStyle(
                      color: ColorConstant.secondary100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.black87)),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}