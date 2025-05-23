// import 'package:mobile_umroh_v2/services/storage.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;

// class WebSocketService {
//   static final WebSocketService _instance = WebSocketService._internal();
//   factory WebSocketService() => _instance;

//   late WebSocketChannel _channel;

//   WebSocketService._internal();

//   Future<void> connect(String url) async {
//     final secureStorage = SecureStorageService();
//     final token = await secureStorage.read("token");

//     try {
//       _channel = IOWebSocketChannel.connect(
//         Uri.parse(url),
//         headers: {
//           "auth": "$token",
//         },
//       );

//       // Logging koneksi WebSocket
//       print('🔌 Mencoba koneksi ke WebSocket...');

//       // Dengarkan stream untuk status koneksi
//       _channel.stream.listen(
//         (event) {
//           print('✅ WebSocket terhubung dan menerima data: $event');
//         },
//         onDone: () {
//           print('❌ WebSocket telah ditutup.');
//         },
//         onError: (error) {
//           print('⚠️ WebSocket error: $error');
//         },
//       );

//       // Tunggu sampai siap (opsional)
//       await _channel.ready;
//     } catch (e) {
//       print('🚫 Gagal konek ke WebSocket: $e');
//     }
//   }

//   Stream get stream => _channel.stream;

//   void send(String message) {
//     _channel.sink.add(message);
//   }

//   void disconnect() {
//     _channel.sink.close(status.goingAway);
//   }
// }

import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketService {
  late IO.Socket socket;

  void connect({required String token, required int userId}) {
    socket = IO.io(
      'https://umroh-be.floxy-it.cloud',
      IO.OptionBuilder()
          .setTransports(['websocket']) // wajib websocket
          .enableAutoConnect()
          .setAuth({'token': token}) // kirim JWT
          .build(),
    );

    socket.onConnect((_) {
      print('✅ Connected to socket server');
      socket.emit('join', userId); // join ke room
    });

    socket.on('payment_success', (data) {
      print('📨 Payment success received: $data');
      // TODO: tampilkan notifikasi ke UI / Bloc / Provider
    });

    socket.onDisconnect((_) => print('❌ Disconnected'));
    socket.onConnectError((err) => print('❗ Connect error: $err'));
  }

  void disconnect() {
    socket.disconnect();
  }
}



