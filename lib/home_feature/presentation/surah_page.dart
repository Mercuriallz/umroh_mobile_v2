import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mobile_umroh_v2/home_feature/bloc/surah/surah_bloc.dart';
import 'package:mobile_umroh_v2/home_feature/bloc/surah/surah_state.dart';
import 'package:mobile_umroh_v2/home_feature/model/alquran/surah_model.dart';

class SurahReaderPage extends StatefulWidget {
  final int surahNumber;

  const SurahReaderPage({
    super.key,
    required this.surahNumber,
  });

  @override
  State<SurahReaderPage> createState() => _SurahReaderPageState();
}

class _SurahReaderPageState extends State<SurahReaderPage> {
  late TextEditingController _surahController;

  @override
  void initState() {
    super.initState();
    _surahController =
        TextEditingController(text: widget.surahNumber.toString());
    // Load initial surah
    context.read<SurahBloc>().fetchSurah(widget.surahNumber);
  }

  @override
  void dispose() {
    _surahController.dispose();
    super.dispose();
  }

  void _loadSurah() {
    final surahNumber = int.tryParse(_surahController.text);
    if (surahNumber != null && surahNumber >= 1 && surahNumber <= 114) {
      context.read<SurahBloc>().fetchSurah(surahNumber);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nomor surah yang valid (1-114)'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: BlocBuilder<SurahBloc, SurahState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              _buildAppBar(state),
              if (state is SurahLoading) _buildLoadingSliver(),
              if (state is SurahError) _buildErrorSliver(state.message),
              if (state is SurahLoaded) ...[
                _buildSurahHeader(state.surah),
                _buildAyatList(state.surah),
                _buildNavigationButtons(state.surah),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(SurahState state) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF2E7D4F),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2E7D4F), Color(0xFF4CAF50)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _surahController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    hintText: 'Nomor Surah (1-114)',
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(2),
                                child: ElevatedButton(
                                  onPressed: _loadSurah,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2E7D4F),
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(12),
                                    elevation: 0,
                                  ),
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
      title: Text(
        state is SurahLoaded ? state.surah.namaLatin ?? 'Al-Quran' : 'Al-Quran',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLoadingSliver() {
    return const SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D4F)),
            ),
            SizedBox(height: 16),
            Text(
              'Memuat Surah...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorSliver(String message) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Terjadi Kesalahan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadSurah,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D4F),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Coba Lagi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSurahHeader(SurahModel surah) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2E7D4F), Color(0xFF4CAF50)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Arabic Name
              Text(
                surah.nama ?? '',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Amiri',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Latin Name and Number
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${surah.nomor}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    surah.namaLatin ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Surah Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoItem(
                    Icons.bookmark,
                    '${surah.jumlahAyat} Ayat',
                  ),
                  _buildInfoItem(
                    Icons.location_on,
                    surah.tempatTurun ?? '',
                  ),
                  _buildInfoItem(
                    Icons.translate,
                    surah.arti ?? '',
                  ),
                ],
              ),
              if (surah.deskripsi != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // child: Text(
                  //   surah.deskripsi!,
                  //   style: const TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 14,
                  //     height: 1.5,
                  //   ),
                  //   textAlign: TextAlign.justify,
                  // ),
                  child: Html(
                    data: surah.deskripsi,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildAyatList(SurahModel surah) {
    if (surah.ayat == null || surah.ayat!.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Text('Tidak ada ayat yang ditemukan'),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final ayat = surah.ayat![index];
          return _buildAyatCard(ayat, index == 0);
        },
        childCount: surah.ayat!.length,
      ),
    );
  }

  Widget _buildAyatCard(Ayat ayat, bool isFirstAyat) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        16,
        isFirstAyat ? 8 : 4,
        16,
        4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ayat Number
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D4F),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      '${ayat.nomor}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(
                    Icons.play_circle_outline,
                    color: Color(0xFF2E7D4F),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Arabic Text
            // Text(
            //   ayat.ar ?? '',
            //   style: const TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.w500,
            //     color: Color(0xFF1A1A1A),
            //     fontFamily: 'Amiri',
            //     height: 2.0,
            //   ),
            //   textAlign: TextAlign.right,
            // ),
            Html(
              data: ayat.ar ?? '',
              style: {
                'body': Style(
                  fontSize:  FontSize(24),
                  fontFamily: 'Amiri',
                  // height:  LineHeight(2.0),
                  textAlign: TextAlign.right,
                ),
              },
            ),
            const SizedBox(height: 12),
            // Transliteration
            if (ayat.tr != null) ...[
              // Text(
              //   ayat.tr!,
              //   style: const TextStyle(
              //     fontSize: 16,
              //     fontStyle: FontStyle.italic,
              //     color: Color(0xFF2E7D4F),
              //     height: 1.5,
              //   ),
              // ),
              Html(data: ayat.tr!),
              const SizedBox(height: 8),
            ],
            // Indonesian Translation
            if (ayat.idn != null) ...[
              Text(
                ayat.idn!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF424242),
                  height: 1.6,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(SurahModel surah) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Previous Surah
            if (surah.nomor != null && surah.nomor! > 1)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _surahController.text = '${surah.nomor! - 1}';
                    _loadSurah();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2E7D4F),
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Color(0xFF2E7D4F)),
                    ),
                  ),
                  icon: const Icon(Icons.chevron_left),
                  label: const Text('Surah Sebelumnya'),
                ),
              ),
            if (surah.nomor != null && surah.nomor! > 1)
              const SizedBox(width: 16),
            // Next Surah
            if (surah.suratSelanjutnya != null)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _surahController.text = '${surah.suratSelanjutnya!.nomor}';
                    _loadSurah();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D4F),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.chevron_right),
                  label: const Text('Surah Selanjutnya'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
