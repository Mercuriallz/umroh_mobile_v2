import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';

class OnProgressPage extends StatelessWidget {
  const OnProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: CustomBackHeader(
                  title: "Kembali",
                  onBack: () => Navigator.pop(context),
                ),
              ),
              Center(
                  child: Lottie.asset(
                "assets/lottie/on_progress.json",
                width: 400,
                height: 400,
                frameRate: FrameRate.max,
                repeat: true
              )),
              Text(
                "Fitur sedang dibuat",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
