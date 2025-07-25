import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/transaction/transaction/self_transaction_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/transaction/transaction/self_transaction_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/schedule/payment/detail/transaction_detail_page.dart';

class ScheduleDeparturePage extends StatefulWidget {
  final String? trx;
  const ScheduleDeparturePage({super.key, this.trx});

  @override
  State<ScheduleDeparturePage> createState() => _ScheduleDeparturePageState();
}

class _ScheduleDeparturePageState extends State<ScheduleDeparturePage> {
  @override
  void initState() {
    super.initState();
    context.read<SelfTransactionBloc>().getSelfTransaction();
  }

  @override
  Widget build(BuildContext context) {
    final rupiahConverter = RupiahConverter();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F8),
      body: SafeArea(
        child: BlocBuilder<SelfTransactionBloc, SelfTransactionState>(
          builder: (context, state) {
            if (state is SelfTransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SelfTransactionError) {
              return Center(child: Text("Terjadi kesalahan: ${state.message}"));
            } else if (state is SelfTransactionLoaded) {
              final data = state.selfTransaction;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      "Jadwal Keberangkatan",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.purchaseTitle ?? "-",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Klik untuk lihat detail pemesanan",
                            style: TextStyle(color: Colors.blue),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Jakarta"),
                              SizedBox(width: 8),
                              Expanded(child: Divider(color: Colors.grey)),
                              Icon(Icons.flight_takeoff,
                                  size: 24, color: Colors.black54),
                              Expanded(child: Divider(color: Colors.grey)),
                              SizedBox(width: 8),
                              Text("Mekah"),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Status Pembayaran",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          const Text("Target",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(
                            rupiahConverter.formatToRupiah(
                              int.tryParse(
                                    data.priceFinal
                                            ?.toString() ??
                                        "0",
                                  ) ??
                                  0,
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                              "Selesaikan Sebelum", "11 November 2025"),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(TransactionDetailPage(
                                  // trx: data.trx ?? "",
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.primaryBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text("Transaksi",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    const Text(
                      "Terdapat kesalahan pemesanan atau kebimbangan hati terhadap pesanan?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Anda dapat melakukan pengembalian dana (refund). Jika anda mendapatkan kesalahan atau alasan lain.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF6A62D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text("Ajukan Pengembalian Dana",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            }

            return const Center(child: Text("Tidak ada data."));
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value,
      {bool isBold = false, bool isWarning = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              color: isWarning ? Colors.orange : Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
