import 'package:flutter/material.dart';

class AddJemaahPage extends StatefulWidget {
  const AddJemaahPage({super.key});

  @override
  State<AddJemaahPage> createState() => _AddJemaahPageState();
}

class _AddJemaahPageState extends State<AddJemaahPage> {
  final TextEditingController nameController = TextEditingController();
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
      appBar: AppBar(title: const Text("Jema’ah")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
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
                )
                ,
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
              decoration:  InputDecoration(
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
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
              ),
              child:
                  const Text("Tambah", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
