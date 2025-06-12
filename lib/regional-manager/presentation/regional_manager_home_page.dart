import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/mitra_desa_&_jemaah/presentation/auth/login_page.dart';
import 'package:mobile_umroh_v2/regional-manager/bloc/list_regional_manager_bloc.dart';
import 'package:mobile_umroh_v2/regional-manager/bloc/list_regional_manager_state.dart';
import 'package:mobile_umroh_v2/regional-manager/model/list_regional_manager_model.dart';
import 'package:mobile_umroh_v2/services/storage.dart';

class RegionalManagerHomePage extends StatefulWidget {
  const RegionalManagerHomePage({super.key});

  @override
  State<RegionalManagerHomePage> createState() =>
      _RegionalManagerDropdownPageState();
}

class _RegionalManagerDropdownPageState extends State<RegionalManagerHomePage> {
  DataListRegionalManager? selectedRegionalManager;

  @override
  void initState() {
    super.initState();
    context.read<ListRegionalManagerBloc>().getListRegionalManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regional Manager'),
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
              Colors.blue.shade50,
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
                      'Pilih Regional Manager',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<ListRegionalManagerBloc,
                        ListRegionalManagerState>(
                      builder: (context, state) {
                        if (state is ListRegionalManagerLoading) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is ListRegionalManagerError) {
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
                        } else if (state is ListRegionalManagerLoaded) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<DataListRegionalManager>(
                                isExpanded: true,
                                value: selectedRegionalManager,
                                hint: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'Pilih Regional Manager...',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                onChanged: (DataListRegionalManager? newValue) {
                                  setState(() {
                                    selectedRegionalManager = newValue;
                                  });
                                },
                                items: state.listRegionalManager.map<
                                    DropdownMenuItem<DataListRegionalManager>>(
                                  (DataListRegionalManager regionalManager) {
                                    return DropdownMenuItem<
                                        DataListRegionalManager>(
                                      value: regionalManager,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(
                                          regionalManager.nama ??
                                              'Nama tidak tersedia',
                                          style: const TextStyle(fontSize: 14),
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
              if (selectedRegionalManager != null)
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
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.blue.shade600,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Detail Regional Manager',
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
                                _buildDetailRow('Nama',
                                    selectedRegionalManager!.nama ?? '-'),
                                _buildDetailRow('Username',
                                    selectedRegionalManager!.username ?? '-'),
                                _buildDetailRow(
                                    'ID Provinsi',
                                    selectedRegionalManager!.idProvinsi
                                            ?.toString() ??
                                        '-'),
                                _buildDetailRow(
                                    'Provinsi',
                                    selectedRegionalManager!.wProvinsi?.name ??
                                        '-'),

                                // Card khusus untuk info provinsi jika ada
                                if (selectedRegionalManager!.wProvinsi != null)
                                  Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.blue.shade200),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.blue.shade600,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Informasi Wilayah',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue.shade800,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Regional Manager untuk wilayah ${selectedRegionalManager!.wProvinsi!.name}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blue.shade700,
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
              if (selectedRegionalManager == null)
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
                            Icons.info_outline,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Pilih Regional Manager dari dropdown\nuntuk melihat detail',
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
                      child: const Text('Log Out',
                          style: TextStyle(color: Colors.red)),
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
