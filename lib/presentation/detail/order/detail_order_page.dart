import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/presentation/detail/transaction/result_transaction_page.dart';

class DetailOrderPage extends StatelessWidget {
  const DetailOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                          const Text(
                            'Paket Umrah Desa - Termasuk Madinah',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Colors.amber),
                              const SizedBox(width: 4),
                              const Text('VIP', style: TextStyle(fontSize: 12)),
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
                      children: const [
                        Text(
                          'Transaksi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '#4152436345',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildTransactionItem('Harga /Paket', 'Rp. 33.900.000'),
                    _buildTransactionItem('Jenis Paket', 'VIP'),
                    _buildTransactionItem('Jumlah Seat', '2 seat'),
                    _buildTransactionItem('Hotel', 'Hotel Hilton Makkah (B-5)'),
                    _buildTransactionItem('Penerbangan', 'Saudi Airlines'),
                    _buildTransactionItem('Bandara', 'Soekarno Hatta (CGK)'),
                    _buildTransactionItem('Tanggal Keberangkatan', '11 Desember 2025'),
                    _buildTransactionItem('Tanggal Pemesanan', '11 April 2025'),
                    const Divider(height: 24),
                    _buildTransactionItem('Sub Harga', 'Rp. 67.800.000'),
                    _buildTransactionItem('Promo', '-0'),
                    _buildTransactionItem('Diskon', '-0'),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Rp. 67.800.000',
                          style: TextStyle(
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
                child: const Text(
                  'Tidak ada catatan',
                  style: TextStyle(color: Colors.black54),
                ),
              ),

              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: const Text('Selesai'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                            transition: Transition.rightToLeft,
                            () => const ResultTransactionPage(),
                            duration: const Duration(milliseconds: 500));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child:  Text('Lihat Transaksi', style: TextStyle(
                        color: ColorConstant.secondary100,
                      ),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
