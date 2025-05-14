import 'package:flutter/material.dart';
import 'package:mobile_umroh_v2/constant/bank_option.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? selectedBank;

  String? selectedType;

  void onBankTap(String bankCode, String type, bool available) {
    if (!available) return;
    setState(() {
      selectedBank = bankCode;
      selectedType = type;
    });
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget buildBankTile({
    required String asset,
    required String code,
    required String type,
    required bool available,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BankOptionTile(
        logoAsset: asset,
        available: available,
        onTap: () => onBankTap(code, type, available),
        isSelected: selectedBank == code,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pilih metode pembayaran yang ingin Anda gunakan.",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 24),

                      buildSectionTitle("Transfer Bank"),
                      buildBankTile(
                        asset: 'assets/image/bca.png',
                        code: 'BNK_TF_BCA',
                        type: 'BNK_TF',
                        available: true,
                      ),
                      buildBankTile(
                        asset: 'assets/image/bri.png',
                        code: 'BNK_TF_BRI',
                        type: 'BNK_TF',
                        available: true,
                      ),
                      buildBankTile(
                        asset: 'assets/image/bni.png',
                        code: 'BNK_TF_BNI',
                        type: 'BNK_TF',
                        available: false,
                      ),

                      buildSectionTitle("Virtual Account"),
                      buildBankTile(
                        asset: 'assets/image/ovo.png',
                        code: 'VA_OVO',
                        type: 'VA',
                        available: true,
                      ),
                      buildBankTile(
                        asset: 'assets/image/dana.png',
                        code: 'VA_DANA',
                        type: 'VA',
                        available: true,
                      ),
                      // buildBankTile(
                      //   asset: 'assets/image/gopay.png',
                      //   code: 'VA_GOPAY',
                      //   type: 'VA',
                      //   available: true,
                      // ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: selectedBank == null
                      ? null
                      : () => Navigator.pop(context, {
                            "type": selectedType ?? "",
                            "code": selectedBank ?? "",
                          }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Pilih"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
