import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_umroh_v2/constant/success.dart';

class OrderLoadingPage extends StatefulWidget {
  const OrderLoadingPage({super.key});

  @override
  State<OrderLoadingPage> createState() => _OrderLoadingPageState();
}

class _OrderLoadingPageState extends State<OrderLoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OrderSuccessPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/loading_animation.json',
              width: 200,
              height: 200,
              frameRate: FrameRate.max
            ),
            const SizedBox(height: 24),
            const Text(
              "Pesanan Anda Sedang Diproses...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}