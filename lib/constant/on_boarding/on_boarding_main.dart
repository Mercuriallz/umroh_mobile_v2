import 'package:flutter/material.dart';
import 'package:mobile_umroh_v2/constant/on_boarding/on_boarding_screen.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/bottombar/bottom_bar.dart';
import 'package:mobile_umroh_v2/regional-manager/presentation/regional_manager_home_page.dart';
import 'package:mobile_umroh_v2/services/storage.dart';
import 'package:mobile_umroh_v2/area-manager/presentation/area_manager_home_page.dart';

class OnBoardingMain extends StatefulWidget {
  const OnBoardingMain({super.key});

  @override
  State<OnBoardingMain> createState() => _OnBoardingMainState();
}

class _OnBoardingMainState extends State<OnBoardingMain> {
  final secureStorage = SecureStorageService();
  bool _isLoading = true;
  bool _isLoggedIn = false;
  String? _token;
  String? _role;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final token = await secureStorage.read("token");
    final isLoggedIn = await secureStorage.readBool("login") ?? false;
    final role = await secureStorage.read("role");

    setState(() {
      _token = token;
      _isLoggedIn = isLoggedIn;
      _role = role;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_token != null && _isLoggedIn) {
      if (_role == '8') {
        return const AreaManagerHomePage();
      } else if (_role == '7') {
        return const RegionalManagerHomePage();
      } else if (_role == '2' || _role == '11') {
        return const BottomMain();
      }
    }

    return const OnBoardingScreen();
  }
}
