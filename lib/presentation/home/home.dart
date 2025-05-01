import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/presentation/detail/detail_page.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class HomePage extends StatefulWidget {


   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final secureStorage = SecureStorageService();

  String? username; 



  
  final List<Map<String, dynamic>> packages = [
    {
      'image': 'assets/image/kabah.png',
      'title': 'Paket Haji Nih',
      'deskripsi': 'Paket Haji dan Umroh 31 juta',
      'price':  31000000,
      'cicilan': 1,
      'views': '100',
    },
    {
      'image': 'assets/image/kabah.png',
      'title': 'Oke gas',
      'deskripsi': 'Paket Haji dan Umroh 32 juta',
      'price':  32000000,
      'cicilan': 3,
      'views': '400',
    },
    {
      'image': 'assets/image/kabah.png',
      'title': 'Program Makan Siang Gratis',
      'deskripsi': 'Paket Haji dan Umroh 35 juta',
      'price': 35000000,
      'cicilan': 6,
      'views': '30',
    },
  ];

  void loadUsername() async {
    final name = await secureStorage.read("name");
    setState(() {
      username = name.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    loadUsername();
  }

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
         Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username ?? "-",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("000123",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            'https://i.pravatar.cc/100',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  Widget _buildMenuGrid() {
    List<Map<String, String>> menu = [
      {"title": "Umrah", "icon": "assets/icons/blocks 1.png"},
      {"title": "Bimbingan", "icon": "assets/icons/blocks 1.png"},
      {"title": "Fitur Haji", "icon": "assets/icons/blocks 1.png"},
      {"title": "Kurs & Mata Uang", "icon": "assets/icons/blocks 1.png"},
      {"title": "Info Cuaca", "icon": "assets/icons/blocks 1.png"},
      {"title": "Jadwal Sholat", "icon": "assets/icons/blocks 1.png"},
      {"title": "Al-qur’an", "icon": "assets/icons/blocks 1.png"},
      {"title": "Lainnya", "icon": "assets/icons/blocks 1.png"},
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
      itemBuilder: (context, i) {
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
              child: Image.asset(menu[i]['icon']!, width: 28, height: 28),
            ),
            const SizedBox(height: 6),
            Align(
                alignment: Alignment.center,
                child: Text(
                  menu[i]['title']!,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
          ],
        );
      },
    );
  }

  Widget _buildPaketUmrahSection(Size size) {
    final rupiahConverter = RupiahConverter();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Paket Umrah",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      const SizedBox(height: 12),
      SizedBox(
        height: size.height * 0.45, 
        child: ListView.builder(
          itemCount: packages.length,
          scrollDirection: Axis.horizontal, 
          itemBuilder: (context, i) {
            return Container(
              width: size.width * 0.75, 
              margin: const EdgeInsets.only(right: 16), 
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10)
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20)),
                    child: Image.asset(
                      packages[i]['image']!,
                      width: double.infinity,
                      height: size.height * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(packages[i]['title']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
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
                            Text("Mulai dari",
                                style: TextStyle(fontSize: 12)),
                            Text("Cicilan :", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 4),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(rupiahConverter.formatToRupiah(int.parse(
                                packages[i]['price'].toString())),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3A7AFB))),
                            Text("Sampai ${packages[i]['cicilan'].toString()} bulan",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.bookmark_border,
                                  color: Colors.grey),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                    () =>  DetailPage(
                                      package: packages[i],
                                      harga: packages[i]['price'],
                                    ),
                                    transition: Transition.rightToLeft,
                                    duration:
                                        const Duration(milliseconds: 300),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF70B8FF),
                                  minimumSize: const Size.fromHeight(40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                child: const Text(
                                  "Detail Paket",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
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
                        Text("Durasi 10 jam",
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
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
