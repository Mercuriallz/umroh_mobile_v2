import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get.dart' as gets;
import 'package:mobile_umroh_v2/bloc/package/package_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/payment_text_field.dart';

import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/constant/text_constant.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/data_order_page.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

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
  final amountController = TextEditingController();

  List<String> genderItems = [
    'Laki-laki',
    'Perempuan',
  ];

  List<String> typePayment = [
    "BANK TRANSFER",
    "VIRTUAL ACCOUNT",
  ];

  List<String> typePaymentUser = [
    "Cicilan Bank",
    "Bayar Lunas",
  ];

  Map<String, String> typePaymentValues = {
    "BANK TRANSFER": "BANK_TRANSFER",
    "VIRTUAL ACCOUNT": "VIRTUAL_ACCOUNT",
  };

  Map<String, int> typePaymentUserValues = {
    "Cicilan Bank": 1,
    "Bayar Lunas": 0,
  };

  String? selectedGender;
  String? selectedTypePayment;
  String? selectedTypePaymentValue;
  String? selectedTypePaymentUser;
  int? selectedTypePaymentUserValue;

  int counter = 1;
  final secureStorage = SecureStorageService();

  String? roleId;

  void loadRoleId() async {
    final role = await secureStorage.read("role");
    setState(() {
      roleId = role;
    });
  }

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
    loadRoleId();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    noteController.dispose();
    referralController.dispose();
    amountController.dispose();
    super.dispose();
  }

  bool validateAmount() {
    if (amountController.text.isEmpty) {
      Get.snackbar(
        "Perhatian",
        "Jumlah pembayaran harus diisi",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return false;
    }

    if(selectedTypePayment == null) {
      Get.snackbar(
        "Perhatian",
        "Tipe pembayaran harus dipilih",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return false;
    }

    if (selectedTypePaymentUser == null) {
      Get.snackbar(
        "Perhatian",
        "Tipe pembayaran user harus dipilih",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return false;
    }

    String cleanedAmount =
        amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanedAmount.isEmpty || int.parse(cleanedAmount) <= 0) {
      Get.snackbar(
        "Perhatian",
        "Jumlah pembayaran tidak valid",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    // print("Role ID: $roleId");
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

                    roleId == "2"
                        ? Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                          )
                        : SizedBox(),

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

                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: "Pilih Tipe Pembayaran",
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      value: selectedTypePaymentUser,
                      items: typePaymentUser
                          .map((String displayText) => DropdownMenuItem<String>(
                                value: displayText,
                                child: Text(displayText),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTypePaymentUser = value;
                          if (value != null) {
                            selectedTypePaymentUserValue =
                                typePaymentUserValues[value];
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: "Pilih Jenis Pembayaran",
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      value: selectedTypePayment,
                      items: typePayment
                          .map((String displayText) => DropdownMenuItem<String>(
                                value: displayText,
                                child: Text(displayText),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTypePayment = value;
                          if (value != null) {
                            selectedTypePaymentValue = typePaymentValues[value];
                          }
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      inputFormatters: [RupiahInputFormatter()],
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      decoration: InputDecoration(
                        hintText: "Jumlah Pembayaran",
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        // Adding a prefix icon for better UX
                        prefixIcon: const Icon(Icons.payments_outlined),
                        // Adding a suffix text for clarity
                        suffixText: "IDR",
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      controller: noteController,
                      decoration: InputDecoration(
                        hintText: "Note",
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),

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
                      if (validateAmount()) {
                        Get.to(
                            () => DataOrderPage(
                                  typePayment: selectedTypePaymentValue,
                                  typePaymentUser: selectedTypePaymentUserValue,
                                  priceFinal:
                                      int.parse(package.harga.toString()) *
                                          counter,
                                  totalOrang: counter,
                                  id: package.paketId,
                                  amount: amountController.text,
                                  note: noteController.text,
                                ),
                            transition: gets.Transition.rightToLeft);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryBlue,
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
          return Container(
            padding: const EdgeInsets.all(16),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.download),
                const Icon(Icons.chat_bubble_outline),
                ElevatedButton(
                  onPressed: null,
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
