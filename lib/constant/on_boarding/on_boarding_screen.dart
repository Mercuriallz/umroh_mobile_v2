import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh_v2/presentation/auth/login_page.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnboardingSliderState();
}

class _OnboardingSliderState extends State<OnBoardingScreen> {
  int _current = 0;
final CarouselSliderController _controller = CarouselSliderController();

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Umrah Desa?",
      "description":
          "Program pemberangkatan umrah khusus bagi masyarakat desa dengan sistem tabungan atau cicilan ringan. Bertujuan untuk memperluas akses ibadah umrah ke seluruh lapisan masyarakat",
      "image": "assets/umrah.png",
    },
    {
      "title": "Kemudahan Pembayaran",
      "description":
          "Lorem ipsum dolor sit amet consectetur. Tincidunt ut amet vitae nunc suspendisse tempor cras. Suscipit vitae diam id diam platea urna eu.",
      "image": "assets/payment.png",
    },
    {
      "title": "Pendampingan Langsung",
      "description":
          "Lorem ipsum dolor sit amet consectetur. Tincidunt ut amet vitae nunc suspendisse tempor cras. Suscipit vitae diam id diam platea urna eu.",
      "image": "assets/pendampingan.png",
    },
    {
      "title": "Jadwal Flexibel",
      "description":
          "Lorem ipsum dolor sit amet consectetur. Tincidunt ut amet vitae nunc suspendisse tempor cras. Suscipit vitae diam id diam platea urna eu.",
      "image": "assets/schedule.png",
    },
  ];


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider.builder(
                carouselController: _controller,
                itemCount: onboardingData.length,
                itemBuilder: (context, index, realIndex) {
                  final data = onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height * 0.3,
                          width: size.width * 0.7,
                          color: Colors.grey[300], // Placeholder
                          child: Center(
                            child: Text(
                              "Image",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          // Uncomment this if you have image:
                          // child: Image.asset(data['image']!, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          data['title']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          data['description']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: size.height * 0.7,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: onboardingData.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == entry.key
                        ? Colors.blue
                        : Colors.blue.withOpacity(0.3),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_current < onboardingData.length - 1) {
                      _controller.nextPage();
                    } else {
                      Get.offAll(LoginPage());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Text(
                    _current < onboardingData.length - 1
                        ? 'Selanjutnya'
                        : 'Mulai',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}