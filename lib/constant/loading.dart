import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingTransitionPage extends StatefulWidget {
  final String lottiePath;
  final String message;
  final Duration duration;
  final Widget nextPage;

  const LoadingTransitionPage({
    super.key,
    required this.lottiePath,
    required this.message,
    required this.duration,
    required this.nextPage,
  });

  @override
  State<LoadingTransitionPage> createState() => _LoadingTransitionPageState();
}

class _LoadingTransitionPageState extends State<LoadingTransitionPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.duration, () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => widget.nextPage),
        );
      }
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
              widget.lottiePath,
              width: 200,
              height: 200,
              frameRate: FrameRate.max,
            ),
            const SizedBox(height: 24),
            Text(
              widget.message,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
