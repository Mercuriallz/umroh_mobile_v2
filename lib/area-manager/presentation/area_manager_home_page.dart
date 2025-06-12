import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/area-manager/bloc/list_area_manager_bloc.dart';
import 'package:mobile_umroh_v2/area-manager/bloc/list_area_manager_state.dart';
import 'package:mobile_umroh_v2/area-manager/model/list_area_manager_model.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/auth/login_page.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class AreaManagerHomePage extends StatefulWidget {
  const AreaManagerHomePage({super.key});

  @override
  State<AreaManagerHomePage> createState() => _AreaManagerHomePageState();
}

class _AreaManagerHomePageState extends State<AreaManagerHomePage> {
  DataListAreaManager? selectedAreaManager;

  @override
  void initState() {
    super.initState();
    // Load data saat pertama kali membuka halaman
    context.read<ListAreaManagerBloc>().getListAreaManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Area Manager'),
        backgroundColor: ColorConstant.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorConstant.primaryBlue,
              Colors.green.shade50,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pilih Area Manager',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<ListAreaManagerBloc, ListAreaManagerState>(
                      builder: (context, state) {
                        if (state is ListAreaManagerLoading) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is ListAreaManagerError) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.error_outline,
                                    color: Colors.red.shade600),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    state.message,
                                    style:
                                        TextStyle(color: Colors.red.shade600),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is ListAreaManagerLoaded) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<DataListAreaManager>(
                                isExpanded: true,
                                value: selectedAreaManager,
                                hint: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'Pilih Area Manager...',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                onChanged: (DataListAreaManager? newValue) {
                                  setState(() {
                                    selectedAreaManager = newValue;
                                  });
                                },
                                items: state.dataListAreaManager
                                    .map<DropdownMenuItem<DataListAreaManager>>(
                                  (DataListAreaManager areaManager) {
                                    return DropdownMenuItem<
                                        DataListAreaManager>(
                                      value: areaManager,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              areaManager.nama ??
                                                  'Nama tidak tersedia',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            if (areaManager.wProvinsi?.name !=
                                                    null ||
                                                areaManager.wKabupaten?.name !=
                                                    null)
                                              Text(
                                                '${areaManager.wKabupaten?.name ?? ''}, ${areaManager.wProvinsi?.name ?? ''}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Detail Section
              if (selectedAreaManager != null)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.business_center,
                                color: ColorConstant.primaryBlue,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Detail Area Manager',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildDetailRow(
                                    'Nama', selectedAreaManager!.nama ?? '-'),
                                _buildDetailRow('Username',
                                    selectedAreaManager!.username ?? '-'),
                                _buildDetailRow(
                                    'ID Provinsi',
                                    selectedAreaManager!.idProvinsi
                                            ?.toString() ??
                                        '-'),
                                _buildDetailRow(
                                    'ID Kabupaten',
                                    selectedAreaManager!.idKabupaten
                                            ?.toString() ??
                                        '-'),
                                _buildDetailRow(
                                    'Provinsi',
                                    selectedAreaManager!.wProvinsi?.name ??
                                        '-'),
                                _buildDetailRow(
                                    'Kabupaten',
                                    selectedAreaManager!.wKabupaten?.name ??
                                        '-'),

                                // Card khusus untuk info lokasi jika ada
                                if (selectedAreaManager!.wProvinsi != null ||
                                    selectedAreaManager!.wKabupaten != null)
                                  Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color:  ColorConstant.primaryBlue,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: ColorConstant.primaryBlue),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.map_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Area Kerja',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        if (selectedAreaManager!
                                                    .wKabupaten?.name !=
                                                null &&
                                            selectedAreaManager!
                                                    .wProvinsi?.name !=
                                                null)
                                          Text(
                                            'Area Manager untuk wilayah ${selectedAreaManager!.wKabupaten!.name}, ${selectedAreaManager!.wProvinsi!.name}',
                                            style: TextStyle(
                                              fontSize: 13,
                                               color: Colors.white,
                                            ),
                                          )
                                        else if (selectedAreaManager!
                                                .wProvinsi?.name !=
                                            null)
                                          Text(
                                            'Area Manager untuk wilayah ${selectedAreaManager!.wProvinsi!.name}',
                                            style: TextStyle(
                                              fontSize: 13,
                                               color: Colors.white,
                                            ),
                                          ),

                                        // Tambahan info geografis
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: ColorConstant.primaryBlue,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                 color: Colors.white,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Cakupan Area: ${selectedAreaManager!.wKabupaten?.name ?? selectedAreaManager!.wProvinsi?.name ?? 'Tidak diketahui'}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                   color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Empty state when no selection
              if (selectedAreaManager == null)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.business_center_outlined,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Pilih Area Manager dari dropdown\nuntuk melihat detail',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  final secureStorage = SecureStorageService();
                  secureStorage.deleteAll();
                  Get.offAll(const LoginPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child:
                    const Text('Log Out', style: TextStyle(color: Colors.red)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
