import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/transaction/payment/payment_transaction_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/transaction/payment/payment_transaction_state.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/transaction/payment/payment_transaction_request_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/schedule/payment/transaction/transaction_page.dart';

class ConfirmPaymentPage extends StatefulWidget {
  final String? trx;
  final String? bankCode;
  final String? type;
  final String? amount;
  final String? bankName;

  const ConfirmPaymentPage({
    super.key,
    this.trx,
    required this.bankCode,
    required this.type,
    required this.bankName,
    required this.amount,
  });

  @override
  State<ConfirmPaymentPage> createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  final rupiahConverter = RupiahConverter();

  @override
  Widget build(BuildContext context) {
    // print(widget.trx);
    // print(widget.bankCode);
    // print(widget.type);
    // print(widget.bankName);
    // print(widget.amount);
    return BlocListener<PaymentTransactionBloc, PaymentTransactionState>(
      listener: (context, state) {
        if (state is PaymentTransactionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Transaksi Berhasil Dibuat!'),
              backgroundColor: Colors.green,
            ),
          );
          Get.offAll(TransactionPage(paymentData: state.paymentData, id: widget.trx));
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => TransactionPage(
          //       paymentData: state.paymentData,
          //     ),
          //   ),
          // );
        } else if (state is PaymentTransactionFailed) {
          // Tampilkan error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFDFDFD),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Konfirmasi Pembayaran',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
          ),
          centerTitle: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  const Text(
                    'Check Out',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Konfirmasi pembayaran terlebih dahulu.',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 12),

                  // Inline: Jumlah Pembayaran
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Row(
                      
                      children: [
                        
                        const Expanded(
                          child: Text('Jumlah Pembayaran',
                              style: TextStyle(color: Colors.black54)),
                        ),
                        Text(
                          widget.amount!,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),

                  // Inline: Waktu Dibuat
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text('Waktu Dibuat',
                              style: TextStyle(color: Colors.black54)),
                        ),
                        Text(
                          DateFormat('dd MMMM yyyy HH:mm')
                              .format(DateTime.now()),
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),

                  // Inline: Promo
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text('Promo',
                              style: TextStyle(color: Colors.black54)),
                        ),
                        Text(
                          'Tidak ada',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Metode Pembayaran',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Metode pembayaran yang Anda pilih melalui ',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        TextSpan(
                          text: widget.bankName ?? 'Bank',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(
                          text:
                              '. Anda dapat mengganti metode pembayaran Anda disini sebelum lanjut ke transaksi.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child:
                  BlocBuilder<PaymentTransactionBloc, PaymentTransactionState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    onPressed: state is PaymentTransactionLoading
                        ? null
                        : () {
                            final cleanedAmount = (widget.amount ?? '0')
                                .replaceAll('Rp.', '')
                                .replaceAll('.', '')
                                .replaceAll(',', '')
                                .trim();
                            final bloc = context.read<PaymentTransactionBloc>();
                            final requestModel = PaymentTransactionRequestModel(
                              trx: widget.trx ?? '',
                              amount: cleanedAmount,
                              typePayment: widget.type ?? '',
                              typeVa: widget.bankCode ?? '',
                            );
                            bloc.sendPaymentTransaction(requestModel);
                          },
                    child: state is PaymentTransactionLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Lanjutkan',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
