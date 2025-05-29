import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as gets;
import 'package:get/get.dart' as getx;
import 'package:mobile_umroh_v2/bloc/auth/login/login_bloc.dart';
import 'package:mobile_umroh_v2/bloc/auth/login/login_state.dart';
import 'package:mobile_umroh_v2/constant/loading.dart';
import 'package:mobile_umroh_v2/model/auth/login/login_chief_request_model.dart';
import 'package:mobile_umroh_v2/model/auth/login/login_request_model.dart';
import 'package:mobile_umroh_v2/presentation/auth/register/register_page.dart';
import 'package:mobile_umroh_v2/presentation/bottombar/bottom_bar.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

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

  final List<String> roles = ['User', 'Kepala Desa'];
  String? selectedRole = 'User';

  void _login() {
    if (formKey.currentState!.validate()) {
      if (selectedRole == 'User') {
        final loginRequest = LoginRequestModel(
          email: emailController.text,
          password: passwordController.text,
        );
        context.read<LoginBloc>().login(formData: loginRequest);
      } else {
        final loginRequest = LoginChiefRequestModel(
          username: emailController.text,
          password: passwordController.text,
        );
        context.read<LoginBloc>().loginChief(formData: loginRequest);
      }

          // print('Login sebagai: $selectedRole');
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

    return 
    BlocListener<LoginBloc, LoginState>(
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
          
         gets.Get.offAll(BottomMain());
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
        :
    
    Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
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
                    style: TextStyle(fontSize: 12, color: Colors.black54),
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
                                // Dropdown untuk memilih role

                         DropdownButtonFormField<String>(
                                  value: selectedRole,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    filled: true,
                                    fillColor: const Color(0xFFF2F4F7),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  items: roles
                                      .map((role) => DropdownMenuItem(
                                            value: role,
                                            child: Text(role),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRole = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 12),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Username/E-mail/NIK",
                            contentPadding: const EdgeInsets.symmetric(
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
                            contentPadding: const EdgeInsets.symmetric(
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
                                  _obscurePassword = !_obscurePassword;
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
                              backgroundColor: const Color(0xFF70B8FF),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            child: const Text(
                              "Lanjutkan",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Tidak punya akun?"),
                      TextButton(
                        onPressed: () {
                          gets.Get.to(
                              transition: getx.Transition.rightToLeft,
                              () => const RegisterPage(),
                              duration: const Duration(milliseconds: 500));
                        },
                        child: const Text("Daftar"),
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
