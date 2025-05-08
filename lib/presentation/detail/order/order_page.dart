import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get.dart' as gets;
import 'package:mobile_umroh_v2/bloc/package/package_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package_state.dart';

import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/constant/text_constant.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/data_order_page.dart';

class OrderPage extends StatefulWidget {
  final String? id;
  const OrderPage({super.key, this.id});

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
      if (counter > 1) counter--;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<PackageBloc>().getPackageById(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final rupiahConverter = RupiahConverter();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<PackageBloc, PackageState>(
                builder: (context, state) {
              if (state is PackageLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PackageLoadedById) {
                final package = state.packageId;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context)),
                        const Text("Pemesanan",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        const Icon(Icons.share),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Header Paket
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                                package.imgThumbnail.toString(),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(package.namaPaket.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 12,
                                ),
                                package.isVip == true
                                    ? Row(
                                        children: [
                                          Icon(Icons.star,
                                              size: 16, color: Colors.amber),
                                          SizedBox(width: 4),
                                          Text("VIP",
                                              style: TextStyle(
                                                  color: Colors.amber)),
                                        ],
                                      )
                                    : Text("Reguler"),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    if (package.arrFeature
                                            ?.contains("Pesawat") ??
                                        false)
                                      _buildIconText(
                                          Icons.flight_takeoff, "Pesawat"),
                                    if (package.arrFeature?.contains("Antar") ??
                                        false)
                                      _buildIconText(
                                          Icons.directions_car, "Antar"),
                                    if (package.arrFeature?.contains("Hotel") ??
                                        false)
                                      _buildIconText(Icons.hotel, "Hotel"),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Detail Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Perjalanan",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            package.jadwalPerjalanan ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Icon(Icons.sync, size: 20),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Program Hari",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      package.durasiPerjalanan ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
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
                                  children: const [
                                    Text(
                                      "Penerbangan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Saudi Airlines - Bandara Soekarno Hatta (CGK)",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(Icons.sync, size: 20),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
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
                                    const Text(
                                      "Harga Paket",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                        "${rupiahConverter.formatToRupiah(int.parse(package.harga.toString()))} / Paket(Orang)",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextConfig.fontTitle),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Pemesanan Hotel
                    Column(
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
                              Text(package.tHotel![0].name ?? "",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                    ),

                    const SizedBox(height: 16),

                    // Jumlah Orang Dan Total
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(40), // Bulat seperti pill
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: decrementCounter,
                                  child: Icon(
                                    Icons.arrow_left,
                                    size: 32,
                                  )),
                              SizedBox(width: 16),
                              Text("$counter orang"),
                              SizedBox(width: 16),
                              InkWell(
                                  onTap: incrementCounter,
                                  child: Icon(
                                    Icons.arrow_right,
                                    size: 32,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            " ${rupiahConverter.formatToRupiah(int.parse(package.harga.toString()) * counter)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    const Text("Note : Satu kamar terdiri dari 4 orang",
                        style: TextStyle(fontSize: 12)),

                    const SizedBox(height: 16),

                    // Form Data Pemesan
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     const Text(
                    //       "Data Pemesan",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold, fontSize: 16),
                    //     ),
                    //     const SizedBox(height: 16),
                    //     TextFormField(
                    //       controller: nameController,
                    //       decoration: InputDecoration(
                    //         hintText: "Nama Lengkap",
                    //         contentPadding: const EdgeInsets.symmetric(
                    //             horizontal: 20, vertical: 16),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 12),
                    //     DropdownButtonFormField<String>(
                    //       items: genderItems.map((String item) {
                    //         return DropdownMenuItem<String>(
                    //           value: item,
                    //           child: Text(item,
                    //               style: const TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 16,
                    //               )),
                    //         );
                    //       }).toList(),
                    //       onChanged: (value) {
                    //         setState(() {
                    //           selectedGender = value;
                    //         });
                    //       },
                    //       decoration: InputDecoration(
                    //         hintText: "Pilih Jenis Kelamin",
                    //         contentPadding: const EdgeInsets.symmetric(
                    //             horizontal: 20, vertical: 16),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 12),
                    //     TextFormField(
                    //       controller: phoneController,
                    //       decoration: InputDecoration(
                    //         hintText: "No Telp",
                    //         contentPadding: const EdgeInsets.symmetric(
                    //             horizontal: 20, vertical: 16),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 12),
                    //     TextFormField(
                    //       controller: emailController,
                    //       decoration: InputDecoration(
                    //         hintText: "E-mail",
                    //         contentPadding: const EdgeInsets.symmetric(
                    //             horizontal: 20, vertical: 16),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 12),
                    //     TextFormField(
                    //       controller: noteController,
                    //       decoration: InputDecoration(
                    //         hintText: "Catatan (Opsional)",
                    //         contentPadding: const EdgeInsets.symmetric(
                    //             horizontal: 20, vertical: 16),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 12),
                    //     TextFormField(
                    //       controller: referralController,
                    //       decoration: InputDecoration(
                    //         hintText: "Referral (Opsional)",
                    //         contentPadding: const EdgeInsets.symmetric(
                    //             horizontal: 20, vertical: 16),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //         suffixIcon:
                    //             const Icon(Icons.person, color: Colors.blue),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    // const SizedBox(height: 16),

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     const Text("Gabung Sekarang",
                    //         style: TextStyle(fontWeight: FontWeight.bold)),
                    //     const SizedBox(
                    //       height: 8,
                    //     ),
                    //     const Text(
                    //         "Gabung dengan kami agar tidak perlu memasukan data pemesan kembali serta kemudahan registrasi umrah."),
                    //     const SizedBox(height: 8),
                    //     ElevatedButton(
                    //       onPressed: () {},
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.lightBlue,
                    //         shape: StadiumBorder(),
                    //       ),
                    //       child: Text(
                    //         "Daftar Sekarang",
                    //         style: TextStyle(
                    //           color: ColorConstant.secondary100,
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),

                    // const SizedBox(height: 16),

                    // Expandable Tile List
                    Column(
                      children: [
                        ExpansionTile(
                          shape: Border.all(color: Colors.transparent),
                          title: Text("Itinerary",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                  "Detail itinerary akan ditampilkan di sini."),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          shape: Border.all(color: Colors.transparent),
                          title: Text("Fasilitas",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    package.tPaketFasilitas?.map((fasilitas) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 16),
                                                const SizedBox(width: 8),
                                                Text(fasilitas.desc ?? ""),
                                              ],
                                            ),
                                          );
                                        }).toList() ??
                                        [Text("Tidak ada data fasilitas")],
                              ),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          shape: Border.all(color: Colors.transparent),
                          title: Text("Persyaratan Peserta",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                  "Syarat peserta akan dijelaskan di sini."),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          shape: Border.all(color: Colors.transparent),
                          title: Text("Syarat dan Ketentuan",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                  "Ketentuan umum pemesanan ditampilkan di sini."),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 100), // Space for bottom bar
                  ],
                );
              }
              return Container();
            })),
      ),
      bottomSheet: BlocBuilder<PackageBloc, PackageState>(
        builder: (context, state) {
          if (state is PackageLoadedById) {
            final package = state.packageId;

            return Container(
              padding: const EdgeInsets.all(16),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.download),
                  const Icon(Icons.chat_bubble_outline),
                  ElevatedButton(
                    onPressed: () {
                    
                        Get.to(
                            () => DataOrderPage(
                                 
                                  totalOrang: counter,
                                  id: package.paketId,
                                ),
                            transition: gets.Transition.rightToLeft);
                      },
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF75B6FF),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Pesan Sekarang',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            );
          }
          // Show a loading indicator or empty container while waiting for the data
          return Container(
            padding: const EdgeInsets.all(16),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.download),
                const Icon(Icons.chat_bubble_outline),
                ElevatedButton(
                  onPressed: null, // Disabled while data is loading
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Pesan Sekarang',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          );
        },
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
