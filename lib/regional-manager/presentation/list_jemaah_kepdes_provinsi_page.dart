import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh_v2/regional-manager/bloc/list-jemaah-kepdes-provinsi/list_jemaah_kepdes_provinsi_bloc.dart';
import 'package:mobile_umroh_v2/regional-manager/bloc/list-jemaah-kepdes-provinsi/list_jemaah_kepdes_provinsi_state.dart';

class ListJemaahKepdesProvinsiPage extends StatefulWidget {
  final String provinsiId;

  const ListJemaahKepdesProvinsiPage({super.key, required this.provinsiId});

  @override
  State<ListJemaahKepdesProvinsiPage> createState() =>
      _ListJemaahKepdesProvinsiPageState();
}

class _ListJemaahKepdesProvinsiPageState
    extends State<ListJemaahKepdesProvinsiPage> {
  late final ListJemaahKepdesProvinsiBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ListJemaahKepdesProvinsiBloc();
    bloc.getListJemaahKepdesProvinsi(widget.provinsiId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Data Jemaah & Kepdes",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: BlocBuilder<ListJemaahKepdesProvinsiBloc,
          ListJemaahKepdesProvinsiState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ListJemaahKepdesProvinsiInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ListJemaahKepdesProvinsiLoaded) {
            final data = state.dataJemaahKepdesProvinsi;

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
                        const Icon(Icons.groups, size: 36, color: Colors.indigo),
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
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
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
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  ...?data.userJemaah?.map((jemaah) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person_outline,
                                color: Colors.white),
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
          } else if (state is ListJemaahKepdesProvinsiError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text("Error: ${state.message}",
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
