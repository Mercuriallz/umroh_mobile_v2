import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_umroh_v2/bloc/transaction/upload/upload_bloc.dart';
import 'package:mobile_umroh_v2/bloc/transaction/upload/upload_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';
import 'package:mobile_umroh_v2/constant/loading.dart';
import 'package:mobile_umroh_v2/model/transaction/upload/upload_model.dart';
import 'package:mobile_umroh_v2/presentation/schedule/payment/upload/success_upload_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadPaymentProofPage extends StatefulWidget {
  final String? id;
  const UploadPaymentProofPage({super.key, this.id});

  @override
  State<UploadPaymentProofPage> createState() => _UploadPaymentProofPageState();
}

class _UploadPaymentProofPageState extends State<UploadPaymentProofPage> {
  File? _proofImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 20);

    if (pickedFile != null) {
      setState(() {
        _proofImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _clearTransactionState() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('isTransactionOngoing');
  await prefs.remove('trxId');
  await prefs.remove('vaNumber');
  await prefs.remove('amount');
}

  // void _uploadProof() {
  //   if (_proofImage == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Silakan pilih gambar terlebih dahulu.")),
  //     );
  //     return;
  //   }

  //   var formData = UploadModel(
  //     imgTrx: _proofImage,
  //   );

  //   context.read<UploadBloc>().uploadImage(
  //         widget.id ?? '',
  //         formData,
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    // print("ID Transaksi: ${widget.id}");
    return BlocListener<UploadBloc, UploadState>(
      listener: (context, state) {
        if (state is UploadSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PaymentSuccessPage()),
          );
        } else if (state is UploadError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          final isLoading = state is UploadLoading;

          return Stack(
            children: [
              Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CustomBackHeader(
                          onBack: () => Navigator.pop(context),
                          title: 'Unggah Bukti Pembayaran',
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Silakan unggah bukti transfer Anda untuk memproses pembayaran.',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        _proofImage != null
                            ? Image.file(_proofImage!, height: 200)
                            : Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.grey[200],
                                child: const Center(
                                    child: Text('Belum ada gambar')),
                              ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _pickImage(ImageSource.camera),
                                icon: const Icon(Icons.camera_alt),
                                label: const Text('Kamera'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.primaryBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            if (_proofImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Silakan pilih gambar terlebih dahulu.")),
                              );
                              return;
                            }

                            // Trigger the upload
                           var data = UploadModel(
                              imgTrx: _proofImage,
                            );
                            context.read<UploadBloc>().uploadImage(
                                 id: widget.id.toString(),
                                 formData: data,
                                );
                                await _clearTransactionState();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF72B7FB),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text("Upload Bukti Pembayaran"),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // Loading overlay
              if (isLoading)
                LoadingOverlay(
                    lottiePath: 'assets/lottie/loading_animation.json',
                    message: 'Unggah bukti pembayaran')
            ],
          );
        },
      ),
    );
  }
}
