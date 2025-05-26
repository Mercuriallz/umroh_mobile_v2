import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/foundation.dart';

class SocketService {
  late io.Socket socket;

  void connect({required String token}) {
    debugPrint("🔌 Mencoba menghubungkan ke WebSocket dengan token...");
    
    socket = io.io(
      'https://umroh-be.floxy-it.cloud',
      io.OptionBuilder()
          .setTransports(['websocket']) // wajib websocket
          .enableAutoConnect()
          .setAuth({'auth': token}) // kirim token JWT
          .build(),
    );

    socket.onConnect((_) {
      debugPrint('✅ Terhubung ke server WebSocket');
    });

    socket.onDisconnect((_) {
      debugPrint('❌ Terputus dari server WebSocket');
    });

    socket.onConnectError((err) {
      debugPrint('❗ Terjadi kesalahan saat menghubungkan: $err');
    });

    socket.onError((err) {
      debugPrint('🔥 Error umum WebSocket: $err');
    });

    socket.on('payment_success', (data) {
      debugPrint('📨 Notifikasi pembayaran diterima: $data');
    });

    // Panggil connect manual agar koneksi benar-benar dimulai
    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
    debugPrint('🔌 Koneksi WebSocket dihentikan manual');
  }
}
