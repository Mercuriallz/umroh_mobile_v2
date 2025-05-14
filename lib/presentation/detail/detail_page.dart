import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/bloc/package/package_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/constant/shimmer.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/order_page.dart';

class DetailPage extends StatefulWidget {
  final String? id;

  const DetailPage({super.key, this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with WidgetsBindingObserver {
  void refreshId() {
    setState(() {
      widget.id.toString();
    });
  }

  void refreshData() {
    context.read<PackageBloc>().getPackageById(widget.id.toString());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    refreshData();
    refreshId();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed || state == AppLifecycleState.inactive) {
      refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<PackageBloc, PackageState>(
            builder: (context, state) {
              if (state is PackageLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PackageLoadedById) {
                final package = state.packageId;
                final features =
                    package.arrFeature?.map((e) => e.toLowerCase()).toList() ??
                        [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        children: [
                         CustomBackHeader(title: "Pembayaran", onBack: () => Navigator.pop(context)),
                          const SizedBox(width: 8),
                          const Text(
                            "Detail Paket",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ShimmerImage(
                      imageUrl: package.imgThumbnail ?? "",
                      height: 180,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      package.namaPaket ?? "-",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    package.isVip == true
                        ? Row(
                            children: [
                              Icon(Icons.star, size: 18, color: Colors.amber),
                              SizedBox(width: 4),
                              Text("VIP",
                                  style: TextStyle(color: Colors.amber)),
                            ],
                          )
                        : Text("Reguler"),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (features.contains("pesawat"))
                          _buildIconText(Icons.flight_takeoff, "Pesawat"),
                        if (features.contains("antar"))
                          _buildIconText(Icons.directions_car, "Antar"),
                        if (features.contains("hotel"))
                          _buildIconText(Icons.hotel, "Hotel"),
                        if (features.contains("bis"))
                          _buildIconText(Icons.directions_bus, "Bus"),
                        if (features.contains("konsumsi"))
                          _buildIconText(Icons.food_bank, "Konsumsi")
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.share, color: Colors.blue),
                        Icon(Icons.bookmark_border, color: Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Deskripsi Singkat",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(package.desc ?? "-",
                        style: const TextStyle(color: Colors.black87)),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.flight_takeoff,
                              color: Colors.black, size: 24),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Penerbangan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              SizedBox(height: 4),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Saudi Airlines",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: " - Bandara Soekarno Hatta",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("Perjalanan",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(package.jadwalPerjalanan ?? "-"),
                    const Text(
                      "Normal: 3 - 4 Jam (Tergantung situasi dan kondisi)",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 25),
                    const Text("Fasilitas Hotel",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.network(
                              'https://i.pravatar.cc/100', // Ganti dengan URL atau Image.asset sesuai kebutuhan
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                package.tHotel![0].name ??
                                    "Hotel Belum Ditemukan",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: List.generate(5, (index) {
                                  if (index < package.tHotel![0].rate!) {
                                    return Icon(Icons.star,
                                        color: Colors.amber);
                                  } else {
                                    return Icon(Icons.star_border,
                                        color: Colors.amber);
                                  }
                                }),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _fasilitasItem(Icons.restaurant, "Konsumsi"),
                                  _fasilitasItem(Icons.wifi, "Wi-Fi"),
                                  _fasilitasItem(Icons.tv, "Hiburan"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Mulai dari',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 4),
                            Text(
                              package.harga != null
                                  ? RupiahConverter().formatToRupiah(
                                      int.parse(package.harga.toString()))
                                  : 'Rp. 0',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Color(0xFF75B6FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text("${package.planeSeat} Seat/Bangku",
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() =>
                                OrderPage(id: package.paketId.toString()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryBlue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text('Pesan Sekarang',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (state is PackageError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
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

  static Widget _fasilitasItem(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue[700], size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
