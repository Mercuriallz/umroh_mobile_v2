import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/presentation/auth/login_page.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final secureStorage = SecureStorageService();

  String? username;
    String? roles;


  void loadUsername() async {
    final name = await secureStorage.read("name");
    setState(() {
      username = name.toString();
    });
  }

  void loadRoles() async {
    final role = await secureStorage.read("role");
    setState(() {
      roles = role.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    loadUsername();
    loadRoles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              const Text(
                'Profile',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildUserCard(),
              const SizedBox(height: 12),
              _buildStatusCard(),
              const SizedBox(height: 20),
              _buildMenuItem(
                  'Pengaturan Akun', ['Detail Akun', 'Status'], Icons.person),
              _buildMenuItem('Bimbingan Manasik',
                  ['Vidio', 'Jadwal Manasik', 'Lokasi'], Icons.video_call),
              _buildMenuItem('Visa & Dokumen',
                  ['Status Pengurusan', 'E-ticket'], Icons.document_scanner),
              _buildMenuItem('Fitur Selama Perjalanan',
                  ['Jadwal', 'Real Time Itinerary'], Icons.calendar_today),
              _buildMenuItem('Informasi Paket Internet',
                  ['Roaming', 'Pengecekan'], Icons.wifi),
              const SizedBox(height: 24),
              _buildLogoutButton(context),
              const SizedBox(height: 16),
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
            children:  [
              Text(
                username ?? 'Loading...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              roles == "11"
                  ? Text(
                      'User',
                      style: TextStyle(color: Colors.grey),
                    )
                  : roles == "2"
                      ? Text(
                          'Mitra Desa',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text(
                          'Super Admin',
                          style: TextStyle(color: Colors.grey),
                        ),
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

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text.rich(
        TextSpan(
          text:
              'Data Anda sedang kami periksa, jelajahi aplikasi kami selagi anda menunggu informasi dari kami.\nStatus : ',
          style: TextStyle(fontSize: 14),
          children: [
            TextSpan(
              text: 'Dalam Pemeriksaan',
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, List<String> subtitles, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(
                  subtitles.join(' • '),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final secureStorage = SecureStorageService();
        secureStorage.deleteAll();
        Get.offAll(LoginPage());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        minimumSize: const Size(double.infinity, 48),
      ),
      child: const Text('Log Out', style: TextStyle(color: Colors.red)),
    );
  }
}
