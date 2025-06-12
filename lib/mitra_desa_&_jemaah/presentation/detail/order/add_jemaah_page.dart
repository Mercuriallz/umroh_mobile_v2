import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';

class AddJemaahPage extends StatefulWidget {
  const AddJemaahPage({super.key});

  @override
  State<AddJemaahPage> createState() => _AddJemaahPageState();
}

class _AddJemaahPageState extends State<AddJemaahPage>
    with SingleTickerProviderStateMixin {
  File? ktpFile;
  File? kkFile;
  File? pasporFile;
  File? vaksinFile;
  File? bpjsFile;
  File? passPhotoFile;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nikController = TextEditingController();
  final passwordController = TextEditingController();

  String? ktpFileError;
  String? kkFileError;
  String? pasporFileError;
  String? vaksinFileError;
  String? bpjsFileError;
  String? passPhotoError;

  Future<void> _showImageSourceDialog(String label) async {
    final picker = ImagePicker();

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Ambil dari Kamera'),
                  onTap: () async {
                    final XFile? photo =
                        await picker.pickImage(source: ImageSource.camera);

                    if (!context.mounted) {
                      return;
                    }
                    Navigator.pop(context);

                    if (photo != null) {
                      _handlePickedFile(File(photo.path), label);
                    }
                  }),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari Galeri'),
                onTap: () async {
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (!context.mounted) {
                    return;
                  }
                  Navigator.pop(context);
                  if (image != null) {
                    _handlePickedFile(File(image.path), label);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: const Text('Pilih File (PDF, dll)'),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
                  );
                  if (result != null && result.files.isNotEmpty) {
                    final file = File(result.files.first.path!);
                    _handlePickedFile(file, label);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handlePickedFile(File file, String label) {
    setState(() {
      switch (label) {
        case 'Upload Foto KTP':
          ktpFile = file;
          ktpFileError = null;
          break;
        case 'Kartu Keluarga':
          kkFile = file;
          kkFileError = null;
          break;
        case 'Paspor':
          pasporFile = file;
          pasporFileError = null;
          break;
        case 'Sertifikat Vaksin':
          vaksinFile = file;
          vaksinFileError = null;
          break;
        case 'Bpjs':
          bpjsFile = file;
          bpjsFileError = null;
          break;
        case 'Pass Foto':
          passPhotoFile = file;
          passPhotoError = null;
          break;
      }
    });
  }

  String? _getFileName(File? file) {
    if (file == null) return null;
    return file.path.split('/').last;
  }

  String? selectedGender;
  String? selectedRelation;
  List<String> genderItems = ["Laki-laki", "Perempuan"];
  List<String> relation = [
    "Suami",
    "Istri",
    "Anak",
    "Orang Tua",
    "Saudara",
    "Saudari",
    "Keluarga Lain"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nikController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (nameController.text.isNotEmpty && selectedGender != null) {
      Navigator.pop(context, {
        "nama": nameController.text,
        "jenis_kelamin": selectedGender!,
        "email": emailController.text,
        "phone": phoneController.text,
        "nik": nikController.text,
        "password": passwordController.text,
        "hubungan_kerabat": selectedRelation!,
        "img_ktp": ktpFile,
        "img_passport": pasporFile,
        "img_kk": kkFile,
        "img_vaksin": vaksinFile,
        "img_pas_foto": passPhotoFile,
        "img_bpjs_kesehatan": bpjsFile
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama, '),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildUploadButton(
    String label,
    File? file,
    VoidCallback onTap,
    String? errorText,
  ) {
    String? fileName = _getFileName(file);
    String extension = fileName?.split('.').last.toLowerCase() ?? '';
    IconData icon;

    if (extension == 'pdf') {
      icon = Icons.picture_as_pdf;
    } else if (extension == 'jpg' ||
        extension == 'jpeg' ||
        extension == 'png') {
      icon = Icons.image;
    } else {
      icon = Icons.insert_drive_file;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(
                  color: errorText != null ? Colors.red : Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey.shade100,
              ),
              child: Row(
                children: [
                  Icon(icon, color: errorText != null ? Colors.red : null),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      fileName ?? label,
                      style: TextStyle(
                        fontSize: 16,
                        color: errorText != null ? Colors.red : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text(
                errorText,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFormTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: nameController,
              decoration: _inputDecoration("Nama Lengkap"),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: emailController,
              decoration: _inputDecoration("Email"),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: _inputDecoration("Nomor Telepon"),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: nikController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (_) => setState(() {}),
              decoration: _inputDecoration("NIK").copyWith(
                counterText: "${nikController.text.length}/16",
                counterStyle: TextStyle(
                  fontSize: 12,
                  color: nikController.text.length < 16
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: passwordController,
              decoration: _inputDecoration("Password"),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownButtonFormField2<String>(
              decoration: _dropdownDecoration(),
              isExpanded: true,
              hint: _dropdownHint("Pilih Jenis Kelamin", Icons.person_outline),
              value: selectedGender,
              items: genderItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Row(
                          children: [
                            Icon(
                              item == "Laki-laki" ? Icons.male : Icons.female,
                              color: item == "Laki-laki"
                                  ? Colors.blue
                                  : Colors.pink,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              item,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (value) => setState(() {
                selectedGender = value;
              }),
              buttonStyleData: const ButtonStyleData(height: 56),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
              ),
              iconStyleData: IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownButtonFormField<String>(
              decoration: _inputDecoration("Pilih Hubungan"),
              value: selectedRelation,
              items: relation
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: const TextStyle(fontSize: 14)),
                      ))
                  .toList(),
              onChanged: (value) => setState(() {
                selectedRelation = value;
              }),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child:
                    const Text("Tambah", style: TextStyle(color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDocumentTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildUploadButton(
            'Upload Foto KTP',
            ktpFile,
            () => _showImageSourceDialog('Upload Foto KTP'),
            ktpFileError,
          ),
          _buildUploadButton(
            'Kartu Keluarga',
            kkFile,
            () => _showImageSourceDialog('Kartu Keluarga'),
            kkFileError,
          ),
          _buildUploadButton(
            'Paspor',
            pasporFile,
            () => _showImageSourceDialog('Paspor'),
            pasporFileError,
          ),
          _buildUploadButton(
            'Sertifikat Vaksin',
            vaksinFile,
            () => _showImageSourceDialog('Sertifikat Vaksin'),
            vaksinFileError,
          ),
          _buildUploadButton(
            'Bpjs',
            bpjsFile,
            () => _showImageSourceDialog('Bpjs'),
            bpjsFileError,
          ),
          _buildUploadButton(
            'Pass Foto',
            passPhotoFile,
            () => _showImageSourceDialog('Pass Foto'),
            passPhotoError,
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.purple[600]!, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }

  Widget _dropdownHint(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: ColorConstant.primaryBlue, size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    CustomBackHeader(
                      title: "Tambah Jamaah",
                      onBack: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ColorConstant.primaryBlue,
                  ),
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: "Detail Paket"),
                    Tab(text: "Tambah Dokumen"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildFormTab(),
                    _buildDocumentTab(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
