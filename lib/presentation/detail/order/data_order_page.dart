import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/bloc/package/package_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package_state.dart';
import 'package:mobile_umroh_v2/bloc/payment/payment_bloc.dart';
import 'package:mobile_umroh_v2/bloc/payment/payment_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';
import 'package:mobile_umroh_v2/constant/loading.dart';
import 'package:mobile_umroh_v2/model/payment/payment_model.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/add_jemaah_page.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/detail_order_page.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class DataOrderPage extends StatefulWidget {
  final String? amount;
  final String? note;
  final int? priceFinal;
  final int? totalOrang;
  final int? id;

  const DataOrderPage({
    super.key,
    this.amount,
    this.note,
    this.priceFinal,
    required this.totalOrang,
    required this.id,
  });

  @override
  State<DataOrderPage> createState() => _DataOrderPageState();
}

class _DataOrderPageState extends State<DataOrderPage> {
  List<Map<String, String>> jemaahList = [];
  List<bool> expandedList = [];

  @override
  void initState() {
    super.initState();
    context.read<PackageBloc>().getPackageById(widget.id.toString());
    expandedList = List.generate(jemaahList.length, (_) => false);
  }

  void navigateToTambahJemaah() async {
    if (jemaahList.length >= (widget.totalOrang ?? 0)) {
      Get.snackbar(
        "Data jamaah sudah penuh",
        "Jumlah jamaah sudah sesuai dengan total orang yang dipilih.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: ColorConstant.secondary100,
        backgroundColor: Colors.red,
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddJemaahPage()),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        jemaahList.add(result);
        expandedList.add(false);
      });
    }
  }

  // Toggle expansion state for a specific jemaah card
  void toggleExpansion(int index) {
    setState(() {
      expandedList[index] = !expandedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final paymentVM = context.read<PaymentBloc>();
    final totalJemaah = jemaahList.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
            CustomBackHeader(title: "Data Pemesanan", onBack: () => Navigator.pop(context)),
              const SizedBox(height: 24),
              Expanded(child: SingleChildScrollView(
                child: BlocListener<PaymentBloc, PaymentState>(
                  listener: (context, state) {
                    if (state is PaymentLoading) {
                      LoadingOverlay(
                      lottiePath: 'assets/lottie/loading_animation.json',
                      message: 'Pesananmu sedang diproses',
                      );
                    } else if (state is PaymentSuccess) {
                      Get.snackbar(
                        "Pesanan Berhasil Dibuat",
                        "Pesanan Anda telah berhasil dibuat. Silahkan lakukan pembayaran.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 3),
                      );
                      Get.offAll(DetailOrderPage());
                    } else if (state is PaymentFailed) {
                      Navigator.pop(context); //
                      Get.snackbar(
                        "Gagal Membuat Pesanan",
                        state.message,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 3),
                      );
                    }
                  },
                  child: BlocBuilder<PackageBloc, PackageState>(
                    builder: (context, state) {
                      if (state is PackageLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is PackageLoadedById) {
                        final package = state.packageId;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Informasi Pemesanan Section
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Informasi Pemesanan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  const SizedBox(height: 12),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF9F9F9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 2,
                                            child: Text("Kode Paket",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                                package.kodePaket.toString(),
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    color: Colors.blue))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF9F9F9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 2,
                                            child: Text("Nama Paket",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                                package.namaPaket.toString(),
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    color: Colors.blue))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF9F9F9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 2,
                                            child: Text("Jenis Paket",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                                package.isVip == true
                                                    ? "VIP"
                                                    : "Reguler",
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    color: Colors.blue))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF9F9F9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 2,
                                            child: Text("Pelaksanaan",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                                package.jadwalPerjalanan
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    color: Colors.blue))),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Text("Lihat Informasi Pemesanan",
                                        style: TextStyle(color: Colors.blue)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Data Jama'ah",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Text("$totalJemaah / ${widget.totalOrang}",
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Expandable Jemaah Cards
                            ...jemaahList.asMap().entries.map((entry) {
                              final index = entry.key;
                              final jemaah = entry.value;
                              // Make sure expandedList has enough elements
                              if (expandedList.length <= index) {
                                expandedList.add(false);
                              }
                              final isExpanded = expandedList[index];
                              
                              return Dismissible(
                                key: UniqueKey(),
                                direction: index == 0
                                    ? DismissDirection.none
                                    : DismissDirection.endToStart,
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade400,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.delete, color: Colors.white),
                                ),
                                onDismissed: (_) {
                                  setState(() {
                                    jemaahList.removeAt(index);
                                    expandedList.removeAt(index);
                                  });
                                  Get.snackbar(
                                    "Jama'ah Dihapus",
                                    "${jemaah['nama']} telah dihapus",
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: ColorConstant.secondary100,
                                    backgroundColor: Colors.red,
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      // Header with status badge (always visible)
                                      InkWell(
                                        onTap: () => toggleExpansion(index),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.only(
                                              topLeft: const Radius.circular(16),
                                              topRight: const Radius.circular(16),
                                              bottomLeft: isExpanded ? Radius.zero : const Radius.circular(16),
                                              bottomRight: isExpanded ? Radius.zero : const Radius.circular(16),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Colors.blue,
                                                    radius: 16,
                                                    child: Text(
                                                      jemaah['nama']?.substring(0, 1).toUpperCase() ?? "J",
                                                      style: const TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Text(
                                                    jemaah['nama'] ?? "Nama Jamaah",
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: index == 0 ? Colors.blue : Colors.green,
                                                      borderRadius: BorderRadius.circular(16),
                                                    ),
                                                    child: Text(
                                                      index == 0 ? "Pemesan" : jemaah['type_jemaah'] ?? "Jamaah",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Icon(
                                                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      
                                      if (isExpanded)
                                        Column(
                                          children: [
                                            // Content
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                children: [
                                                  // Personal info section
                                                  _buildInfoRow(
                                                    Icons.badge_outlined,
                                                    "NIK",
                                                    jemaah['nik'] ?? "-",
                                                  ),
                                                  _buildInfoRow(
                                                    jemaah['jenis_kelamin'] == "Laki-laki" 
                                                        ? Icons.male 
                                                        : Icons.female,
                                                    "Jenis Kelamin",
                                                    jemaah['jenis_kelamin'] ?? "-",
                                                  ),
                                                  
                                                  const Divider(height: 24),
                                                  
                                                  // Contact info section
                                                  _buildInfoRow(
                                                    Icons.phone_outlined,
                                                    "Telepon",
                                                    jemaah['phone'] ?? "-",
                                                  ),
                                                  _buildInfoRow(
                                                    Icons.email_outlined,
                                                    "Email",
                                                    jemaah['email'] ?? "-",
                                                  ),
                                                  
                                                  // Only show password if needed (maybe hide by default)
                                                  if (jemaah['password'] != null && jemaah['password']!.isNotEmpty)
                                                    _buildInfoRow(
                                                      Icons.lock_outlined,
                                                      "Password",
                                                      "••••••••", 
                                                    ),
                                                ],
                                              ),
                                            ),
                                            
                                            // Footer with edit action
                                            if (index != 0) // Only show this for non-lead jamaah
                                              Container(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(color: Colors.black12),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    TextButton.icon(
                                                      onPressed: () {
                                                        // Edit action would go here
                                                      },
                                                      icon: const Icon(Icons.edit_outlined, size: 16),
                                                      label: const Text("Edit", style: TextStyle(fontSize: 12)),
                                                    ),
                                                    const SizedBox(width: 8),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }),

                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: navigateToTambahJemaah,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.primaryBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                ),
                                child: const Text("Tambah +",
                                    style: TextStyle(color: Colors.blue)),
                              ),
                            ),

                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (jemaahList.length != widget.totalOrang) {
                                    Get.snackbar(
                                      "Jumlah belum sesuai",
                                      "Tambahkan semua data jamaah terlebih dahulu",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.orange,
                                      colorText: Colors.white,
                                    );
                                    return;
                                  }
                                  
                                  String cleanedAmount = widget.amount.toString().replaceAll(RegExp(r'[^\d]'), '');
                                  int parsedAmount = int.parse(cleanedAmount);
                                  
                                  final secureStorage = SecureStorageService();
                                  final token = await secureStorage.read("token");
                                  final anggotaList = jemaahList
                                      .map((jemaah) => UserReg(
                                            name: jemaah['nama'],
                                            email: jemaah['email'],
                                            phoneNumber: jemaah['phone'],
                                            nik: jemaah['nik'],
                                            password: jemaah['password'],
                                          ))
                                      .toList();

                                  // Mengecek apakah token kosong
                                  if (token == null || token.isEmpty) {
                                    Get.snackbar(
                                      "Token Tidak Ditemukan",
                                      "Harap login terlebih dahulu untuk melanjutkan",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  } else {
                                    var data = PaymentModel(
                                        purchaseTitle: package.namaPaket,
                                        paketId: package.paketId,
                                        priceFinal: widget.priceFinal,
                                        amount: parsedAmount,
                                        typePayment: "BANK_TRANSFER",
                                        notes: widget.note,
                                        userReg: anggotaList);
                                    paymentVM.sendPayment(data);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.primaryBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28)),
                                ),
                                child: const Text("Buat Pesanan",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoRow(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}