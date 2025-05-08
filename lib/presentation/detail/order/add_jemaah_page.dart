import 'package:flutter/material.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';

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
  

  String? selectedGender;
  String? selectedTypeJemaah;
  List<String> genderItems = ["Laki-laki", "Perempuan"];
  List<String> typeJemaah = ["Jemaah Baru", "Jemaah Pemesan"];

  void _submit() {
    if (nameController.text.isNotEmpty && selectedGender != null) {
      Navigator.pop(context, {
        "nama": nameController.text,
        "jenis_kelamin": selectedGender!,
        "type_jemaah": selectedTypeJemaah!
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.arrow_back),
                SizedBox(width: 8),
                Text("Jema'ah",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              items: typeJemaah.map((String item) {
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
                  selectedTypeJemaah = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Pilih Type Jemaah",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Nama Lengkap",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                ),
                child:
                    const Text("Tambah", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
