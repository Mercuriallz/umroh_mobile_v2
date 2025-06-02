import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/model/transaction/payment/payment_transaction_model.dart';
import 'package:mobile_umroh_v2/presentation/schedule/payment/transaction/transaction_page.dart';

class TransactionHelper {
  static const _transactionKey = 'pending_transaction';
  static const _secureStorage = FlutterSecureStorage();

  static Future<bool> hasPendingTransaction() async {
    final transactionData = await _secureStorage.read(key: _transactionKey);
    return transactionData != null && transactionData.isNotEmpty;
  }

  static Future<Map<String, dynamic>?> getPendingTransaction() async {
    final transactionJson = await _secureStorage.read(key: _transactionKey);
    if (transactionJson != null && transactionJson.isNotEmpty) {
      return jsonDecode(transactionJson);
    }
    return null;
  }

  static Future<void> checkAndNavigateToPendingTransaction() async {
    if (await hasPendingTransaction()) {
      final transactionData = await getPendingTransaction();
      if (transactionData != null) {
        PaymentData paymentData = PaymentData(
          vaNumber: transactionData['vaNumber'],
          amount: transactionData['amount'],
        );
        Get.to(() => TransactionPage(paymentData: paymentData));
      }
    }
  }
}
