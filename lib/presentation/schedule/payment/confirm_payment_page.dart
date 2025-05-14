import 'package:flutter/material.dart';

class ConfirmPaymentPage extends StatefulWidget {
  final String? bankCode;
  final String? type;
  final String? amount;
  const ConfirmPaymentPage({super.key, required this.bankCode, required this.type, required this.amount});

  @override
  State<ConfirmPaymentPage> createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.bankCode);
    print(widget.type);
    print(widget.amount);
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {},
        ),
        title: const Text(
          'Konfirmasi Pembayaran',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                const Text(
                  'Check Out',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Konfirmasi pembayaran terlebih dahulu.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 12),
                _buildInfoField('Jumlah Pembayaran', 'Rp. 5.000.000'),
                _buildInfoField('Presentase', '+3%'),
                _buildInfoField('Waktu Dibuat', '1 Mei 2025, 09:00'),
                _buildInfoField('Promo', 'Tidak ada'),
                const SizedBox(height: 24),
                const Text(
                  'Metode Pembayaran',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Metode pembayaran yang Anda pilih melalui ',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      TextSpan(
                        text: 'Virtual Account BCA.',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text:
                            ' Anda dapat mengganti metode pembayaran Anda disini sebelum lanjut ketransaksi',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              //   GestureDetector(
              //     onTap: () {
              //       // Navigate to payment method selector
              //     },
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 16, vertical: 12),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(12),
              //         color: Colors.white,
              //         border: Border.all(color: Colors.grey.shade200),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.black12.withOpacity(0.05),
              //             blurRadius: 8,
              //             offset: const Offset(0, 4),
              //           )
              //         ],
              //       ),
              //       child: Row(
              //         children: [
              //           Image.network(
              //             'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/BCA_logo.svg/512px-BCA_logo.svg.png',
              //             height: 32,
              //           ),
              //           const Spacer(),
              //           const Icon(Icons.arrow_forward_ios, size: 16),
              //         ],
              //       ),
              //     ),
              //   ),
              // ],
        ]),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF77B8FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              onPressed: () {
                // lanjutkan ke pembayaran
              },
              child: const Text(
                'Lanjutkan',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade100),
      
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
                color: Colors.black87, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
