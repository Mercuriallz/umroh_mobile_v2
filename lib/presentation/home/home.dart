import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get.dart' as getx;

import 'package:mobile_umroh_v2/bloc/package/package/package_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package/package_state.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/presentation/detail/detail_page.dart';
import 'package:mobile_umroh_v2/services/storage.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final RefreshController _refreshController = RefreshController();
  final secureStorage = SecureStorageService();
  String? username;
  String? roles;

  void loadUsername() async {
    final name = await secureStorage.read("name");
    setState(() {
      username = name.toString();
    });
  }

  void loadRole() async {
    final role = await secureStorage.read("role");
    setState(() {
      roles = role.toString();
    });
  }

  void refreshData() {
    context.read<PackageBloc>().getPackage();
  }

  Future<void> onRefresh() async {
    context.read<PackageBloc>().getPackage();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadUsername();
    refreshData();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive) {
      refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("id role : $roles");
    final size = MediaQuery.of(context).size;
    final rupiahConverter = RupiahConverter();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      body: SafeArea(
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: onRefresh,
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(username ?? "-",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          const Text("000123",
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
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, i) {
                    final menu = [
                      {"title": "Umrah", "icon": "assets/image/Ka'bah.png"},
                      {
                        "title": "Bimbingan",
                        "icon": "assets/image/Bimbingan.png"
                      },
                      {
                        "title": "Fitur Haji",
                        "icon": "assets/image/Fitur Haji.png"
                      },
                      {
                        "title": "Kurs & Mata Uang",
                        "icon": "assets/image/Mata Uang.png"
                      },
                      {
                        "title": "Paket Data",
                        "icon": "assets/image/Paket Data.png"
                      },
                      {
                        "title": "Jadwal Sholat",
                        "icon": "assets/image/Jadwal Sholat.png"
                      },
                      {
                        "title": "Al-qur'an",
                        "icon": "assets/image/Al-Qur'an.png"
                      },
                      {"title": "Lainnya", "icon": "assets/icons/blocks 1.png"},
                    ];
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            // boxShadow: [
                            //   BoxShadow(color: Colors.black12, blurRadius: 6),
                            // ],
                          ),
                          child: Image.asset(menu[i]['icon']!,
                              width: 28, height: 28),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            menu[i]['title']!,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 30),
                BlocBuilder<PackageBloc, PackageState>(
                  builder: (context, state) {
                    if (state is PackageLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PackageLoaded) {
                      final packages = state.package;
          
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Paket Umrah",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: size.height * 0.45,
                            child: packages.isEmpty
                                ? const Center(
                                    child: Text("Tidak ada paket tersedia"))
                                : ListView.builder(
                                    itemCount: packages.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      final package = packages[i];
                                      final features = package.arrFeature
                                              ?.map((e) => e.toLowerCase())
                                              .toList() ??
                                          [];
                                      return Container(
                                        width: size.width * 0.75,
                                        margin: const EdgeInsets.only(right: 16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 10)
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                              child: Image.network(
                                                package.imgThumbnail ?? "",
                                                width: double.infinity,
                                                height: size.height * 0.2,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const Icon(Icons.image),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(package.namaPaket ?? "-",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  const SizedBox(height: 6),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        if (features
                                                            .contains("pesawat"))
                                                          _buildIconText(
                                                              Icons
                                                                  .flight_takeoff,
                                                              "Pesawat"),
                                                        if (features
                                                            .contains("antar"))
                                                          _buildIconText(
                                                              Icons
                                                                  .directions_car,
                                                              "Antar"),
                                                        if (features
                                                            .contains("hotel"))
                                                          _buildIconText(
                                                              Icons.hotel,
                                                              "Hotel"),
                                                        if (features
                                                            .contains("bis"))
                                                          _buildIconText(
                                                              Icons
                                                                  .directions_bus,
                                                              "Bus"),
                                                        if (features
                                                            .contains("konsumsi"))
                                                          _buildIconText(
                                                              Icons.food_bank,
                                                              "Konsumsi")
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Mulai dari",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                      Text("Seat / Bangku :",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        rupiahConverter
                                                            .formatToRupiah(
                                                                int.parse(package
                                                                        .harga ??
                                                                    "0")),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xFF3A7AFB),
                                                        ),
                                                      ),
                                                      Text(
                                                        package.planeSeat
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                            Icons.bookmark_border,
                                                            color: Colors.grey),
                                                      ),
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Get.to(
                                                                transition: getx
                                                                    .Transition
                                                                    .rightToLeft,
                                                                () => DetailPage(
                                                                    id: package
                                                                        .paketId
                                                                        .toString()))?.then(
                                                                (_) {
                                                              refreshData();
                                                            });
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFF70B8FF),
                                                            minimumSize:
                                                                const Size
                                                                    .fromHeight(
                                                                    40),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          32),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                              "Detail Paket",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
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
                    } else if (state is PackageError) {
                      return Text("Terjadi kesalahan: ${state.message}");
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                // Container(
                //   padding: const EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(16),
                //     boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                //   ),
                //   child: const Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         children: [
                //           Icon(Icons.location_pin, size: 16, color: Colors.grey),
                //           SizedBox(width: 4),
                //           Text("Bojong", style: TextStyle(fontSize: 12)),
                //         ],
                //       ),
                //       Text("Isya", style: TextStyle(fontWeight: FontWeight.bold)),
                //       Text("19:19 Malam",
                //           style: TextStyle(color: Colors.black54)),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 20),
                // const Text("Panduan Umrah",
                //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                // const SizedBox(height: 12),
                // Column(
                //   children: List.generate(3, (index) {
                //     return Container(
                //       margin: const EdgeInsets.only(bottom: 10),
                //       padding: const EdgeInsets.all(12),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(16),
                //         boxShadow: [
                //           BoxShadow(color: Colors.black12, blurRadius: 6)
                //         ],
                //       ),
                //       child: Row(
                //         children: [
                //           Container(
                //             width: 60,
                //             height: 60,
                //             color: Colors.grey[300],
                //           ),
                //           const SizedBox(width: 12),
                //           const Expanded(
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                     "Tata Cara Menjalankan Umrah yang baik dan benar",
                //                     style:
                //                         TextStyle(fontWeight: FontWeight.w500)),
                //                 SizedBox(height: 6),
                //                 Text("Durasi 10 jam",
                //                     style: TextStyle(
                //                         fontSize: 12, color: Colors.grey)),
                //               ],
                //             ),
                //           )
                //         ],
                //       ),
                //     );
                //   }),
                // ),
                // const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
