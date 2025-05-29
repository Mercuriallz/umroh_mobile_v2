import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/bloc/auth/register/register_bloc.dart';
import 'package:mobile_umroh_v2/bloc/auth/register/register_state.dart'; // Import state
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/loading.dart';
import 'package:mobile_umroh_v2/model/auth/register/register_kepdes_model.dart';
import 'package:mobile_umroh_v2/presentation/auth/login_page.dart';
import 'package:path_provider/path_provider.dart';

class SetPasswordPage extends StatefulWidget {
  final String? name;
  final String? selectedGender;
  final String? phoneNumber;
  final String? email;
  final String? selectedProvinsi;
  final String? selectedKabupaten;
  final String? selectedKecamatan;
  final String? selectedKelurahan;
  final File? ktpFile;
  final File? kkFile;
  final File? pasporFile;
  final File? vaksinFile;
  final String? ktp;
  final String? selectedDate;
  final String? address;
  final File? bpjsFile;
  final File? passPhotoFile;
  final String? username;

  const SetPasswordPage(
      {super.key,
      this.name,
      this.selectedGender,
      this.phoneNumber,
      this.email,
      this.selectedProvinsi,
      this.selectedKabupaten,
      this.selectedKecamatan,
      this.selectedKelurahan,
      this.ktpFile,
      this.kkFile,
      this.pasporFile,
      this.vaksinFile,
      this.ktp,
      this.selectedDate,
      this.address,
      this.bpjsFile,
      this.passPhotoFile,
      this.username});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureRepeatPassword = true;
  bool isLoading = false;
  bool showLoading = false;

  @override
  void dispose() {
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  var imageExtensions = ['jpg', 'jpeg', 'png'];

  bool isImageFile(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    return imageExtensions.contains(extension);
  }

  Future<void> removeCacheFoldersContainingImages() async {
    if (Platform.isAndroid) {
      try {
        final cacheDir = await getTemporaryDirectory();

        final files = cacheDir.listSync();

        for (final file in files) {
          if (file is File && isImageFile(file.path)) {
            try {
              file.deleteSync();
              if (kDebugMode) {
                print('Deleted image file: ${file.path}');
              }
            } catch (e) {
              if (kDebugMode) {
                print('Error deleting image file: ${file.path}, Error: $e');
              }
            }
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error accessing cache directory: $e');
        }
      }
    } else if (Platform.isIOS) {
      try {
        final appDocsDir = await getApplicationDocumentsDirectory();

        final iosTmpDirPath = "${appDocsDir.parent.path}/tmp";
        var dirIos = Directory(iosTmpDirPath);
        if (Directory(iosTmpDirPath).existsSync()) {
          final files = dirIos.listSync();
          for (final file in files) {
            if (file is File && isImageFile(file.path)) {
              try {
                file.deleteSync();
                if (kDebugMode) {
                  print('Deleted image file: ${file.path}');
                }
              } catch (e) {
                if (kDebugMode) {
                  print('Error deleting image file: ${file.path}, Error: $e');
                }
              }
            }
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error accessing cache directory: $e');
        }
      }
    }
  }

  void _submitRegistration() async {
    final registVM = context.read<RegisterBloc>();

    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      await removeCacheFoldersContainingImages();

      final data = RegisterKepdesModel(
        username: widget.username,
        password: passwordController.text,
        name: widget.name,
        // noTelp: widget.phoneNumber,
        // imgKtp: widget.ktpFile,
        // imgKk: widget.kkFile,
        // imgPassport: widget.pasporFile,
        // imgVaksin: widget.vaksinFile,
        // nik: widget.ktp,
        // address: widget.address,
        // imgBpjsKesehatan: widget.bpjsFile,
        // imgPasFoto: widget.passPhotoFile,
        idKabupaten: widget.selectedKabupaten,
        idKecamatan: widget.selectedKecamatan,
        idProvinsi: widget.selectedProvinsi,
        idKelurahan: widget.selectedKelurahan,
      );

      registVM.registerKepdes(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          setState(() {
            showLoading = true;
          });
        } else if (state is RegisterSuccess) {
          setState(() {
            isLoading = false;
            showLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registrasi berhasil'),
              backgroundColor: Colors.green,
            ),
          );

          Get.offAll(const LoginPage());
        } else if (state is RegisterFailed) {
          setState(() {
            isLoading = false;
            showLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: showLoading
          ? const LoadingOverlay(
              lottiePath: 'assets/lottie/loading_animation.json',
              message: 'Sedang memproses registrasi...',
            )
          : Scaffold(
              body: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(height: 10),
                            const Center(
                              child: Text(
                                'Set Password',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 100),
                            _buildPasswordField(
                              controller: passwordController,
                              label: 'Masukan Password',
                              obscure: obscurePassword,
                              onToggle: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                            _buildPasswordField(
                              controller: repeatPasswordController,
                              label: 'Ulangi Password',
                              obscure: obscureRepeatPassword,
                              onToggle: () {
                                setState(() {
                                  obscureRepeatPassword =
                                      !obscureRepeatPassword;
                                });
                              },
                              validator: (value) {
                                if (value != passwordController.text) {
                                  return 'Password tidak cocok';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 14),
                                children: [
                                  const TextSpan(
                                      text:
                                          'Dengan ini saya menyetujui segala '),
                                  TextSpan(
                                    text: 'Syarat dan Ketentuan',
                                    style: const TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                  const TextSpan(text: ' serta '),
                                  TextSpan(
                                    text: 'Kebijakan Privasi',
                                    style: const TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 60),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Kembali',
                                    style: TextStyle(fontSize: 16)),
                                isLoading
                                    ? const CircularProgressIndicator()
                                    : ElevatedButton(
                                        onPressed: _submitRegistration,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstant.primaryBlue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 12),
                                        ),
                                        child: const Text('Kirim'),
                                      ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              return null;
            },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          suffixIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }
}
