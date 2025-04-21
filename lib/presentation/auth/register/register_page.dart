import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/presentation/auth/register/set_password_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<String> genderItems = [
    'Laki-laki',
    'Perempuan',
  ];

  PlatformFile? ktpFile;
  PlatformFile? kkFile;
  PlatformFile? pasporFile;
  PlatformFile? vaksinFile;

  String? selectedGender;

  Future<void> _pickFile(String label) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      allowMultiple: false,
      dialogTitle: 'Pilih $label',
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      setState(() {
        if (label == 'Upload Foto KTP') {
          ktpFile = file;
          ktpFileName = file.name;
        } else if (label == 'Kartu Keluarga') {
          kkFile = file;
          kkFileName = file.name;
        } else if (label == 'Paspor') {
          pasporFile = file;
          pasporFileName = file.name;
        } else if (label == 'Sertifikat Vaksin') {
          vaksinFile = file;
          vaksinFileName = file.name;
        }
      });

      print('$label file selected: ${file.name} at ${file.path}');
    } else {
      print('$label file selection canceled.');
    }
  }

  String? ktpFileName;
  String? kkFileName;
  String? pasporFileName;
  String? vaksinFileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                  _buildTextField(label: 'Nama'),
                  _buildDropdown(label: 'Pilih Jenis Kelamin'),
                  _buildDatePicker(context),
                  _buildTextField(
                      label: 'No Telp', keyboardType: TextInputType.phone),
                  _buildTextField(
                      label: 'E-mail',
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 12),
                  _buildDropdown(label: 'Provinsi'),
                  _buildDropdown(label: 'Kabupaten/Kota'),
                  _buildDropdown(label: 'Kecamatan'),
                  _buildDropdown(label: 'Kelurahan'),
                  _buildTextField(
                      label: 'Alamat Lengkap (jalan, nomor, dan lainnya)'),
                  _buildTextField(
                      label: 'Nomor KTP', keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                  _buildUploadButton('Upload Foto KTP', ktpFileName,
                      () => _pickFile('Upload Foto KTP'), ktpFile),
                  _buildUploadButton('Kartu Keluarga', kkFileName,
                      () => _pickFile('Kartu Keluarga'), kkFile),
                  _buildUploadButton('Paspor', pasporFileName,
                      () => _pickFile('Paspor'), pasporFile),
                  _buildUploadButton('Sertifikat Vaksin', vaksinFileName,
                      () => _pickFile('Sertifikat Vaksin'), vaksinFile),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Kembali', style: TextStyle(fontSize: 16)),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(
                            () => const SetPasswordPage(),
                            transition: Transition.rightToLeft,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
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
          );
        },
      ),
    );
  }

  Widget _buildTextField({required String label, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildDropdown({required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        items: genderItems.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
              ),
            ),
          );
        }).toList(),
        value: selectedGender,
        onChanged: (value) {
          setState(() {
            selectedGender = value;
          });
        },
        selectedItemBuilder: (BuildContext context) {
          return genderItems.map<Widget>((String item) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            );
          }).toList();
        },
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        readOnly: true,
        onTap: () async {
          await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            initialDate: DateTime(2000),
          );
        },
        decoration: InputDecoration(
          labelText: 'Tanggal Lahir',
          suffixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildUploadButton(
      String label, String? fileName, VoidCallback onTap, PlatformFile? file) {
    IconData fileIcon =
        Icons.file_copy; 
    String fileExtension = fileName?.split('.').last.toLowerCase() ?? '';

    if (fileExtension == 'pdf') {
      fileIcon = Icons.picture_as_pdf;
    } else if (fileExtension == 'jpg' ||
        fileExtension == 'jpeg' ||
        fileExtension == 'png') {
      fileIcon = Icons.image;
    } else if (fileExtension == 'txt') {
      fileIcon = Icons.text_snippet;
    } else {
      fileIcon = Icons.file_copy;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey.shade100,
          ),
          child: Row(
            children: [
              Icon(fileIcon, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  fileName ?? label,
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
