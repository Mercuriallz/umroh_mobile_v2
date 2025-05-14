import 'package:flutter/material.dart';

class BankOptionTile extends StatelessWidget {
  final String logoAsset;
  final bool available;
  final VoidCallback onTap;
  final bool isSelected;

  const BankOptionTile({
    super.key,
    required this.logoAsset,
    required this.available,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: available ? 1.0 : 0.5,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Image.asset(
                logoAsset,
                height: 24,
              ),
              const SizedBox(width: 12),
              if (!available)
                const Text(
                  "Tidak tersedia untuk saat ini.",
                  style: TextStyle(fontSize: 14),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
