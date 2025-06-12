import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

import '../presentation/auth/login_page.dart';

class SupervisorPage extends StatelessWidget {
  const SupervisorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Supervisor Page")),
      body: Column(
        children: [
          const Center(child: Text("Welcome, Area Manager!")),
         ElevatedButton(
      onPressed: () {
        final secureStorage = SecureStorageService();
        secureStorage.deleteAll();
        Get.offAll(const LoginPage());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        minimumSize: const Size(double.infinity, 48),
      ),
      child: const Text('Log Out', style: TextStyle(color: Colors.red)),
    )
        ],
      ),
    );
  }
}
