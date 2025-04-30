import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildSearchBar(),
            const SizedBox(height: 12),
            _buildTags(),
            const SizedBox(height: 35),
            _buildFilterCard(),
            const SizedBox(height: 20),
            const Text("Termurah",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildPackageCard(size),
            const SizedBox(height: 20),
            const Text("Terbaik",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildPackageCard(size),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Cari dengan filter",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildTags() {
    List<String> tags = [
      "Umrah Murah",
      "Madinah",
      "Mekah",
      "Paket Umrah",
      "Cicilan"
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        return Chip(
          label: Text(tag),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.grey),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFilterCard() {
    List<String> filters = [
      "Bintang Hotel",
      "Slot Tersedia",
      "Date",
      "Termurah"
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 70, // tinggi setiap item
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return DropdownButtonFormField<String>(
          items: const [],
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: filters[index],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        );
      },
    );
  }

  // Widget _buildDropdown(String label) {
  //   return SizedBox(
  //     width: 160,
  //     child: DropdownButtonFormField<String>(
  //       items: const [],
  //       onChanged: (value) {},
  //       decoration: InputDecoration(
  //         labelText: label,
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  //         contentPadding: const EdgeInsets.symmetric(horizontal: 12),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPackageCard(Size size) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.asset(
              'assets/image/kabah.png',
              width: double.infinity,
              height: size.height * 0.22,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Paket Umrah Desa - Termasuk Madinah",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                const Text("⭐ VIP", style: TextStyle(color: Color(0xFF3A7AFB))),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.flight, size: 16),
                    SizedBox(width: 4),
                    Text("Pesawat"),
                    SizedBox(width: 12),
                    Icon(Icons.directions_car, size: 16),
                    SizedBox(width: 4),
                    Text("Antar"),
                    SizedBox(width: 12),
                    Icon(Icons.hotel, size: 16),
                    SizedBox(width: 4),
                    Text("Hotel"),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mulai dari", style: TextStyle(fontSize: 12)),
                        Text("Rp. 33.900.000",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3A7AFB))),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Cicilan :", style: TextStyle(fontSize: 12)),
                        Text("Sampai 48 bulan",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.bookmark_border),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF70B8FF),
                          minimumSize: const Size.fromHeight(44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: const Text("Detail Paket"),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
