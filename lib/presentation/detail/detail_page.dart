import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'package:mobile_umroh_v2/bloc/package/package_id/package_id_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package_id/package_id_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/constant/shimmer.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/order_page.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class DetailPage extends StatefulWidget {
  final String? id;

  const DetailPage({super.key, this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with WidgetsBindingObserver {
  final secureStorage = SecureStorageService();
  String? token;

  void refreshData() {
    context.read<PackageIdBloc>().getPackageById(widget.id.toString());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    refreshData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
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
          child: BlocBuilder<PackageIdBloc, PackageIdState>(
            builder: (context, state) {
              if (state is PackageIdInitial || state is PackageIdLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PackageLoadedById) {
                final package = state.packageId;
                final features =
                    package.arrFeature?.map((e) => e.toLowerCase()).toList() ??
                        [];
                final airplaneName = package.airplaneType!.airplaneName;
                final airportName = package.airport!.airportName;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CustomBackHeader(
                        title: "Detail Paket",
                        onBack: () => Navigator.pop(context),
                      ),
                    ),
                    ShimmerImage(
                      imageUrl: package.imgThumbnail ?? "",
                      height: 180,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    const SizedBox(height: 12),
                    Text(package.namaPaket ?? "-",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    package.isVip == true
                        ? Row(children: [
                            const Icon(Icons.star,
                                size: 18, color: Colors.amber),
                            const SizedBox(width: 4),
                            const Text("VIP",
                                style: TextStyle(color: Colors.amber))
                          ])
                        : const Text("Reguler"),
                    const SizedBox(height: 12),
                    Row(children: [
                      if (features.contains("pesawat"))
                        _buildIconText(Icons.flight_takeoff, "Pesawat"),
                      if (features.contains("antar"))
                        _buildIconText(Icons.directions_car, "Antar"),
                      if (features.contains("hotel"))
                        _buildIconText(Icons.hotel, "Hotel"),
                      if (features.contains("bis"))
                        _buildIconText(Icons.directions_bus, "Bus"),
                      if (features.contains("konsumsi"))
                        _buildIconText(Icons.food_bank, "Konsumsi"),
                    ]),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.share, color: Colors.blue),
                        Icon(Icons.bookmark_border, color: Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Catatan",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Html(data: package.notes),
                    const SizedBox(height: 12),
                    _buildFlightSection(airplaneName!, airportName!),
                    const SizedBox(height: 16),
                    const Text("Estimasi Keberangkatan",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(package.jadwalPerjalanan ?? "-"),
                    const SizedBox(height: 25),
                    const Text("Fasilitas Hotel",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    _buildHotelSection(package),
                    // Tambahkan padding bottom untuk space dengan bottom nav
                    const SizedBox(height: 100),
                  ],
                );
              } else if (state is PackageIdError) {
                return Center(child: Text(state.message));
              } else {
                return const Text("Unknown State");
              }
            },
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BlocBuilder<PackageIdBloc, PackageIdState>(
        builder: (context, state) {
          if (state is PackageLoadedById) {
            final package = state.packageId;
            return _buildBottomNavigationBar(package);
          }
          return const SizedBox.shrink();
        },
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
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildFlightSection(String airplaneName, String airportName) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          const Icon(Icons.flight_takeoff, color: Colors.black, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Penerbangan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: airplaneName,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: " - $airportName",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHotelSection(dynamic package) {
    final hotel =
        package.tHotel?.isNotEmpty == true ? package.tHotel![0] : null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: 85,
            height: 85,
            child: Image.network(
              'https://al-ansar-new-palace-hotel-medina.hotelmix.id/data/Photos/450x450/16660/1666033/1666033047.JPEG',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        if (hotel != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name ?? "Hotel Belum Ditemukan",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < (hotel.rate ?? 0)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                    );
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
          )
        else
          const Text("Informasi hotel tidak tersedia."),
      ],
    );
  }

  Widget _buildBottomNavigationBar(dynamic package) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mulai dari',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      package.harga != null
                          ? RupiahConverter().formatToRupiah(
                              int.parse(package.harga.toString()))
                          : 'Rp. 0',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFF75B6FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${package.planeSeat} Seat/Bangku",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => OrderPage(id: package.paketId.toString()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryBlue,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Pesan Sekarang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
