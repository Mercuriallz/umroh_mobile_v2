import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/package/package_id/package_id_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/package/package_id/package_id_state.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/payment/payment_bloc.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/bloc/payment/payment_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';
import 'package:mobile_umroh_v2/constant/loading.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/model/payment/payment_model.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/bottombar/bottom_bar.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/detail/order/add_jemaah_page.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class DataOrderPage extends StatefulWidget {
  final String? amount;
  final String? note;
  final String? typePayment;
  final String? selectedJenisPembayaran;
  final int? typePaymentUser;
  final int? priceFinal;
  final int? totalOrang;
  final int? id;

  const DataOrderPage({
    super.key,
    this.amount,
    this.note,
    this.typePayment,
    this.typePaymentUser,
    this.priceFinal,
    this.selectedJenisPembayaran,
    required this.totalOrang,
    required this.id,
  });

  @override
  State<DataOrderPage> createState() => _DataOrderPageState();
}

class _DataOrderPageState extends State<DataOrderPage> {
  // Ubah tipe data untuk mendukung File
  List<Map<String, dynamic>> jemaahList = [];
  List<bool> expandedList = [];
  bool isLoading = false;
  bool isAddingJemaah = false;
  bool hasInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    expandedList = List.generate(jemaahList.length, (_) => false);
  }

  void _initializeData() {
    if (!mounted || hasInitialized) return;

    setState(() {
      hasInitialized = true;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        context.read<PackageIdBloc>().getPackageById(widget.id.toString());
      }
    });
  }

  File? _convertToFile(dynamic imageData) {
    if (imageData == null) return null;
    if (imageData is File) return imageData;
    // Jika imageData adalah path string, convert ke File
    if (imageData is String && imageData.isNotEmpty) {
      return File(imageData);
    }
    return null;
  }

  void navigateToTambahJemaah() async {
    if (isAddingJemaah) return;

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

    setState(() {
      isAddingJemaah = true;
    });

    try {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddJemaahPage()),
      );

      // Ubah pengecekan tipe data
      if (result != null && result is Map<String, dynamic>) {
        setState(() {
          jemaahList.add(result);
          expandedList.add(false);
        });
      }
    } catch (e) {
      // Handle navigation errors
    } finally {
      if (mounted) {
        setState(() {
          isAddingJemaah = false;
        });
      }
    }
  }

  void toggleExpansion(int index) {
    if (index >= 0 && index < expandedList.length) {
      setState(() {
        expandedList[index] = !expandedList[index];
      });
    }
  }

  void _dismissDialogs() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Future<void> _sendPayment(PaymentModel paymentData) async {
    try {
      _showLoadingDialog();

      setState(() {
        isLoading = true;
      });

      final paymentVM = context.read<PaymentBloc>();
      paymentVM.sendPayment(paymentData);
    } catch (e) {
      _dismissDialogs();

      setState(() {
        isLoading = false;
      });

      Get.snackbar(
        "Error",
        "Terjadi kesalahan tidak terduga: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingOverlay(
          lottiePath: 'assets/lottie/loading_animation.json',
          message: 'Pesananmu sedang diproses',
        );
      },
    );
  }

  // Helper function untuk mendapatkan nama file dari File object
  String _getFileDisplayName(dynamic file) {
    if (file == null) return "-";
    if (file is File) {
      return file.path.split('/').last;
    }
    return file.toString();
  }

  bool _hasDocuments(Map<String, dynamic> jemaah) {
    return jemaah['img_ktp'] != null ||
        jemaah['img_passport'] != null ||
        jemaah['img_kk'] != null ||
        jemaah['img_vaksin'] != null ||
        jemaah['img_pas_foto'] != null ||
        jemaah['img_bpjs_kesehatan'] != null;
  }

  @override
  Widget build(BuildContext context) {
    final totalJemaah = jemaahList.length;

    return PopScope(
      canPop: !isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                CustomBackHeader(
                    title: "Data Pemesanan",
                    onBack: () => isLoading ? null : Navigator.pop(context)),
                const SizedBox(height: 24),
                Expanded(
                    child: SingleChildScrollView(
                  child: BlocListener<PaymentBloc, PaymentState>(
                    listener: (context, state) {
                      if (state is PaymentLoading) {
                        setState(() {
                          isLoading = true;
                        });
                      } else if (state is PaymentSuccess) {
                        _dismissDialogs();
                        Get.offAll(BottomMain());
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Get.snackbar(
                            "Pesanan Berhasil Dibuat",
                            "Pesanan Anda telah berhasil dibuat. Silahkan lakukan pembayaran.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 3),
                          );
                        });
                      } else if (state is PaymentFailed) {
                        setState(() {
                          isLoading = false;
                        });
                        _dismissDialogs();
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Get.snackbar(
                            "Gagal Membuat Pesanan",
                            state.message,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 3),
                          );
                        });
                      }
                    },
                    child: BlocBuilder<PackageIdBloc, PackageIdState>(
                      builder: (context, state) {
                        if (state is PackageIdLoading) {
                          return const Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 100),
                            child: CircularProgressIndicator(),
                          ));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade400,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                  onDismissed: (_) {
                                    if (isLoading) {
                                      return;
                                    }
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
                                        InkWell(
                                          onTap: () => toggleExpansion(index),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(16),
                                                topRight:
                                                    const Radius.circular(16),
                                                bottomLeft: isExpanded
                                                    ? Radius.zero
                                                    : const Radius.circular(16),
                                                bottomRight: isExpanded
                                                    ? Radius.zero
                                                    : const Radius.circular(16),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          ColorConstant
                                                              .primaryBlue,
                                                      radius: 16,
                                                      child: Text(
                                                        jemaah['nama']
                                                                ?.substring(
                                                                    0, 1)
                                                                .toUpperCase() ??
                                                            "J",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          jemaah['nama'] ??
                                                              "Nama Jamaah",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        // Tampilkan indikator dokumen
                                                        if (_hasDocuments(
                                                            jemaah))
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.folder,
                                                                size: 12,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              const SizedBox(
                                                                  width: 4),
                                                              Text(
                                                                "Dokumen tersedia",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: index == 0
                                                            ? ColorConstant
                                                                .primaryBlue
                                                            : Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      child: Text(
                                                        index == 0
                                                            ? "Pemesan"
                                                            : "Jemaah",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Icon(
                                                      isExpanded
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down,
                                                      color:
                                                          Colors.grey.shade600,
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
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  children: [
                                                    // Personal info section
                                                    _buildInfoRow(
                                                      Icons.badge_outlined,
                                                      "NIK",
                                                      jemaah['nik']
                                                              ?.toString() ??
                                                          "-",
                                                    ),
                                                    _buildInfoRow(
                                                      jemaah['jenis_kelamin'] ==
                                                              "Laki-laki"
                                                          ? Icons.male
                                                          : Icons.female,
                                                      "Jenis Kelamin",
                                                      jemaah['jenis_kelamin']
                                                              ?.toString() ??
                                                          "-",
                                                    ),

                                                    const Divider(height: 24),

                                                    // Contact info section
                                                    _buildInfoRow(
                                                      Icons.phone_outlined,
                                                      "Telepon",
                                                      jemaah['phone']
                                                              ?.toString() ??
                                                          "-",
                                                    ),
                                                    _buildInfoRow(
                                                      Icons.email_outlined,
                                                      "Email",
                                                      jemaah['email']
                                                              ?.toString() ??
                                                          "-",
                                                    ),

                                                    _buildInfoRow(
                                                      Icons.person,
                                                      "Hubungan",
                                                      jemaah['hubungan_kerabat']
                                                              ?.toString() ??
                                                          "-",
                                                    ),

                                                    const Divider(height: 24),

                                                    // Documents section - Tampilkan file yang sudah diupload
                                                    const Text(
                                                      "Dokumen",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),

                                                    _buildInfoRow(
                                                        Icons.file_copy,
                                                        "File KTP",
                                                        _getFileDisplayName(
                                                            jemaah['img_ktp'])),

                                                    _buildInfoRow(
                                                        Icons.file_copy,
                                                        "File KK",
                                                        _getFileDisplayName(
                                                            jemaah['img_kk'])),

                                                    _buildInfoRow(
                                                        Icons.file_copy,
                                                        "File Paspor",
                                                        _getFileDisplayName(
                                                            jemaah[
                                                                'img_passport'])),

                                                    _buildInfoRow(
                                                      Icons.file_copy,
                                                      "File Foto",
                                                      _getFileDisplayName(
                                                          jemaah[
                                                              'img_pas_foto']),
                                                    ),

                                                    _buildInfoRow(
                                                        Icons.file_copy,
                                                        "File Sertifikat Vaksin",
                                                        _getFileDisplayName(
                                                            jemaah[
                                                                'img_vaksin'])),

                                                    _buildInfoRow(
                                                        Icons.file_copy,
                                                        "File BPJS",
                                                        _getFileDisplayName(jemaah[
                                                            'img_bpjs_kesehatan'])),
                                                  ],
                                                ),
                                              ),

                                              // Footer with edit action
                                              if (index != 0 && !isLoading)
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          color:
                                                              Colors.black12),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton.icon(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                            Icons.edit_outlined,
                                                            size: 16),
                                                        label: const Text(
                                                            "Edit",
                                                            style: TextStyle(
                                                                fontSize: 12)),
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
                                  onPressed: isLoading || isAddingJemaah
                                      ? null
                                      : navigateToTambahJemaah,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isLoading || isAddingJemaah
                                        ? Colors.grey
                                        : ColorConstant.primaryBlue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                  ),
                                  child: isAddingJemaah
                                      ? const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text("Menambahkan...",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        )
                                      : const Text("Tambah +",
                                          style:
                                              TextStyle(color: Colors.white)),
                                ),
                              ),

                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: (isLoading || isAddingJemaah)
                                      ? null
                                      : () async {
                                          if (jemaahList.length !=
                                              widget.totalOrang) {
                                            Get.snackbar(
                                              "Jumlah belum sesuai",
                                              "Tambahkan semua data jamaah terlebih dahulu",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.orange,
                                              colorText: Colors.white,
                                            );
                                            return;
                                          }

                                          try {
                                            // String cleanedAmount = widget.amount
                                            //     .toString()
                                            //     .replaceAll(
                                            //         RegExp(r'[^\d]'), '');
                                            // int parsedAmount =
                                            //     int.parse(cleanedAmount);

                                            final secureStorage =
                                                SecureStorageService();
                                            final token = await secureStorage
                                                .read("token");

                                            if (token == null ||
                                                token.isEmpty) {
                                              Get.snackbar(
                                                "Token Tidak Ditemukan",
                                                "Harap login terlebih dahulu untuk melanjutkan",
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white,
                                              );
                                              return;
                                            }

                                            final anggotaList = jemaahList
                                                .map((jemaah) => UserReg(
                                                      name: jemaah['nama']
                                                          ?.toString(),
                                                      email: jemaah['email']
                                                          ?.toString(),
                                                      phoneNumber:
                                                          jemaah['phone']
                                                              ?.toString(),
                                                      nik: jemaah['nik']
                                                          ?.toString(),
                                                      password:
                                                          jemaah['password']
                                                              ?.toString(),
                                                      hubunganKerabat: jemaah[
                                                              'hubungan_kerabat']
                                                          ?.toString(),
                                                      imgKtp: _convertToFile(
                                                          jemaah['img_ktp']),
                                                      imgPassport:
                                                          _convertToFile(jemaah[
                                                              'img_passport']),
                                                      imgKk: _convertToFile(
                                                          jemaah['img_kk']),
                                                      imgVaksin: _convertToFile(
                                                          jemaah['img_vaksin']),
                                                      imgPasFoto:
                                                          _convertToFile(jemaah[
                                                              'img_pas_foto']),
                                                      imgBpjsKesehatan:
                                                          _convertToFile(jemaah[
                                                              'img_bpjs_kesehatan']),
                                                    ))
                                                .toList();

                                            var data = PaymentModel(
                                                purchaseTitle:
                                                    package.namaPaket,
                                                paketId: int.parse(package.paketId.toString()),
                                                priceFinal: int.parse(
                                                    widget.priceFinal.toString()),
                                                amount: int.parse("0".toString()),
                                                typePayment: widget.typePayment,
                                                typeVaChoice: widget.selectedJenisPembayaran,
                                                typePaymentUser:
                                                   int.parse( widget.typePaymentUser.toString()),
                                                userReg: anggotaList);

                                            _sendPayment(data);
                                          } catch (e) {
                                            Get.snackbar(
                                              "Error",
                                              "Terjadi kesalahan saat memproses data: $e",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        (isLoading || isAddingJemaah)
                                            ? Colors.grey
                                            : ColorConstant.primaryBlue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(28)),
                                  ),
                                  child: isLoading
                                      ? const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Text("Memproses...",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                          ],
                                        )
                                      : const Text("Buat Pesanan",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
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
        Expanded(
          // Menyediakan ruang fleksibel untuk teks panjang
          child: Column(
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
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
