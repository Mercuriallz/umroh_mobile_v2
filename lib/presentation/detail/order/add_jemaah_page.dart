import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';
import 'package:mobile_umroh_v2/constant/header_page.dart';

class AddJemaahPage extends StatefulWidget {
  const AddJemaahPage({super.key});

  @override
  State<AddJemaahPage> createState() => _AddJemaahPageState();
}

class _AddJemaahPageState extends State<AddJemaahPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nikController = TextEditingController();
  final passwordController = TextEditingController();

  int nikLength = 0;

  String? selectedGender;
  String? selectedTypeJemaah;
  String? selectedRelation;
  List<String> genderItems = ["Laki-laki", "Perempuan"];
  List<String> typeJemaah = ["Jemaah Baru", "Jemaah Pemesan"];
  List<String> relation = [
    "Suami",
    "Istri",
    "Anak",
    "Orang Tua",
    "Saudara",
    "Saudari",
    "Keluarga Lain"
  ];

  void _submit() {
    if (nameController.text.isNotEmpty && selectedGender != null) {
      Navigator.pop(context, {
        "nama": nameController.text,
        "jenis_kelamin": selectedGender!,
        // "type_jemaah": selectedTypeJemaah!,
        "email": emailController.text,
        "phone": phoneController.text,
        "nik": nikController.text,
        "password": passwordController.text,
        "hubungan_kerabat": selectedRelation!,
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                        onBack: () => Navigator.pop(context)),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20),
              //   child: DropdownButtonFormField<String>(
              //     items: typeJemaah.map((String item) {
              //       return DropdownMenuItem<String>(
              //         value: item,
              //         child: Text(item,
              //             style: const TextStyle(
              //               color: Colors.black,
              //               fontSize: 16,
              //             )),
              //       );
              //     }).toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         selectedTypeJemaah = value;
              //       });
              //     },
              //     decoration: InputDecoration(
              //       hintText: "Pilih Type Jemaah",
              //       contentPadding: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 16),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(30),
              //         borderSide: const BorderSide(color: Colors.grey),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(30),
              //         borderSide: const BorderSide(color: Colors.grey),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    hintText: "Nama Lengkap",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Nomor Telepon",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: nikController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(16),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    setState(() {}); // Untuk update counter secara realtime
                  },
                  decoration: InputDecoration(
                    counterText: "${nikController.text.length}/16",
                    counterStyle: TextStyle(
                      fontSize: 12,
                      color: nikController.text.length < 16
                          ? Colors.red
                          : Colors.green,
                    ),
                    hintText: "NIK",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: DropdownButtonFormField<String>(
                  items: genderItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Pilih Jenis Kelamin",
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
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: DropdownButtonFormField<String>(
                  items: relation.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRelation = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Pilih Hubungan",
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
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 32),
                  ),
                  child: const Text("Tambah",
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
