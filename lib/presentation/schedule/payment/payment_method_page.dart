import 'package:flutter/material.dart';
import 'package:mobile_umroh_v2/presentation/schedule/payment/confirm_payment_page.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> banks = ["BCA", "BANK BRI"];

    return Scaffold(
      appBar: AppBar(title: const Text("Metode Pembayaran")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pilih metode pembayaran yang ingin Anda gunakan."),
            const SizedBox(height: 16),
            for (var bank in banks)
              Card(
                child: ListTile(
                  leading: Icon(Icons.account_balance),
                  title: Text(bank),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ConfirmPaymentPage()));
                  },
                ),
              ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text("BNI"),
                trailing: Text("Tidak tersedia", style: TextStyle(color: Colors.grey)),
              ),
            ),
            const Text("Tampilkan semua Bank", style: TextStyle(color: Colors.blue)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Pilih"),
              ),
            )
          ],
        ),
      ),
    );
  }
}