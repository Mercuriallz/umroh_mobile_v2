import 'package:flutter/material.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/bottombar/bottom_bar.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_outline,
                    size: 80, color: Color(0xFF5687BF)),
                const SizedBox(height: 20),
                const Text(
                  "Pembayaran Berhasil!",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5687BF)),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Terima kasih telah melakukan pembayaran.\nTransaksi Anda sedang diproses.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (_) => const BottomMain()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5687BF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text(
                      "Kembali ke Beranda",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
