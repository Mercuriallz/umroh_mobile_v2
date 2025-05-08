import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/bloc/package/package_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/loading_page.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/add_jemaah_page.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/detail_order_page.dart';

class DataOrderPage extends StatefulWidget {
  final int? totalOrang;
  final int? id;

  const DataOrderPage({
    super.key,
    required this.totalOrang,
    required this.id,
  });

  @override
  State<DataOrderPage> createState() => _DataOrderPageState();
}

class _DataOrderPageState extends State<DataOrderPage> {
  List<Map<String, String>> jemaahList = [];

  @override
  void initState() {
    super.initState();
    context.read<PackageBloc>().getPackageById(widget.id.toString());   
  }

  void navigateToTambahJemaah() async {
    if (jemaahList.length >= (widget.totalOrang ?? 0)) {
      Get.snackbar(
        "Data jamaah sudah penuh",
        "Jumlah jamaah sudah sesuai dengan total orang yang dipilih.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: ColorConstant.secondary100,
        backgroundColor: Colors.red,
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddJemaahPage()),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        jemaahList.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalJemaah = jemaahList.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: const [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 8),
                  Text("Data Pemesanan",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 24),
              BlocBuilder<PackageBloc, PackageState>(
                builder: (context, state) {
                  if (state is PackageLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PackageLoadedById) {
                    final package = state.packageId;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Informasi Pemesanan Section
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Informasi Pemesanan",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 12),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 2,
                                        child: Text("Kode Paket",
                                            style: TextStyle(fontWeight: FontWeight.bold))),
                                    Expanded(
                                        flex: 3,
                                        child: Text(package.kodePaket.toString(),
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(color: Colors.blue))),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 2,
                                        child: Text("Nama Paket",
                                            style: TextStyle(fontWeight: FontWeight.bold))),
                                    Expanded(
                                        flex: 3,
                                        child: Text(package.namaPaket.toString(),
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(color: Colors.blue))),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 2,
                                        child: Text("Jenis Paket",
                                            style: TextStyle(fontWeight: FontWeight.bold))),
                                    Expanded(
                                        flex: 3,
                                        child: Text(package.isVip == true ? "VIP" : "Reguler",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(color: Colors.blue))),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 2,
                                        child: Text("Pelaksanaan",
                                            style: TextStyle(fontWeight: FontWeight.bold))),
                                    Expanded(
                                        flex: 3,
                                        child: Text(package.jadwalPerjalanan.toString(),
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(color: Colors.blue))),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Align(
                                alignment: Alignment.center,
                                child: Text("Lihat Informasi Pemesanan",
                                    style: TextStyle(color: Colors.blue)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Data Jama'ah Section Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Data Jama'ah",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text("$totalJemaah / ${widget.totalOrang}",
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        ...jemaahList.asMap().entries.map((entry) {
                          final index = entry.key;
                          final jemaah = entry.value;
                          return Dismissible(
                            key: UniqueKey(),
                            direction: index == 0
                                ? DismissDirection.none
                                : DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (_) {
                              setState(() {
                                jemaahList.removeAt(index);
                              });
                              Get.snackbar("Jama'ah Dihapus",
                                  "${jemaah['nama']} telah dihapus",
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: ColorConstant.secondary100,
                                  backgroundColor: Colors.red);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade300),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start, 
                                    children: [
                                      Text(jemaah['nama'] ?? "-", 
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text(jemaah['jenis_kelamin'] ?? "-"),
                                      Text(jemaah['type_jemaah'] ?? "-"),
                                      Text(jemaah['nik'] ?? "-"),
                                      Text(jemaah['phone'] ?? "-"),
                                      Text(jemaah['email'] ?? "-"),
                                      Text(jemaah['password'] ?? "-"),
                                    ]
                                  ),
                                  Text(index == 0 ? "Pemesan" : jemaah['type_jemaah'] ?? "-",
                                      style: const TextStyle(color: Colors.blue)),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        
                        // Tambah Jama'ah Button
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: navigateToTambahJemaah,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)),
                            ),
                            child: const Text("Tambah +",
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const Spacer(),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (jemaahList.length != widget.totalOrang) {
                      Get.snackbar(
                        "Jumlah belum sesuai",
                        "Tambahkan semua data jamaah terlebih dahulu",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // Kirim ke API di sini kalau mau
                    print("Data yang dikirim ke API: $jemaahList");

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => LoadingTransitionPage(
                                lottiePath:
                                    'assets/lottie/loading_animation.json',
                                message: 'Pesanan Anda Sedang Diproses...',
                                duration: const Duration(seconds: 3),
                                nextPage: const DetailOrderPage(),
                              )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)),
                  ),
                  child: const Text("Buat Pesanan",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}