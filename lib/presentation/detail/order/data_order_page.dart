import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/loading.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/add_jemaah_page.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/detail_order_page.dart';

class DataOrderPage extends StatefulWidget {
  final String? namaPemesan;
  final String? jenisKelamin;
  final String? typeJemaah;
  final int? totalOrang;
  final int? totalDipilih;

  const DataOrderPage({
    super.key,
    required this.namaPemesan,
    required this.jenisKelamin,
    this.typeJemaah,
    required this.totalOrang,
    this.totalDipilih,
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
  Widget build(BuildContext context) {
    final totalJemaah = 1 + jemaahList.length;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Data Pemesanan",
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildBookingInfoSection(),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.blue.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                        ),
                        child: const Text("Tambah +",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
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
                      borderRadius: BorderRadius.circular(24)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("Pesan Sekarang",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(int totalJemaah) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Data Jama'ah",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text("$totalJemaah / ${widget.totalOrang}"),
      ],
    );
  }

  Widget _buildBookingInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Informasi Pemesanan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        _buildInfoItem("Kode Paket", "UMR000131", isLink: true),
        _buildInfoItem("Nama Paket", "Paket Umrah Desa - Termasuk Madinah"),
        _buildInfoItem("Jenis Paket", "VIP"),
        _buildInfoItem("Pelaksanaan", "11 Desember 2025 - 14 Desember 2025"),
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.center,
          child: Text("Lihat Informasi Pemesanan",
              style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String title, String value, {bool isLink = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          const SizedBox(width: 8),
          Expanded(
              flex: 3,
              child: Text(value,
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
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
