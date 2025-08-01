import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get.dart' as getx;
import 'package:mobile_umroh_v2/home_feature/presentation/alquran_page.dart';

import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/package/package/package_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/package/package/package_state.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/profile/get_profile/profile_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/profile/get_profile/profile_state.dart';
import 'package:mobile_umroh_v2/constant/full_image_preview.dart';
import 'package:mobile_umroh_v2/constant/on_progress.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/detail/detail_page.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/home/regist-umrah/regist_umrah_page.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/schedule/schedule_departure_page.dart';
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
    loadRole();
    context.read<ProfileBloc>().getProfile();
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
                Center(
                  child: Text(
                    'السلام عليكم ورحمة الله وبركاته',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                Center(
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
                          Text(username?.toUpperCase() ?? "Loading...",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
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
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is ProfileLoaded) {
                            final images = state.dataProfile;

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => FullImagePage(
                                            imageUrl: images.profilePicture!)));
                              },
                              child: Image.network(
                                "${images.profilePicture}",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            return Image.asset(
                              'assets/image/test-foto.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            );
                          }
                          // return Image.asset(
                          //   'assets/image/test-foto.jpg',
                          //   width: 50,
                          //   height: 50,
                          //   fit: BoxFit.cover,
                          // );
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  itemCount: 7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, i) {
                    final List<Map<String, dynamic>> menu = [
                      {
                        // "title": roles == "11" ? "Jadwal Haji" : "Jadwal Umrah",
                        // "icon": roles == "11"
                        //     ? "assets/icons/jadwal_2.png"
                        //     : "assets/image/Ka'bah.png",
                        // "route": roles == "11"
                        //     ? ScheduleDeparturePage()
                        //     : RegistUmrahPage()
                        "title": "Jadwal Umroh",
                        "icon": "assets/image/Ka'bah.png",
                        "route": RegistUmrahPage()
                      },
                      {
                        "title": "Jadwal Haji",
                        "icon": "assets/icons/jadwal_2.png",
                        "route": ScheduleDeparturePage()
                      },
                      {
                        "title": "Bimbingan Manasik",
                        "icon": "assets/image/Fitur Haji.png",
                        "route": OnProgressPage()
                      },
                      {
                        "title": "Doa Umrah & haji",
                        "icon": "assets/image/Mata Uang.png",
                        "route": OnProgressPage()
                      },
                      {
                        "title": "Al-Qur'an",
                        "icon": "assets/image/Paket Data.png",
                        "route": AlquranView()
                      },
                      {
                        "title": "Jadwal Sholat",
                        "icon": "assets/image/Jadwal Sholat.png",
                        "route": OnProgressPage()
                      },
                      {
                        "title": "Paket data",
                        "icon": "assets/image/Al-Qur'an.png",
                        "route": OnProgressPage()
                      },
                    ];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 3,
                          child: GestureDetector(
                            onTap: () {
                              if (menu[i]['route'] != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => menu[i]['route']!,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(menu[i]['icon']!,
                                  width: 50, height: 50),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              menu[i]['title']!,
                              style: const TextStyle(fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
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
                                      final isDisabled = package.isShow == 1;

                                      return Container(
                                        width: size.width * 0.75,
                                        margin:
                                            const EdgeInsets.only(right: 16),
                                        decoration: BoxDecoration(
                                          color: isDisabled
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                              child: ColorFiltered(
                                                colorFilter: isDisabled
                                                    ? ColorFilter.mode(
                                                        Colors.grey,
                                                        BlendMode.saturation)
                                                    : ColorFilter.mode(
                                                        Colors.transparent,
                                                        BlendMode.multiply),
                                                child: Image.network(
                                                  package.imgThumbnail ?? "",
                                                  width: double.infinity,
                                                  height: size.height * 0.2,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      const Icon(Icons.image,
                                                          size:
                                                              48), // Icon error diperbesar
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(package.namaPaket ?? "-",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: isDisabled
                                                              ? Colors.grey[600]
                                                              : Colors.black)),
                                                  const SizedBox(height: 6),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        if (features.contains(
                                                            "pesawat"))
                                                          _buildIconText(
                                                              Icons
                                                                  .flight_takeoff,
                                                              "Pesawat",
                                                              isDisabled),
                                                        if (features
                                                            .contains("antar"))
                                                          _buildIconText(
                                                              Icons
                                                                  .directions_car,
                                                              "Antar",
                                                              isDisabled),
                                                        if (features
                                                            .contains("hotel"))
                                                          _buildIconText(
                                                              Icons.hotel,
                                                              "Hotel",
                                                              isDisabled),
                                                        if (features
                                                            .contains("bis"))
                                                          _buildIconText(
                                                              Icons
                                                                  .directions_bus,
                                                              "Bus",
                                                              isDisabled),
                                                        if (features.contains(
                                                            "konsumsi"))
                                                          _buildIconText(
                                                              Icons.food_bank,
                                                              "Konsumsi",
                                                              isDisabled)
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Mulai dari",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: isDisabled
                                                                  ? Colors
                                                                      .grey[600]
                                                                  : Colors
                                                                      .black)),
                                                      Text("Sisa Kuota",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: isDisabled
                                                                  ? Colors
                                                                      .grey[600]
                                                                  : Colors
                                                                      .black)),
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
                                                            .formatToRupiah(int
                                                                .parse(package
                                                                        .harga ??
                                                                    "0")),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: isDisabled
                                                              ? Colors.grey[600]
                                                              : const Color(
                                                                  0xFF3A7AFB),
                                                        ),
                                                      ),
                                                      Text(
                                                        package.planeSeat
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: isDisabled
                                                                ? Colors
                                                                    .grey[600]
                                                                : Colors.black),
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
                                                        onPressed: isDisabled
                                                            ? null
                                                            : () {},
                                                        icon: Icon(
                                                            Icons
                                                                .bookmark_border,
                                                            size: 28,
                                                            color: isDisabled
                                                                ? Colors
                                                                    .grey[600]
                                                                : Colors.grey),
                                                      ),
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: isDisabled
                                                              ? null
                                                              : () {
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
                                                            backgroundColor: isDisabled
                                                                ? Colors
                                                                    .grey[300]
                                                                : const Color(
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
                                                          child: Text(
                                                              "Detail Paket",
                                                              style: TextStyle(
                                                                  color: isDisabled
                                                                      ? Colors.grey[
                                                                          600]
                                                                      : Colors
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildIconText(IconData icon, String text, bool isDisabled) {
  return Padding(
    padding: const EdgeInsets.only(right: 12),
    child: Row(
      children: [
        Icon(icon,
            size: 20, color: isDisabled ? Colors.grey[600] : Colors.black),
        const SizedBox(width: 4),
        Text(text,
            style: TextStyle(
                fontSize: 12,
                color: isDisabled ? Colors.grey[600] : Colors.black)),
      ],
    ),
  );
}

// code_connect