import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';
import 'package:mobile_umroh_v2/presentation/schedule/payment/repayment_method_page.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                CustomBackHeader(title: "Informasi Transaksi", onBack: () => Navigator.pop(context)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text('Target', style: TextStyle(fontSize: 14)),
                    ),
                    const Center(
                      child: Text(
                        'Rp. 67.800.000',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const LinearProgressIndicator(
                      value: 2824000 / 67800000,
                      minHeight: 6,
                      backgroundColor: Color(0xFFE0ECFB),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Terkumpul', style: TextStyle(color: Colors.grey)),
                        Text('Rp. 2.824.000'),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Selesaikan Sebelum', style: TextStyle(color: Colors.grey)),
                        Text('11 November 2025'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Histori Transaksi (4)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Column(
                children: _buildTransactionHistory(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Get.to(RepaymentMethodPage());
                  },
                  child: const Text('Tambahkan Transaksi'),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
    );
  }

  List<Widget> _buildTransactionHistory() {
    final List<Map<String, dynamic>> history = [
      {'amount': 2000000, 'date': DateTime(2025, 5, 1, 9, 0)},
      {'amount': 400000, 'date': DateTime(2025, 5, 1, 9, 0)},
      {'amount': 400000, 'date': DateTime(2025, 5, 1, 9, 0)},
      {'amount': 24000, 'date': DateTime(2025, 5, 1, 9, 0)},
    ];


    return history.map((tx) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rp. ${tx['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('dd MMMM yyyy').format(tx['date']),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Text(
              'Transaksi Berhasil',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      );
    }).toList();
  }
}
