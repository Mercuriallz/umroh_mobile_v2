import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/area-manager/bloc/list-jemaah-kepdes-kabupaten/list_jemaah_kepdes_kabupaten_bloc.dart';
import 'package:mobile_umroh_v2/area-manager/bloc/list-jemaah-kepdes-kabupaten/list_jemaah_kepdes_kabupaten_state.dart';

class ListJemaahKepdesKabupatenPage extends StatefulWidget {
  final String kabupatenId;

  const ListJemaahKepdesKabupatenPage({super.key, required this.kabupatenId});

  @override
  State<ListJemaahKepdesKabupatenPage> createState() =>
      _ListJemaahKepdesKabupatenPageState();
}

class _ListJemaahKepdesKabupatenPageState
    extends State<ListJemaahKepdesKabupatenPage> {
  late final ListJemaahKepdesKabupatenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ListJemaahKepdesKabupatenBloc()
      ..getListJemaahKepdesKabupaten(widget.kabupatenId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Jemaah & Kepdes Kabupaten")),
      body: BlocBuilder<ListJemaahKepdesKabupatenBloc,
          ListJemaahKepdesKabupatenState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is ListJemaahKepdesKabupatenInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ListJemaahKepdesKabupatenError) {
            return Center(child: Text(state.message));
          } else if (state is ListJemaahKepdesKabupatenLoaded) {
            final data = state.dataListJemaahKepdesKabupaten;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.groups,
                            size: 36, color: Colors.indigo),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Total Jemaah",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54)),
                            Text(
                              "${data.totalJemaah ?? 0} Orang",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Kepdes Section
                  const Text("📌 Daftar Kepdes",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  ...?data.userKepdes?.map((kepdes) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.indigo,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(kepdes.name ?? '-',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text("Username: ${kepdes.username ?? '-'}"),
                        ),
                      )),

                  const SizedBox(height: 28),

                  const Text("👥 Daftar Jemaah",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  ...?data.userJemaah?.map((jemaah) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child:
                                Icon(Icons.person_outline, color: Colors.white),
                          ),
                          title: Text(jemaah.name ?? '-',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email: ${jemaah.email ?? '-'}"),
                              Text("Gender: ${jemaah.gender ?? '-'}"),
                              Text("Kepdes: ${jemaah.kepdesName ?? '-'}"),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  TextStyle _sectionTitleStyle() {
    return const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87);
  }

  Widget _buildKepdesCard(user) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              child: Icon(Icons.account_circle, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name ?? "-",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text("Username: ${user.username ?? '-'}",
                      style: _captionStyle()),
                  Text("ID Kabupaten: ${user.idKabupaten ?? '-'}",
                      style: _captionStyle()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJemaahCard(user) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue.shade50,
              child: Icon(
                user.gender?.toLowerCase() == 'laki-laki'
                    ? Icons.male
                    : Icons.female,
                color: Colors.blue,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name ?? "-",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text("Email: ${user.email ?? '-'}", style: _captionStyle()),
                  Text("Gender: ${user.gender ?? '-'}", style: _captionStyle()),
                  Text(
                      "Kepdes: ${user.kepdesName ?? '-'} (${user.kepdesUsername ?? '-'})",
                      style: _captionStyle()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _captionStyle() {
    return const TextStyle(fontSize: 13, color: Colors.black54);
  }
}
