import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_umroh_v2/bloc/transaction/transaction/detail/self_transaction_detail_bloc.dart';
import 'package:mobile_umroh_v2/bloc/transaction/transaction/detail/self_transaction_detail_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/presentation/schedule/payment/payment_method/repayment_method_page.dart';

class TransactionDetailPage extends StatefulWidget {
  const TransactionDetailPage({super.key});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  Set<int> expandedIndexes = {};

  @override
  void initState() {
    super.initState();
    context.read<SelfTransactionDetailBloc>().getTransactionDetail();
  }

  @override
  Widget build(BuildContext context) {
    final rupiahConverter = RupiahConverter();
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<SelfTransactionDetailBloc,
              SelfTransactionDetailState>(
            builder: (context, state) {
              if (state is SelfTransactionDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SelfTransactionDetailError) {
                return Center(child: Text('Error: ${state.message}'));
              } else if (state is SelfTransactionDetailLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomBackHeader(
                      title: "Informasi Transaksi",
                      onBack: null,
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.dataTransaction.length,
                      itemBuilder: (context, index) {
                        final transaction = state.dataTransaction[index];
                        final isExpanded = expandedIndexes.contains(index);
                        final history = transaction.transactionHistory ?? [];

                        final totalPaid = history.fold<int>(
                          0,
                          (sum, tx) =>
                              sum +
                              (int.tryParse(tx.amount?.toString() ?? '0') ?? 0),
                        );

                        final totalTarget = int.tryParse(
                                transaction.priceFinal?.toString() ?? '0') ??
                            0;

                        final isFullyPaid = totalPaid >= totalTarget;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 6),
                            ],
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  transaction.purchaseTitle ?? 'Transaksi',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    isExpanded
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (isExpanded) {
                                        expandedIndexes.remove(index);
                                      } else {
                                        expandedIndexes.add(index);
                                      }
                                    });
                                  },
                                ),
                              ),
                              if (isExpanded)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Target",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Center(
                                        child: Text(
                                          rupiahConverter.formatToRupiah(
                                              int.parse(transaction.priceFinal
                                                  .toString())),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      if (history.isNotEmpty) ...[
                                        // Calculate totalAmount, totalTarget, and progress before the widget tree
                                        Builder(
                                          builder: (context) {
                                            final totalAmount =
                                                history.fold<int>(
                                              0,
                                              (sum, tx) =>
                                                  sum +
                                                  (int.tryParse(tx.amount
                                                              ?.toString() ??
                                                          '0') ??
                                                      0),
                                            );
                                            final totalTarget = int.tryParse(
                                                    transaction.priceFinal
                                                            ?.toString() ??
                                                        '0') ??
                                                0;
                                            final progress = (totalTarget > 0)
                                                ? (totalAmount / totalTarget)
                                                    .clamp(0.0, 1.0)
                                                : 0.0;
                                            return Column(
                                              children: [
                                                LinearProgressIndicator(
                                                  value: progress,
                                                  minHeight: 6,
                                                  backgroundColor:
                                                      const Color(0xFFE0ECFB),
                                                  valueColor:
                                                      const AlwaysStoppedAnimation<
                                                          Color>(Colors.blue),
                                                ),
                                                const SizedBox(height: 12),
                                              ],
                                            );
                                          },
                                        ),
                                      ] else ...[
                                        const Text(
                                          'Belum ada progres transaksi',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                      ],
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Selesaikan Sebelum',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          Text('11 November 2025'),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Histori Transaksi',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(height: 12),
                                      if (history.isNotEmpty) ...[
                                        ...history.map((tx) {
                                          final rawAmount =
                                              tx.amount?.toString();
                                          final payDate = tx.payAt != null
                                              ? DateFormat('dd MMMM yyyy')
                                                  .format(
                                                      DateTime.parse(tx.payAt!))
                                              : 'Tanggal tidak diketahui';

                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 12),
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey.shade300),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    rawAmount != null &&
                                                            int.tryParse(
                                                                    rawAmount) !=
                                                                null
                                                        ? Text(
                                                            rupiahConverter
                                                                .formatToRupiah(
                                                                    int.parse(
                                                                        rawAmount)),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : const Text(
                                                            'Belum ada transaksi',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      payDate,
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                const Text(
                                                  'Berhasil',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ] else ...[
                                        const Text(
                                          'Belum ada transaksi',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                      SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: isFullyPaid
                                                ? Colors.grey
                                                : ColorConstant.primaryBlue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          onPressed: isFullyPaid
                                              ? null
                                              : () {
                                                  final totalAmount =
                                                      transaction
                                                          .transactionHistory!
                                                          .map((e) =>
                                                              int.tryParse(
                                                                  e.amount ??
                                                                      '0') ??
                                                              0)
                                                          .fold(0,
                                                              (a, b) => a + b);
                                                  Get.to(RepaymentMethodPage(
                                                    trx: transaction.trx ?? '',
                                                    finalPrice: transaction
                                                        .priceFinal
                                                        .toString(),
                                                    amount:
                                                        totalAmount.toString(),
                                                  ));
                                                },
                                          child: Text(
                                            isFullyPaid
                                                ? 'Transaksi Lunas'
                                                : 'Tambahkan Transaksi',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
        ),
      ),
    );
  }
}
