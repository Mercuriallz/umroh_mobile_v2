import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/constant/rupiah.dart';
import 'package:mobile_umroh_v2/model/package/package_model.dart';
import 'package:mobile_umroh_v2/presentation/detail/order/order_page.dart';

class DetailPage extends StatefulWidget {
  final DataPackage? package;

  const DetailPage({super.key, required this.package});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderDetailPaket(context),
              const SizedBox(
                height: 20,
              ),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildDescription(),
              const SizedBox(height: 16),
              _buildFlight(),
              const SizedBox(height: 16),
              _buildDestination(),
              const SizedBox(height: 25),
              _buildHotelFacility(),
              // const SizedBox(height: 24),
              // _buildMoneyCalculator(),
              const SizedBox(height: 50),
              _buildPrice(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderDetailPaket(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios,
                size: 20, color: Colors.black87),
          ),
          const SizedBox(width: 8),
          const Text(
            "Detail Paket",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            widget.package!.imgThumbnail ?? "",
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.package!.namaPaket ?? "-",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Row(
          children: [
            Icon(Icons.star, size: 18, color: Colors.amber),
            SizedBox(width: 4),
            Text("VIP", style: TextStyle(color: Colors.amber)),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            children: [
              if (widget.package!.arrFeature!.contains("Pesawat"))
                _buildIconText(Icons.flight, "Pesawat"),
              if (widget.package!.arrFeature!.contains("Antar"))
                _buildIconText(Icons.directions_car, "Antar"),
              if (widget.package!.arrFeature!.contains("Hotel"))
                _buildIconText(Icons.hotel, "Hotel"),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.share, color: Colors.blue),
            Icon(Icons.bookmark_border, color: Colors.blue),
          ],
        )
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Deskripsi Singkat",
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        Text(
          widget.package!.desc ?? "-",
          style: TextStyle(color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildFlight() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          const Icon(Icons.flight, color: Colors.black, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Penerbangan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 14),
                  children: [
                    TextSpan(
                      text: "Saudi Airlines",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: " - Bandara Soekarno Hatta",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDestination() {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Perjalanan", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        Text(widget.package!.jadwalPerjalanan ?? "-"),
        Text("Normal: 3 - 4 Jam (Tergantung situasi dan kondisi)",
            style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildHotelFacility() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Fasilitas Hotel",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hotel Hilton Makkah",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4),
                      Text(
                        "5",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _fasilitasItem(Icons.restaurant, "Konsumsi"),
                      _fasilitasItem(Icons.wifi, "Wi-Fi"),
                      _fasilitasItem(Icons.tv, "Hiburan"),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _fasilitasItem(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue[700], size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

//  Widget _buildMoneyCalculator() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         'Kalkulator Keuangan',
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//       ),
//       const SizedBox(height: 8),
//       const Text(
//         'Sebelum pesan, apakah Anda ingin mengecek keuangan Anda dengan kalkulator?',
//         style: TextStyle(fontSize: 12),
//       ),
//       const SizedBox(height: 16),
//       ElevatedButton(
//         onPressed: () {
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF75B6FF),
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25),
//           ),
//         ),
//         child: const Text(
//           'Kalkulator Keuangan',
//           style: TextStyle(color: Colors.white, fontSize: 16),
//         ),
//       ),
//     ],
//   );
// }

  Widget _buildPrice() {
    final rupiahConverter = RupiahConverter();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mulai dari',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              widget.package!.harga != null
                  ? rupiahConverter.formatToRupiah(
                      int.parse(widget.package!.harga.toString()))
                  : 'Rp. 0',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF75B6FF),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '12 bulan',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            Get.to(
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 500),
              () => OrderPage(
                package: widget.package,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF75B6FF),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Pesan Sekarang',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}


  Widget _buildIconText(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
