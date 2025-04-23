import 'package:flutter/material.dart';

class DataOrderPage extends StatelessWidget {
  final String namaPemesan;
  final String jenisKelamin;
  final int totalOrang; // Add totalOrang parameter

  const DataOrderPage({
    super.key,
    required this.namaPemesan,
    required this.jenisKelamin,
    required this.totalOrang, // Make it required
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Data Pemesanan", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Informasi Pemesanan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            _buildInfoItem("Kode Paket", "UMR000131", isLink: true),
            _buildInfoItem("Nama Paket", "Paket Umrah Desa - Termasuk Madinah"),
            _buildInfoItem("Jenis Paket", "VIP"),
            _buildInfoItem("Pelaksanaan", "11 Desember 2025 - 14 Desember 2025"),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.center,
              child: Text("Lihat Informasi Pemesanan", style: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Data Jama'ah", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                // Display the correct count based on the passed totalOrang
                Text("1 / $totalOrang")
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(namaPemesan, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(jenisKelamin)
                    ],
                  ),
                  const Text("Pemesan", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.blue.shade100,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const Text("Tambah +", style: TextStyle(color: Colors.blue)),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("Pesan Sekarang", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildInfoItem(String title, String value, {bool isLink = false}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(color: isLink ? Colors.blue : Colors.black),
          ),
        ),
      ],
    ),
  );
}

}