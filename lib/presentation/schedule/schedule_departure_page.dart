import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/bloc/transaction/transaction_detail/transaction_detail_bloc.dart';
import 'package:mobile_umroh_v2/bloc/transaction/transaction_detail/transaction_detail_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/presentation/schedule/payment/transaction_detail_page.dart';

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
  
  // Gunakan widget.trx untuk memuat data transaksi
  if (widget.trx != null && widget.trx!.isNotEmpty) {
    context.read<TransactionDetailBloc>().getTransactionDetail(widget.trx!);
    
   
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F8),
      body: SafeArea(
        child: BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
          builder: (context, state) {
            if (state is TransactionDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionDetailError) {
              return Center(
                child: Text("Error"),
              );
            } else if (state is TransactionDetailLoaded) {
              final data = state.transactionDetailModel;
              return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                                data.paketName ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                  Expanded(
                                    child:
                                        Divider(color: Colors.grey, thickness: 1),
                                  ),
                                  Icon(Icons.flight_takeoff,
                                      size: 24, color: Colors.black54),
                                  Expanded(
                                    child:
                                        Divider(color: Colors.grey, thickness: 1),
                                  ),
                                  SizedBox(width: 8),
                                  Text("Mekah"),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildInfoRow(
                                  "Estimasi Berangkat", data.tanggalKeberangkatan ?? ""),
                              _buildInfoRow("Jumlah Jema'ah", data.amountSeat.toString()),
                              _buildInfoRow(
                                  "Penerbangan", data.airportName ?? "",
                                  isBold: true),
                              _buildInfoRow("Status Dokumen", "Belum Lengkap",
                                  isWarning: true),
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
                              const Text(
                                "Target",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Rp. 31.000.000",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: 10000000 / 31000000,
                                  minHeight: 6,
                                  backgroundColor: Colors.blue.shade100,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.blue),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildInfoRow("Terkumpul", "Rp. 2.824.000"),
                              _buildInfoRow(
                                  "Selesaikan Sebelum", "11 November 2025"),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(TransactionDetailPage());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConstant.primaryBlue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24)),
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
          
                        // Refund Section
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
                                  borderRadius: BorderRadius.circular(24)),
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
                  ),
                ),
              ],
            ),
          );
        
            }
            return const Center(
              child: Text("No Data"),
            );
          },
        )
          ),
      );
    
  }

  Widget _buildInfoRow(String title, String value,
      {bool isBold = false, bool isWarning = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
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
