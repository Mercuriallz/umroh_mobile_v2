import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/model/transaction/payment/payment_transaction_model.dart';

class TransactionPage extends StatefulWidget {
  final PaymentData paymentData;

  const TransactionPage({
    super.key,
    required this.paymentData,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    final currencyFormatter = RupiahConverter();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Transaksi',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Menunggu Pembayaran',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  'Kami harap Anda menyelesaikan pembayaran Anda\nsebelum ${'2 Mei 2025, 09:00'}.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                Text(
                  'Nomor Akun Virtual ${widget.paymentData.vaNumber ?? '0'}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.paymentData.vaNumber ?? '3827 1784 9023 0231',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF72B7FB),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    String vaNumberCopy =
                        (widget.paymentData.vaNumber ?? '3827178490230231')
                            .replaceAll(' ', '');
                    Clipboard.setData(ClipboardData(text: vaNumberCopy));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Nomor VA berhasil disalin!')),
                    );
                  },
                  child: const Text('Salin'),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'List Pembayaran',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Divider(height: 20),
                      _buildPaymentRow(
                          'Jumlah Pembayaran',
                          currencyFormatter.formatToRupiah(
                              int.parse(widget.paymentData.amount ?? '0') )),
                      // _buildPaymentRow(
                      //     'Jasa Layanan',
                      //     currencyFormatter
                      //         .formatToRupiah(int.parse('100.000'))),
                      _buildPaymentRow(
                        'Tanggal Dibuat',
                        DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now()),
                      ),
                      // _buildPaymentRow(
                      //     'Promo', widget.paymentData.promo ?? 'Tidak ada'),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Bayar',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                              currencyFormatter.formatToRupiah(
                                  int.parse(widget.paymentData.amount ?? '0') ),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue))
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.sim_card_alert_rounded,
                        color: Colors.redAccent, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Batalkan Transaksi?',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF72B7FB),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      // Implement check payment status
                    },
                    child: const Text('Cek Pembayaran'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
