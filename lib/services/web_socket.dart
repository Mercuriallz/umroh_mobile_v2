import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/foundation.dart';

class SocketService {
  late io.Socket socket;

  void connect({required String token}) {
    debugPrint("🔌 Mencoba menghubungkan ke WebSocket dengan token...");
    

    socket = io.io(
      'https://api.umrahdesa.com',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setAuth({'auth': token})
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

    socket.onReconnect((data) {
      debugPrint('♻️ Mencoba menyambung ulang...');
    });

    socket.onReconnectAttempt((data) {
      debugPrint('🔁 Mencoba reconnect...');
    });

    socket.onReconnectError((err) {
      debugPrint('❗ Gagal reconnect: $err');
    });

    socket.onReconnectFailed((_) {
      debugPrint('🛑 Gagal total reconnect ke WebSocket');
    });

    socket.on('payment_success', (data) {
      debugPrint('📨 Notifikasi pembayaran diterima: $data');
    });

    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
    debugPrint('🔌 Koneksi WebSocket dihentikan manual');
  }
}
