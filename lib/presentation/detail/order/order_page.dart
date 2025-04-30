import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart' as gets;

import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/data_order_page.dart';

class OrderPage extends StatefulWidget {
  final Map<String, dynamic> package;
  final int? price;
  const OrderPage({super.key, required this.package, this.price});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final noteController = TextEditingController();
  final referralController = TextEditingController();

  List<String> genderItems = [
    'Laki-laki',
    'Perempuan',
  ];

  String? selectedGender;

  int counter = 1;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 0) counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              const SizedBox(height: 16),
              _buildHeaderPaket(),
              const SizedBox(height: 16),
              _buildDetailInfo(),
              const SizedBox(height: 16),
              _buildPemesananHotel(),
              const SizedBox(height: 16),
              _buildJumlahOrangDanTotal(),
              const SizedBox(height: 16),
              _buildFormDataPemesan(),
              const SizedBox(height: 16),
              _buildGabungSekarang(),
              const SizedBox(height: 16),
              _buildExpandableTileList(),
              const SizedBox(height: 100), // Space for bottom bar
            ],
          ),
        ),
      ),
      bottomSheet: _buildBottomButton(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        const Text("Pemesanan",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const Spacer(),
        const Icon(Icons.share),
      ],
    );
  }

  Widget _buildHeaderPaket() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset("assets/image/kabah.png",
                width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Paket Umrah Desa - Termasuk Madinah",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    SizedBox(width: 4),
                    Text("VIP", style: TextStyle(color: Colors.amber)),
                  ],
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.flight, size: 16),
                    SizedBox(width: 4),
                    Text("Pesawat", style: TextStyle(color: Colors.black54)),
                    SizedBox(width: 4),
                    Icon(Icons.directions_car, size: 16),
                    Text("Antar", style: TextStyle(color: Colors.black54)),
                    SizedBox(width: 4),
                    Icon(Icons.hotel, size: 16),
                    Text("Hotel", style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailInfo() {
    final rupiahConverter = RupiahConverter();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInfoBox(
                title: "Perjalanan",
                value: "11 Desember 2025",
                icon: Icons.sync,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildInfoBox(
                title: "Program Hari",
                value: "3 hari",
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildFullWidthInfoBox(
          title: "Penerbangan",
          value: "Saudi Airlines - Bandara Soekarno Hatta (CGK)",
          icon: Icons.sync,
        ),
        const SizedBox(height: 12),
        _buildFullWidthInfoBox(
          title: "Harga Paket",
          value: rupiahConverter
              .formatToRupiah(int.parse(widget.package["price"].toString())),
        ),
      ],
    );
  }

  Widget _buildInfoBox(
      {required String title, required String value, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(value),
            ],
          ),
          if (icon != null) Icon(icon, size: 20),
        ],
      ),
    );
  }

  Widget _buildFullWidthInfoBox(
      {required String title, required String value, IconData? icon}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(value),
              ],
            ),
          ),
          if (icon != null) Icon(icon, size: 20),
        ],
      ),
    );
  }

  Widget _buildPemesananHotel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Pemesanan Hotel",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Hotel Hilton Makkah",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      SizedBox(width: 4),
                      Text("5"),
                    ],
                  ),
                  Icon(Icons.refresh, size: 32),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.restaurant, size: 16),
                  SizedBox(width: 4),
                  Icon(Icons.wifi, size: 16),
                  SizedBox(width: 4),
                  Icon(Icons.card_giftcard, size: 16),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildJumlahOrangDanTotal() {
    final rupiahConverter = RupiahConverter();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(onTap: decrementCounter, child: Container(
              margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: ColorConstant.black)),
              child: Icon(Icons.arrow_left))),
            SizedBox(width: 16),
            Text("$counter orang"),
            SizedBox(width: 16),
            InkWell(onTap: incrementCounter, child: Container(
              margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: ColorConstant.black)),
              child: Icon(Icons.arrow_right))),
          ],
        ),
        const SizedBox(height: 8),
        const Text("Total", style: TextStyle(color: Colors.black54)),
        Text(
            rupiahConverter.formatToRupiah(
                int.parse(widget.package["price"].toString()) * counter),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Text("Note : Satu kamar terdiri dari 4 orang",
            style: TextStyle(fontSize: 12))
      ],
    );
  }

  Widget _buildFormDataPemesan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data Pemesan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),
        _buildRoundedTextField(
            hintText: "Nama Lengkap", controller: nameController),
        const SizedBox(height: 12),
        _buildRoundedDropdown(),
        const SizedBox(height: 12),
        _buildRoundedTextField(
            hintText: "No Telp", controller: phoneController),
        const SizedBox(height: 12),
        _buildRoundedTextField(hintText: "E-mail", controller: emailController),
        const SizedBox(height: 12),
        _buildRoundedTextField(
            hintText: "Catatan (Opsional)", controller: noteController),
        const SizedBox(height: 12),
        _buildRoundedTextField(
          hintText: "Referral (Opsional)",
          controller: referralController,
          suffixIcon: const Icon(Icons.person, color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildRoundedTextField(
      {required String hintText,
      Widget? suffixIcon,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _buildRoundedDropdown() {
    return DropdownButtonFormField<String>(
      items: genderItems.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              )),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedGender = value;
        });
      },
      decoration: InputDecoration(
        hintText: "Pilih Jenis Kelamin",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildGabungSekarang() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Gabung Sekarang",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 8,
        ),
        const Text(
            "Gabung dengan kami agar tidak perlu memasukan data pemesan kembali serta kemudahan registrasi umrah."),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            shape: StadiumBorder(),
          ),
          child: Text(
            "Daftar Sekarang",
            style: TextStyle(
              color: ColorConstant.secondary100,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildExpandableTileList() {
    final items = {
      "Itinerary": "Detail itinerary akan ditampilkan di sini.",
      "Fasilitas": "Informasi fasilitas akan ditampilkan di sini.",
      "Persyaratan Peserta": "Syarat peserta akan dijelaskan di sini.",
      "Syarat dan Ketentuan": "Ketentuan umum pemesanan ditampilkan di sini.",
    };

    return Column(
      children: items.entries.map((entry) {
        return ExpansionTile(
          title: Text(entry.key,
              style: const TextStyle(fontWeight: FontWeight.w500)),
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(entry.value),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.download),
          const Icon(Icons.chat_bubble_outline),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty) {
                gets.Get.snackbar(
                    "Nama Kosong", "Nama tidak boleh kosong, Harap diisi!",
                    backgroundColor: Colors.red,
                    colorText: ColorConstant.secondary100,
                    snackPosition: SnackPosition.BOTTOM);
                return;
              } else if (selectedGender == null) {
                gets.Get.snackbar("Jenis Kelamin Kosong",
                    "Jenis kelamin tidak boleh kosong, Harap dipilih!",
                    backgroundColor: Colors.red,
                    colorText: ColorConstant.secondary100,
                    snackPosition: SnackPosition.BOTTOM);
                return;
              } else {
                Get.to(() => DataOrderPage(
                      namaPemesan: nameController.text,
                      jenisKelamin: selectedGender!,
                      totalOrang: counter,
                    ),
                    transition: Transition.rightToLeft
                    );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              shape: const StadiumBorder(),
            ),
            child: Text(
              "Pesan Sekarang",
              style: TextStyle(
                color: ColorConstant.secondary100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
