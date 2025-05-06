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
  final String? namaPemesan;
  final String? jenisKelamin;
  final String? typeJemaah;
  final int? totalOrang;
  final int? totalDipilih;
  final int? id;

  const DataOrderPage({
    super.key,
    required this.namaPemesan,
    required this.jenisKelamin,
    this.typeJemaah,
    required this.totalOrang,
    this.totalDipilih,
    required this.id
  });

  @override
  State<DataOrderPage> createState() => _DataOrderPageState();
}

class _DataOrderPageState extends State<DataOrderPage> {
  List<Map<String, String>> jemaahList = [];

  void navigateToTambahJemaah() async {
    if ((1 + jemaahList.length) >= (widget.totalOrang ?? 0)) {
      Get.snackbar(
        "Data jamaah sudah penuh",
        "Data jamaah yang ditambahkan sudah maksimal dari yang anda tambahkan di halaman sebelumnya",
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
  void initState() {
    super.initState();
    context.read<PackageBloc>().getPackageById(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final totalJemaah = 1 + jemaahList.length;

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
              _buildBookingInfoSection(),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader(totalJemaah),
                      const SizedBox(height: 12),
                      _buildJemaahItem(widget.namaPemesan ?? "-",
                          widget.jenisKelamin ?? "-", widget.typeJemaah ?? "-",
                          isPemesan: true),
                      const SizedBox(height: 8),
                      ...jemaahList.asMap().entries.map((entry) {
                        final index = entry.key;
                        final jemaah = entry.value;
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
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
                          child: _buildJemaahItem(
                              jemaah['nama'] ?? "-",
                              jemaah['jenis_kelamin'] ?? "-",
                              jemaah['type_jemaah'] ?? "-"),
                        );
                      }),
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
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
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

  Widget _buildSectionHeader(int totalJemaah) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Data Jama’ah",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text("$totalJemaah / ${widget.totalOrang}",
            style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildBookingInfoSection() {
    return BlocBuilder<PackageBloc, PackageState>(
      builder: (context, state) {
        if(state is PackageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PackageLoadedById) {
          final package = state.packageId;
          return  Container(
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
            _buildInfoItem("Kode Paket", package.kodePaket.toString(), isLink: true),
            _buildInfoItem(
                "Nama Paket", package.namaPaket.toString(), isLink: true),
            _buildInfoItem("Jenis Paket", package.isVip == true ? "VIP" : "Reguler", isLink: true),
            _buildInfoItem("Pelaksanaan", package.jadwalPerjalanan.toString(), isLink: true),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.center,
              child: Text("Lihat Informasi Pemesanan",
                  style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      );
    
        } else {
          return Container();
        }
      }
     );
  }

  Widget _buildInfoItem(String title, String value, {bool isLink = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: Text(value,
                  textAlign: TextAlign.right,
                  style:
                      TextStyle(color: isLink ? Colors.blue : Colors.black))),
        ],
      ),
    );
  }

  Widget _buildJemaahItem(String nama, String jenisKelamin, String typeJemaah,
      {bool isPemesan = false}) {
    return Container(
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
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(nama, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(jenisKelamin),
          ]),
          Text(isPemesan ? "Pemesan" : typeJemaah,
              style: const TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }
}
