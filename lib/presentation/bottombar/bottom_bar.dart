import 'package:flutter/material.dart';

import 'package:mobile_umroh_v2/presentation/home/home.dart';
import 'package:mobile_umroh_v2/presentation/profile/profile_page.dart';
import 'package:mobile_umroh_v2/presentation/search/search_page.dart';

class BottomMain extends StatefulWidget {
  const BottomMain({super.key});

  @override
  State<BottomMain> createState() => _BottomMainState();
}

class _BottomMainState extends State<BottomMain> {
  int _selectedIndex = 0;

  final List<Widget> _screen = [
    const HomePage(),
    const SearchPage(),
    const ProfilePage(),
    const ProfilePage(),
  ];

  void _onTapSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    return const [
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/home_2.png')),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/kacamata_pembesar.png')),
        label: 'Cari',
      ),
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/jadwal_2.png')),
          label: 'Jadwal'),
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/profile_2.png')),
          label: 'Profile')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: const Color(0xff4169E1),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Color(0xff6D90F9),
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Color(0xff4169E1),
        ),
        currentIndex: _selectedIndex,
        items: _buildBottomNavigationBarItems(),
        onTap: _onTapSelected,
      ),
      body: _screen.elementAt(_selectedIndex),
    );
  }
}
