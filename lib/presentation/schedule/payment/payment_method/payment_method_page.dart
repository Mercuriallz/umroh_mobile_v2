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
  String? selectedBankName;
  String? selectedType;

  void onBankTap(String bankCode, String type, String name, bool available) {
    if (!available) return;
    setState(() {
      selectedBank = bankCode;
      selectedType = type;
      selectedBankName = name;
    });
  }

  // void onQrisTap() async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) => const QRISScannerPage()),
  //   );

  //   if (result != null) {
  //     Navigator.pop(context, result);
  //   }
  // }

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
    required String name,
    required bool available,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BankOptionTile(
        logoAsset: asset,
        available: available,
        onTap: () => onBankTap(code, type, name, available),
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
                        name: 'Bank Central Asia',
                        available: true,
                      ),
                      buildBankTile(
                        asset: 'assets/image/bri.png',
                        code: 'BNK_TF_BRI',
                        type: 'BNK_TF',
                        name: 'Bank Rakyat Indonesia',
                        available: true,
                      ),
                      buildBankTile(
                        asset: 'assets/image/bni.png',
                        code: 'BNK_TF_BNI',
                        type: 'BNK_TF',
                        name: 'Bank Negara Indonesia',
                        available: false,
                      ),

                      buildSectionTitle("Virtual Account"),
                      buildBankTile(
                        asset: 'assets/image/ovo.png',
                        code: 'VA_OVO',
                        type: 'VA',
                        name: 'Virtual Account OVO',
                        available: true,
                      ),
                      buildBankTile(
                        asset: 'assets/image/dana.png',
                        code: 'VA_DANA',
                        type: 'VA',
                        name: 'Virtual Account DANA',
                        available: true,
                      ),

                        //  buildSectionTitle("QR"),

                      // GestureDetector(
                      //   onTap: () async {
                      //     final result = await Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const QRISScannerPage(),
                      //       ),
                      //     );

                      //     if (result != null && result is String) {
                      //       // tampilkan hasil QR di dialog misalnya
                      //       showDialog(
                      //         context: context,
                      //         builder: (_) => AlertDialog(
                      //           title: const Text('Hasil Scan QRIS'),
                      //           content: Text(result),
                      //           actions: [
                      //             TextButton(
                      //               onPressed: () => Navigator.pop(context),
                      //               child: const Text('OK'),
                      //             )
                      //           ],
                      //         ),
                      //       );
                      //     }
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.all(16),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.grey.shade300),
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Image.asset('assets/image/qris_new.png', width: 40,),
                      //         const SizedBox(width: 12),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // // buildBankTile(
                      // //   asset: 'assets/image/gopay.png',
                      // //   code: 'VA_GOPAY',
                      // //   type: 'VA',
                      // //   available: true,
                      // // ),
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
                            "name": selectedBankName ?? "",
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
