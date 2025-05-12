import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove all non-digit characters
    String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    
    // If it's just a deletion or no actual change, don't format
    if (newText.isEmpty || newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Convert to integer
    int value = int.parse(newText);
    
    // Format with thousand separators
    final formatter = NumberFormat("#,###", "id_ID");
    String formattedText = formatter.format(value);
    
    // Add "Rp" prefix
    formattedText = "Rp. $formattedText";

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

// Example implementation in a widget:
class PaymentTextField extends StatelessWidget {
  final TextEditingController controller;
  
  const PaymentTextField({super.key, required this.controller});
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      inputFormatters: [
        RupiahInputFormatter(),
      ],
      decoration: InputDecoration(
        hintText: "Jumlah Pembayaran",
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
