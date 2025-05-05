import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/dotted.dart';

class ResultTransactionPage extends StatefulWidget {
  const ResultTransactionPage({super.key});

  @override
  State<ResultTransactionPage> createState() => _ResultTransactionPageState();
}

class _ResultTransactionPageState extends State<ResultTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Detail",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ColorConstant.primaryBlue,
                  ),
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: "Detail Paket"),
                    Tab(text: "Status Dokumen"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildDetailPaket(context),
                    _buildStatusDokumenTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailPaket(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Text("Paket Umrah Desa - Termasuk Madinah",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          Center(
            child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Jakarta",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 6),
         DotCircle(),
        const SizedBox(width: 6),
        const Flexible(
          child: DottedLine(
            dashColor: Colors.grey,
            dashLength: 4,
            lineThickness: 1,
          ),
        ),
        const SizedBox(width: 6),
        const Icon(Icons.flight, size: 20, color: Colors.black),
        const SizedBox(width: 6),
        const Flexible(
          child: DottedLine(
            dashColor: Colors.grey,
            dashLength: 4,
            lineThickness: 1,
          ),
        ),
        const SizedBox(width: 6),
        const DotCircle(),
        const SizedBox(width: 6),
        const Text(
          "Mekah",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    )
          ),
          const SizedBox(height: 16),
          _buildInfoItem("Harga Paket", "Rp. 33.900.000"),
          _buildInfoItem("Jenis Paket", "VIP"),
          _buildInfoItem("Jumlah Seat", "2 Seat"),
          _buildInfoItem("Hotel", "Hotel Hilton Makkah (B-5)"),
          _buildInfoItem("Penerbangan", "Saudi Airlines"),
          _buildInfoItem("Bandara", "Soekarno Hatta (CGK)"),
          _buildInfoItem("Tanggal Keberangkatan", "11 Desember 2025"),
          _buildInfoItem("Tanggal Pemesanan", "11 April 2025"),
          _buildInfoItem("Tanggal Pelunasan", "11 Oktober 2025"),
          const SizedBox(height: 16),
          _buildSectionCard("Catatan", "Tidak ada catatan"),
          const SizedBox(height: 16),
          _buildExpandableTileList(),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildExpandableTileList() {
    final items = {
      "Itinerary":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
      "Fasilitas":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
      "Persyaratan Peserta":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
      "Syarat dan Ketentuan":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
    };

    return Column(
      children: items.entries.map((entry) {
        return ExpansionTile(
          shape: Border.all(color: Colors.transparent),
          title: Text(entry.key,
              style: const TextStyle(fontWeight: FontWeight.w500)),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(entry.value),
            ),
          ],
        );
      }).toList(),
    );
  }

 Widget _buildStatusDokumenTab() {
  final List<Map<String, dynamic>> users = [
    {
      "name": "Anthony Simmons",
      "role": "Pemesan",
      "remainingDocs": 6,
    },
    {
      "name": "Mozea Moo",
      "role": null,
      "remainingDocs": 0,
    },
  ];

  return ListView.separated(
    padding: const EdgeInsets.all(16),
    itemCount: users.length,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (context, index) {
      final user = users[index];
      final bool isComplete = user['remainingDocs'] == 0;

      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0.5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (user['role'] != null)
                    Text(
                      user['role'],
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("Kelengkapan Dokumen : "),
                  Text(
                    isComplete
                        ? "Dokumen lengkap!"
                        : "${user['remainingDocs']} Dokumen tersisa",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isComplete ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

}
