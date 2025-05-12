import 'package:flutter/material.dart';

class ConfirmPaymentPage extends StatelessWidget {
  const ConfirmPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konfirmasi Pembayaran")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Check Out", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Jumlah Pembayaran    Rp. 5.000.000"),
            const Text("Persentase    +3%"),
            const Text("Waktu Dibuat    1 Mei 2025, 09:00"),
            const Text("Promo    Tidak ada"),
            const SizedBox(height: 16),
            const Text("Metode Pembayaran"),
            const Text.rich(
              TextSpan(
                text: 'Metode pembayaran yang Anda pilih melalui ',
                children: [
                  TextSpan(
                    text: 'Virtual Account BCA',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '. Anda dapat mengganti metode pembayaran Anda di sini sebelum lanjut ketransaksi.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Card(
              child: ListTile(
                leading: Icon(Icons.account_balance),
                title: Text("BCA"),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Lanjutkan"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
