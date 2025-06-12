import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as flutter_bloc;
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
import 'package:mobile_umroh_v2/bloc/region/kabupaten/kabupaten_bloc.dart';
import 'package:mobile_umroh_v2/bloc/region/kabupaten/kabupaten_state.dart';
import 'package:mobile_umroh_v2/bloc/region/kecamatan/kecamatan_bloc.dart';
import 'package:mobile_umroh_v2/bloc/region/kecamatan/kecamatan_state.dart';
import 'package:mobile_umroh_v2/bloc/region/kelurahan/kelurahan_bloc.dart';
import 'package:mobile_umroh_v2/bloc/region/kelurahan/kelurahan_state.dart';
import 'package:mobile_umroh_v2/bloc/region/provinsi/provinsi_bloc.dart';
import 'package:mobile_umroh_v2/bloc/region/provinsi/provinsi_state.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';

import 'package:mobile_umroh_v2/presentation/auth/register/set_password_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<String> genderItems = ['Laki-laki', 'Perempuan'];

  File? ktpFile;
  File? kkFile;
  File? pasporFile;
  File? vaksinFile;
  File? bpjsFile;
  File? passPhotoFile;

  String? selectedProvince;
  String? selectedRegency;
  String? selectedDistrict;
  String? selectedSubDistrict;

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final ktpController = TextEditingController();
  final birthdayController = TextEditingController();
  final usernameController = TextEditingController();
  final nikController = TextEditingController();
  final jabatanController = TextEditingController();

  String? selectedGender;

  final _formKey = GlobalKey<FormBuilderState>();

  // Error messages for file uploads
  String? ktpFileError;
  String? kkFileError;
  String? pasporFileError;
  String? vaksinFileError;
  String? bpjsFileError;
  String? passPhotoError;

  bool validateForm() {
    bool isValid = true;

    // setState(() {
    //   ktpFileError = null;
    //   kkFileError = null;
    //   pasporFileError = null;
    //   vaksinFileError = null;
    //   bpjsFileError = null;
    //   passPhotoError = null;
    // });

    if (_formKey.currentState?.saveAndValidate() != true) {
      isValid = false;
    }

    // if (ktpFile == null) {
    //   setState(() {
    //     ktpFileError = 'Foto KTP wajib diupload';
    //   });
    //   isValid = false;
    // }

    // if (bpjsFile == null) {
    //   setState(() {
    //     bpjsFileError = 'Bpjs wajib di upload';
    //   });
    //   isValid = false;
    // }

    // if (passPhotoFile == null) {
    //   setState(() {
    //     passPhotoError = 'Pass Foto Wajib di Upload';
    //   });
    //   isValid = false;
    // }

    // if (kkFile == null) {
    //   setState(() {
    //     kkFileError = 'Kartu Keluarga wajib diupload';
    //   });
    //   isValid = false;
    // }

    // if (pasporFile == null) {
    //   setState(() {
    //     pasporFileError = 'Paspor wajib diupload';
    //   });
    //   isValid = false;
    // }

    // if (vaksinFile == null) {
    //   setState(() {
    //     vaksinFileError = 'Sertifikat Vaksin wajib diupload';
    //   });
    //   isValid = false;
    // }

    // if (selectedGender == null) {
    //   isValid = false;
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Jenis Kelamin wajib dipilih')),
    //   );
    // }

    if (selectedProvince == null) {
      isValid = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Provinsi wajib dipilih')),
      );
    }

    if (selectedRegency == null) {
      isValid = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kabupaten wajib dipilih')),
      );
    }

    if (selectedDistrict == null) {
      isValid = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kecamatan wajib dipilih')),
      );
    }

    if (selectedSubDistrict == null) {
      isValid = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kelurahan wajib dipilih')),
      );
    }

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Mohon lengkapi semua data yang diperlukan')),
      );
    }

    return isValid;
  }

  // Future<void> _showImageSourceDialog(String label) async {
  //   final picker = ImagePicker();

  //   await showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (context) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: [
  //             ListTile(
  //                 leading: const Icon(Icons.camera_alt),
  //                 title: const Text('Ambil dari Kamera'),
  //                 onTap: () async {
  //                   final XFile? photo =
  //                       await picker.pickImage(source: ImageSource.camera);

  //                   if (!context.mounted) {
  //                     return;
  //                   }
  //                   Navigator.pop(context);

  //                   if (photo != null) {
  //                     _handlePickedFile(File(photo.path), label);
  //                   }
  //                 }),
  //             ListTile(
  //               leading: const Icon(Icons.photo_library),
  //               title: const Text('Pilih dari Galeri'),
  //               onTap: () async {
  //                 final XFile? image =
  //                     await picker.pickImage(source: ImageSource.gallery);
  //                 if(!context.mounted) {
  //                   return;
  //                 }
  //                 Navigator.pop(context);
  //                 if (image != null) {
  //                   _handlePickedFile(File(image.path), label);
  //                 }
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.upload_file),
  //               title: const Text('Pilih File (PDF, dll)'),
  //               onTap: () async {
  //                 Navigator.pop(context);
  //                 final result = await FilePicker.platform.pickFiles(
  //                   type: FileType.custom,
  //                   allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
  //                 );
  //                 if (result != null && result.files.isNotEmpty) {
  //                   final file = File(result.files.first.path!);
  //                   _handlePickedFile(file, label);
  //                 }
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _handlePickedFile(File file, String label) {
  //   setState(() {
  //     switch (label) {
  //       case 'Upload Foto KTP':
  //         ktpFile = file;
  //         ktpFileError = null;
  //         break;
  //       case 'Kartu Keluarga':
  //         kkFile = file;
  //         kkFileError = null;
  //         break;
  //       case 'Paspor':
  //         pasporFile = file;
  //         pasporFileError = null;
  //         break;
  //       case 'Sertifikat Vaksin':
  //         vaksinFile = file;
  //         vaksinFileError = null;
  //         break;
  //       case 'Bpjs':
  //         bpjsFile = file;
  //         bpjsFileError = null;
  //         break;
  //       case 'Pass Foto':
  //         passPhotoFile = file;
  //         passPhotoError = null;
  //         break;
  //     }
  //   });
  // }

  // String? _getFileName(File? file) {
  //   if (file == null) return null;
  //   return file.path.split('/').last;
  // }

  @override
  void initState() {
    super.initState();
    context.read<ProvinsiBloc>().getProvinsi();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    usernameController.dispose();

    addressController.dispose();
    ktpController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Get.back(),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Registrasi',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Mohon masukan nama, alamat, nomor telepon, dan atau e-mail Anda yang masih aktif.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  name: 'name',
                  label: 'Nama',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama wajib diisi';
                    }
                    return null;
                  },
                ),
                // _buildDropdown(label: 'Pilih Jenis Kelamin'),
                // _buildDatePicker(context),
                // _buildTextField(
                //   name: 'phone',
                //   label: 'No Telp',
                //   keyboardType: TextInputType.phone,
                //   controller: phoneNumberController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'No Telp wajib diisi';
                //     }
                //     return null;
                //   },
                // ),
                _buildTextField(
                  name: 'username',
                  label: 'Username',

                  controller: usernameController,

                ),

                _buildTextField(
                  keyboardType: TextInputType.number,
                  name: 'No. Telephone',
                  label: 'No. Telephone',
                  controller: phoneNumberController,
                ),

                _buildTextField(
                  keyboardType: TextInputType.number,
                  name: 'NIK',
                  label: 'NIK',
                  controller: nikController,
                ),

                _buildTextField(
                  name: 'Jabatan',
                  label: 'Jabatan',
                  controller: jabatanController,
                ),

                const SizedBox(
                  height: 12,
                ),

                flutter_bloc.BlocBuilder<ProvinsiBloc, ProvinsiState>(
                  builder: (context, state) {
                    if (state is ProvinsiLoaded) {
                      return FormBuilderDropdown(
                        name: 'provinsiDropdown',
                        decoration: _dropdownDecoration(
                            errorText: selectedProvince == null ? null : null),
                        hint: const Text('Pilih Provinsi'),
                        validator: (value) {
                          if (value == null) {
                            return 'Provinsi wajib dipilih';
                          }
                          return null;
                        },
                        items: state.provinsi.map((provinsi) {
                          return DropdownMenuItem(
                            value: provinsi.provinsiId.toString(),
                            child: Text(provinsi.name.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedProvince = value.toString();
                            selectedRegency = null;
                            selectedDistrict = null;
                            selectedSubDistrict = null;
                          });
                          context
                              .read<KabupatenBloc>()
                              .getKabupaten(selectedProvince!);
                        },
                      );
                    } else if (state is ProvinsiLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return FormBuilderDropdown(
                        name: 'ProvinsiDropdown',
                        items: [],
                        decoration: _dropdownDecoration(),
                      );
                    }
                  },
                ),

                const SizedBox(height: 20),

                // Dropdown Kabupaten

                flutter_bloc.BlocBuilder<KabupatenBloc, KabupatenState>(
                  builder: (context, state) {
                    if (state is KabupatenLoaded) {
                      return FormBuilderDropdown(
                        name: 'kabupatenDropdown',
                        decoration: _dropdownDecoration(),
                        hint: const Text('Pilih Kabupaten / Kota'),
                        validator: (value) {
                          if (value == null) {
                            return 'Kabupaten wajib dipilih';
                          }
                          return null;
                        },
                        items: state.kabupaten.map((kabupaten) {
                          return DropdownMenuItem(
                            value: kabupaten.kabupatenId.toString(),
                            child: Text(kabupaten.name.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRegency = value.toString();
                            selectedDistrict = null;
                            selectedSubDistrict = null;
                          });
                          context
                              .read<KecamatanBloc>()
                              .getKecamatan(selectedRegency!);
                        },
                      );
                    } else if (state is KabupatenLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return FormBuilderDropdown(
                        name: 'KabupatenDropdown',
                        items: [],
                        decoration: _dropdownDecoration(),
                        hint: const Text("Pilih Kabupaten / Kota"),
                      );
                    }
                  },
                ),

                const SizedBox(height: 20),

                flutter_bloc.BlocBuilder<KecamatanBloc, KecamatanState>(
                  builder: (context, state) {
                    if (state is KecamatanLoaded) {
                      return FormBuilderDropdown(
                        name: 'kecamatanDropdown',
                        decoration: _dropdownDecoration(),
                        hint: const Text('Pilih Kecamatan'),
                        validator: (value) {
                          if (value == null) {
                            return 'Kecamatan wajib dipilih';
                          }
                          return null;
                        },
                        items: state.kecamatan.map((kecamatan) {
                          return DropdownMenuItem(
                            value: kecamatan.kecamatanId.toString(),
                            child: Text(kecamatan.name.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistrict = value.toString();
                            selectedSubDistrict = null;
                          });
                          context
                              .read<KelurahanBloc>()
                              .getKelurahan(selectedDistrict!);
                        },
                      );
                    } else if (state is KecamatanLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return FormBuilderDropdown(
                        name: 'KecamatanDropdown',
                        items: [],
                        decoration: _dropdownDecoration(),
                        hint: const Text("Pilih Kecamatan"),
                      );
                    }
                  },
                ),

                const SizedBox(height: 20),

                // Dropdown Kelurahan

                flutter_bloc.BlocBuilder<KelurahanBloc, KelurahanState>(
                  builder: (context, state) {
                    if (state is KelurahanLoaded) {
                      return FormBuilderDropdown(
                        name: 'kelurahanDropdown',
                        decoration: _dropdownDecoration(),
                        hint: const Text('Pilih Kelurahan / Desa'),
                        validator: (value) {
                          if (value == null) {
                            return 'Kelurahan wajib dipilih';
                          }
                          return null;
                        },
                        items: state.kelurahan.map((kelurahan) {
                          return DropdownMenuItem(
                            value: kelurahan.kelurahanId.toString(),
                            child: Text(kelurahan.name.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSubDistrict = value.toString();
                          });
                        },
                      );
                    } else if (state is KelurahanLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return FormBuilderDropdown(
                        name: 'KelurahanDropdown',
                        items: [],
                        decoration: _dropdownDecoration(),
                        hint: const Text("Pilih Desa "),
                      );
                    }
                  },
                ),

                const SizedBox(height: 20),

                // _buildTextField(
                //   name: 'address',
                //   label: 'Alamat Lengkap (jalan, nomor, dan lainnya)',
                //   controller: addressController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Alamat wajib diisi';
                //     }
                //     return null;
                //   },
                // ),
                // _buildTextField(
                //   name: 'ktp',
                //   label: 'Nomor KTP',
                //   keyboardType: TextInputType.number,
                //   controller: ktpController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Nomor KTP wajib diisi';
                //     }
                //     if (value.length != 16) {
                //       return 'Nomor KTP harus 16 digit';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 16),
                // _buildUploadButton(
                //   'Upload Foto KTP',
                //   ktpFile,
                //   () => _showImageSourceDialog('Upload Foto KTP'),
                //   ktpFileError,
                // ),
                // _buildUploadButton(
                //   'Kartu Keluarga',
                //   kkFile,
                //   () => _showImageSourceDialog('Kartu Keluarga'),
                //   kkFileError,
                // ),
                // _buildUploadButton(
                //   'Paspor',
                //   pasporFile,
                //   () => _showImageSourceDialog('Paspor'),
                //   pasporFileError,
                // ),
                // _buildUploadButton(
                //   'Sertifikat Vaksin',
                //   vaksinFile,
                //   () => _showImageSourceDialog('Sertifikat Vaksin'),
                //   vaksinFileError,
                // ),
                // _buildUploadButton(
                //   'Bpjs',
                //   bpjsFile,
                //   () => _showImageSourceDialog('Bpjs'),
                //   bpjsFileError,
                // ),
                // _buildUploadButton(
                //   'Pass Foto',
                //   passPhotoFile,
                //   () => _showImageSourceDialog('Pass Foto'),
                //   passPhotoError,
                // ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child:
                          const Text('Kembali', style: TextStyle(fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (validateForm()) {
                          Get.to(
                              () => SetPasswordPage(
                                    name: nameController.text,
                                    username: usernameController.text,
                                    // address: addressController.text,
                                    // email: emailController.text,
                                    // kkFile: kkFile,
                                    // ktpFile: ktpFile,
                                    // ktp: ktpController.text,
                                    // pasporFile: pasporFile,
                                    // vaksinFile: vaksinFile,
                                    // phoneNumber: phoneNumberController.text,
                                    // selectedDate: birthdayController.text,
                                    // selectedGender: selectedGender,
                                    selectedProvinsi: selectedProvince,
                                    selectedKabupaten: selectedRegency,
                                    selectedKecamatan: selectedDistrict,
                                    selectedKelurahan: selectedSubDistrict,
                                    // bpjsFile: bpjsFile,
                                    // passPhotoFile: passPhotoFile,
                                  ),
                              transition: Transition.rightToLeft);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                      ),
                      child: const Text('Lanjutkan',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String name,
    required String label,
    TextInputType? keyboardType,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FormBuilderTextField(
        name: name,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  // Widget _buildDropdown({required String label}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: DropdownButtonFormField<String>(
  //       decoration: InputDecoration(
  //         hintText: "Pilih Jenis Kelamin",
  //         contentPadding:
  //             const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(30),
  //           borderSide: const BorderSide(color: Colors.grey),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(30),
  //           borderSide: const BorderSide(color: Colors.grey),
  //         ),
  //       ),
  //       items: genderItems.map((String item) {
  //         return DropdownMenuItem<String>(
  //           value: item,
  //           child: Text(item),
  //         );
  //       }).toList(),
  //       value: selectedGender,
  //       onChanged: (value) {
  //         setState(() {
  //           selectedGender = value;
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _buildDatePicker(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: FormBuilderTextField(
  //       name: 'birthday',
  //       controller: birthdayController,
  //       readOnly: true,
  //       validator: (value) {
  //         if (value == null || value.isEmpty) {
  //           return 'Tanggal Lahir wajib diisi';
  //         }
  //         return null;
  //       },
  //       onTap: () async {
  //         DateTime? pickedDate = await showDatePicker(
  //           context: context,
  //           firstDate: DateTime(1900),
  //           lastDate: DateTime.now(),
  //           initialDate: DateTime(2000),
  //         );

  //         if (pickedDate != null) {
  //           String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
  //           setState(() {
  //             birthdayController.text = formattedDate;
  //           });
  //         }
  //       },
  //       decoration: InputDecoration(
  //         labelText: 'Tanggal Lahir',
  //         suffixIcon: const Icon(Icons.calendar_today),
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
  //         contentPadding:
  //             const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  //       ),
  //     ),
  //   );
  // }

//   Widget _buildUploadButton(
//     String label,
//     File? file,
//     VoidCallback onTap,
//     String? errorText,
//   ) {
//     String? fileName = _getFileName(file);
//     String extension = fileName?.split('.').last.toLowerCase() ?? '';
//     IconData icon;

//     if (extension == 'pdf') {
//       icon = Icons.picture_as_pdf;
//     } else if (extension == 'jpg' ||
//         extension == 'jpeg' ||
//         extension == 'png') {
//       icon = Icons.image;
//     } else {
//       icon = Icons.insert_drive_file;
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: onTap,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               height: 56,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: errorText != null ? Colors.red : Colors.grey.shade400,
//                 ),
//                 borderRadius: BorderRadius.circular(25),
//                 color: Colors.grey.shade100,
//               ),
//               child: Row(
//                 children: [
//                   Icon(icon, color: errorText != null ? Colors.red : null),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       fileName ?? label,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: errorText != null ? Colors.red : null,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (errorText != null)
//             Padding(
//               padding: const EdgeInsets.only(left: 16, top: 4),
//               child: Text(
//                 errorText,
//                 style: const TextStyle(color: Colors.red, fontSize: 12),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

  InputDecoration _dropdownDecoration({String? errorText}) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      errorText: errorText,
    );
  }
}
