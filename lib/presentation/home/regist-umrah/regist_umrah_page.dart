import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/bloc/package/package_active/package_active_bloc.dart';
import 'package:mobile_umroh_v2/bloc/package/package_active/package_active_state.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
// import 'package:mobile_umroh_v2/constant/constant.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/constant/shimmer.dart';
import 'package:mobile_umroh_v2/model/package/package_active.dart';
import 'package:mobile_umroh_v2/presentation/detail/detail_page.dart';

class RegistUmrahPage extends StatefulWidget {
  const RegistUmrahPage({super.key});

  @override
  State<RegistUmrahPage> createState() => _RegistUmrahPageState();
}

class _RegistUmrahPageState extends State<RegistUmrahPage> {
  DataPackageActive? selectedPackage;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PackageActiveBloc>().getActivePackage();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showPackagePicker(List<DataPackageActive> packages) async {
  final rupiahConverter = RupiahConverter();
  final selected = await showModalBottomSheet<DataPackageActive>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        maxChildSize: 0.95,
        minChildSize: 0.4,
        builder: (_, controller) => Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Pilih Paket Umrah',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                controller: controller,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  final pkg = packages[index];
                  return GestureDetector(
                    onTap: () => Navigator.pop(context, pkg),
                    child: Container(
                      margin:  EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[300]!),
                       
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (pkg.imgThumbnail != null && pkg.imgThumbnail!.isNotEmpty)
                             ShimmerImage(
                        imageUrl: "http://101.50.2.190:9000/umroh/${pkg.imgThumbnail!}",
                        height: 180,
                        borderRadius: BorderRadius.circular(12),
                      ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pkg.namaPaket ?? "-",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.attach_money, size: 18, color: Colors.green),
                                    const SizedBox(width: 6),
                                    Text(
                                      rupiahConverter.formatToRupiah(
                                          int.tryParse(pkg.harga.toString()) ?? 0),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 18, color: Colors.blue),
                                    const SizedBox(width: 6),
                                    Text(pkg.jadwalPerjalanan ?? "-",
                                        style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.timelapse,
                                        size: 18, color: Colors.orange),
                                    const SizedBox(width: 6),
                                    Text(pkg.durasiPerjalanan ?? "-",
                                        style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );

   if (selected != null) {
      setState(() {
        selectedPackage = selected;
      });
    }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackHeader(
                onBack: () => Navigator.pop(context),
                title: 'Pilih Paket Umrah',
              ),

              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [Colors.teal[600]!, Colors.teal[400]!],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  color: ColorConstant.primaryBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mosque, color: Colors.white, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          "Pilih Paket Umrah",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Pilih paket umrah yang sesuai dengan kebutuhan Anda",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Dropdown Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.card_travel,
                            color: Colors.teal[600], size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          "Paket Tersedia",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<PackageActiveBloc, PackageActiveState>(
                      builder: (context, state) {
                        if (state is PackageActiveLoaded) {
                          final packages = state.dataPackageActive;

                          if (packages.isEmpty) {
                            return _buildEmptyState();
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Paket Umrah Terpilih",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () => _showPackagePicker(packages),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 18),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[300]!),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          selectedPackage?.namaPaket ??
                                              "Pilih salah satu paket",
                                          style: TextStyle(
                                            color: selectedPackage != null
                                                ? Colors.black
                                                : Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_down,
                                          color: Colors.teal[600]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (state is PackageActiveError) {
                          return _buildErrorState(state.message);
                        } else if (state is PackageActiveInitial) {
                          return _buildLoadingState();
                        } else {
                          return _buildEmptyState();
                        }
                      },
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Selected Package Details
              if (selectedPackage != null) _buildSelectedPackageCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 12),
            Text("Memuat paket..."),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red[600], size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.red[600]),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, color: Colors.grey[600], size: 20),
            const SizedBox(width: 8),
            Text(
              "Tidak ada paket tersedia",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedPackageCard() {
    final rupiahConverter = RupiahConverter();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorConstant.primaryBlue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.check_circle,
                      color: ColorConstant.primaryBlue, size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Paket Terpilih",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    Icons.card_travel,
                    "Nama Paket",
                    selectedPackage!.namaPaket ?? "-",
                    Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow(
                    Icons.payments,
                    "Harga",
                    rupiahConverter.formatToRupiah(
                        int.parse(selectedPackage!.harga.toString())),
                    Colors.green,
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow(
                    Icons.access_time,
                    "Durasi",
                    selectedPackage!.durasiPerjalanan ?? "-",
                    Colors.orange,
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow(
                    Icons.flight_takeoff,
                    "Keberangkatan",
                    selectedPackage!.jadwalPerjalanan ?? "-",
                    Colors.purple,
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),)
                      ),
                        onPressed: () {
                          Get.to(DetailPage(
                            isOrder: true,
                            id: selectedPackage!.paketId.toString(),
                          ));
                        },
                        child: Text("Pesan Paket Umrah")),
                  ) // tambahan spacing bawah
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
