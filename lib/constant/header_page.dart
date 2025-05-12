import 'package:flutter/material.dart';

class CustomBackHeader extends StatelessWidget {
  final String? title;
  final VoidCallback? onBack;

  const CustomBackHeader({
    super.key,
    this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBack ?? () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        const SizedBox(width: 8),
        Text(
          title ?? '',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
