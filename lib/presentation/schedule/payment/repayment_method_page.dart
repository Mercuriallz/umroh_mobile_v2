import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';

class RepaymentMethodPage extends StatelessWidget {
  RepaymentMethodPage({super.key});

  final TextEditingController amountController = TextEditingController(text: '5000000');
  final TextEditingController voucherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
    final double target = 67800000;
    final double collected = 2824000;
    final double percentage = (collected / target * 100).floorToDouble();

    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                CustomBackHeader(title: "Pembayaran", onBack: () => Navigator.pop(context)),
              const SizedBox(height: 20),
              _buildTargetSection(formatter, collected, target, percentage),
              const SizedBox(height: 32),
              const Text('Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              const Text(
                'Masukkan jumlah yang ingin dibayarkan',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              _buildAmountInput(),
              const SizedBox(height: 12),
              _buildVoucherInput(),
              const SizedBox(height: 24),
              _buildPaymentMethodSelector(context),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Lanjutkan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTargetSection(NumberFormat formatter, double collected, double target, double percentage) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Target'),
          Text(
            formatter.format(target),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: collected / target,
            minHeight: 6,
            backgroundColor: const Color(0xFFE0ECFB),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 16),
          _infoRow('Terkumpul', formatter.format(collected)),
          _infoRow('Persentase Terkumpul', '${percentage.toStringAsFixed(0)}%'),
          _infoRow('Selesaikan Sebelum', '11 November 2025'),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return Stack(
      children: [
        TextFormField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 12, right: 4),
              child: Center(child: Text('Rp.', style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
          ),
        ),
        const Positioned(
          right: 20,
          top: 16,
          child: Text('+3%', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget _buildVoucherInput() {
    return TextFormField(
      controller: voucherController,
      decoration: InputDecoration(
        hintText: 'Kode voucher (Opsional)',
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildPaymentMethodSelector(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman pilih metode pembayaran
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Pilih metode pembayaran', style: TextStyle(color: Colors.black54)),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
