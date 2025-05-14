import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:mobile_umroh_v2/presentation/schedule/payment/payment_method_page.dart';

class RupiahInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String cleaned = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.isEmpty) cleaned = '0';
    int value = int.parse(cleaned);
    final newText = _formatter.format(value);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class RepaymentMethodPage extends StatefulWidget {
  const RepaymentMethodPage({super.key});

  @override
  State<RepaymentMethodPage> createState() => _RepaymentMethodPageState();
}

class _RepaymentMethodPageState extends State<RepaymentMethodPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController voucherController = TextEditingController();

  String? selectedMethodCode;
  String? selectedMethodType;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );
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
              // Custom Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Pembayaran",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Target Section
              Container(
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
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: collected / target,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFE0ECFB),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    const SizedBox(height: 16),
                    _infoRow('Terkumpul', formatter.format(collected)),
                    _infoRow('Persentase Terkumpul',
                        '${percentage.toStringAsFixed(0)}%'),
                    _infoRow('Selesaikan Sebelum', '11 November 2025'),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                'Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'Masukkan jumlah yang ingin dibayarkan',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),

              // Amount Input
              TextFormField(
                inputFormatters: [RupiahInputFormatter()],
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Jumlah Pembayaran",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  prefixIcon: const Icon(Icons.payments_outlined),
                  suffixText: "IDR",
                ),
              ),
              const SizedBox(height: 12),

              // Voucher Input
              TextFormField(
                controller: voucherController,
                decoration: InputDecoration(
                  hintText: 'Kode voucher (Opsional)',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Payment Method Selector
              InkWell(
                onTap: () async {
                  final result = await Navigator.push<Map<String, String>>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PaymentMethodPage(),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      selectedMethodCode = result['code'];
                      selectedMethodType = result['type'];
                    });
                    print(
                        "Selected method: ${result['type']} - ${result['code']}");
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedMethodCode != null
                            ? getBankDisplayName(selectedMethodCode!)
                            : 'Pilih metode pembayaran',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        selectedMethodCode != null
                            ? Icons.check_circle
                            : Icons.chevron_right,
                        color: selectedMethodCode != null
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
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

  String getBankDisplayName(String code) {
    if (code == 'BNK_TF_BCA') {
      return 'Transfer Bank BCA';
    } else if (code == 'BNK_TF_BRI') {
      return 'Transfer Bank BRI';
    } else if (code == 'BNK_TF_BNI') {
      return 'Transfer Bank BNI';
    } else if (code == 'VA_OVO') {
      return 'Virtual Account OVO';
    } else if (code == 'VA_DANA') {
      return 'Virtual Account DANA';
    } else if (code == 'VA_GOPAY') {
      return 'Virtual Account GoPay';
    } else {
      return 'Metode tidak dikenal';
    }
  }
}
