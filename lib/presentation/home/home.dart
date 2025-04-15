
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Selamat Datang',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              _buildUserCard(),
              const SizedBox(height: 20),
              _buildMenuGrid(),
              const SizedBox(height: 30),
              _buildPaketUmrahSection(size),
              const SizedBox(height: 20),
              _buildJadwalSholat(),
              const SizedBox(height: 20),
              _buildPanduanUmrah(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bleks",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("000123",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        ClipOval(
          child: Image.asset(
            'assets/image/profile.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  Widget _buildMenuGrid() {
    List<Map<String, String>> menu = [
      {"title": "Umrah", "icon": "assets/menu.png"},
      {"title": "Bimbingan", "icon": "assets/menu.png"},
      {"title": "Fitur Haji", "icon": "assets/menu.png"},
      {"title": "Kurs & Mata Uang", "icon": "assets/menu.png"},
      {"title": "Info Cuaca", "icon": "assets/menu.png"},
      {"title": "Jadwal Sholat", "icon": "assets/menu.png"},
      {"title": "Al-qur’an", "icon": "assets/menu.png"},
      {"title": "Lainnya", "icon": "assets/menu.png"},
    ];

    return GridView.builder(
      itemCount: menu.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Image.asset(menu[index]['icon']!, width: 28, height: 28),
            ),
            const SizedBox(height: 6),
            Text(menu[index]['title']!, style: const TextStyle(fontSize: 12)),
          ],
        );
      },
    );
  }

  Widget _buildPaketUmrahSection(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Paket Umrah", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(
                  'assets/image/kabah.png',
                  width: double.infinity,
                  height: size.height * 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Paket Umroh nihhh",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _buildIconText(Icons.flight, "Pesawat"),
                        _buildIconText(Icons.directions_car, "Antar"),
                        _buildIconText(Icons.hotel, "Hotel"),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mulai dari", style: TextStyle(fontSize: 12)),
                        Text("Cicilan :", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp. 31",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Color(0xFF3A7AFB))),
                        Text("Sampai 2 bulan", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF70B8FF),
                        minimumSize: const Size.fromHeight(44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: const Text("Detail Paket"),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildJadwalSholat() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.location_pin, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text("Bojong", style: TextStyle(fontSize: 12)),
            ],
          ),
          Text("Isya", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("19:19 Malam", style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildPanduanUmrah() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Panduan Umrah",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Column(
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tata Cara Menjalankan Umrah yang baik dan benar",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        SizedBox(height: 6),
                        Text("Durasi 10 jam", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        )
      ],
    );
  }
}