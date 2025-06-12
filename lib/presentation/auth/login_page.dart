import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as gets;
import 'package:get/get.dart' as getx;
import 'package:mobile_umroh_v2/bloc/auth/login/login_bloc.dart';
import 'package:mobile_umroh_v2/bloc/auth/login/login_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/loading.dart';
import 'package:mobile_umroh_v2/model/auth/login/area-manager/area_manager_request_model.dart';
import 'package:mobile_umroh_v2/model/auth/login/chief/login_chief_request_model.dart';
import 'package:mobile_umroh_v2/model/auth/login/jemaah/login_request_model.dart';
import 'package:mobile_umroh_v2/model/auth/login/regional-manager/regional_manager_request_model.dart';
import 'package:mobile_umroh_v2/presentation/auth/register/register_page.dart';
import 'package:mobile_umroh_v2/presentation/bottombar/bottom_bar.dart';
import 'package:mobile_umroh_v2/services/storage.dart';
import 'package:mobile_umroh_v2/supervisor/supervisor_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  final secureStorage = SecureStorageService();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;
  bool showLoading = false;

  final List<String> roles = ['Jemaah', 'Mitra Desa', "Area Manager", "Regional Manager"];
  String? selectedRole = 'Jemaah';

  final roleHintMap = {
    "Mitra Desa": "Username",
    "Area Manager": "Username",
    "Jemaah": "NIK",
    "Regional Manager": "Regional Manager"
  };

  void _login() {
    if (formKey.currentState!.validate()) {
      if (selectedRole == 'Jemaah') {
        final loginRequest = LoginRequestModel(
          nik: emailController.text,
          password: passwordController.text,
        );
        context.read<LoginBloc>().login(formData: loginRequest);
      } else if (selectedRole == "Area Manager") {
        final loginRequest = LoginAreaManagerRequestModel(
          username: emailController.text,
          password: passwordController.text,
        );
        context.read<LoginBloc>().loginAreaManager(formData: loginRequest);
      } else if (selectedRole == "Regional Manager") {

         final loginRequest = LoginRegionalManagerRequestModel(
          username: emailController.text,
          password: passwordController.text,
        );
        context.read<LoginBloc>().loginRegionalManager(formData: loginRequest);
      } 
      
      else {
        final loginRequest = LoginChiefRequestModel(
          username: emailController.text,
          password: passwordController.text,
        );
        context.read<LoginBloc>().loginChief(formData: loginRequest);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is LoginLoading) {
            setState(() {
              showLoading = true;
            });
          } else if (state is LoginSuccess) {
            setState(() {
              showLoading = false;
            });

            secureStorage.writeBool("login", true);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login berhasil'),
                backgroundColor: Colors.green,
              ),
            );

            if (selectedRole == "Area Manager") {
              gets.Get.offAll(() => const SupervisorPage());
            } else {
              gets.Get.offAll(() => BottomMain());
            }
          } else if (state is LoginError) {
            setState(() {
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
                message: 'Sedang login...',
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Logo dan Judul
                            SizedBox(height: size.height * 0.05),
                            Image.asset(
                              'assets/image/logo-desa.jpg',
                              height: 100,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Umrah Desa",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Versi 1.0.0.1",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                            const SizedBox(height: 32),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                    offset: Offset(0, 6),
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Log In",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Login Sebagai",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  DropdownButtonFormField2<String>(
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness:
                                            WidgetStateProperty.all<double>(6),
                                        thumbVisibility:
                                            WidgetStateProperty.all<bool>(true),
                                        thumbColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.grey[400]!),
                                      ),
                                    ),
                                    value: selectedRole,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 16),
                                      filled: true,
                                      fillColor: const Color(0xFFF2F4F7),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(32),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      iconEnabledColor: Colors.grey,
                                    ),
                                    items: roles
                                        .map((role) => DropdownMenuItem<String>(
                                              value: role,
                                              child: Text(
                                                role,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRole = value!;
                                      });
                                    },
                                    hint: const Text(
                                      'Pilih Role',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    validator: (value) => value == null
                                        ? 'Role harus dipilih'
                                        : null,
                                  ),
                                  const SizedBox(height: 12),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      hintText:
                                          roleHintMap[selectedRole] ?? "Email",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(32),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFF2F4F7),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: passwordController,
                                    obscureText: _obscurePassword,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(32),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFF2F4F7),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        // Lupa password
                                      },
                                      child: const Text(
                                        "Lupa Password?",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _login();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorConstant.primaryBlue,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                      ),
                                      child: const Text(
                                        "Lanjutkan",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Tidak punya akun?"),
                                TextButton(
                                  onPressed: () {
                                    gets.Get.to(
                                        transition: getx.Transition.rightToLeft,
                                        () => const RegisterPage(),
                                        duration:
                                            const Duration(milliseconds: 500));
                                  },
                                  child:
                                      const Text("Daftar Sebagai Mitra Desa"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
  }
}
