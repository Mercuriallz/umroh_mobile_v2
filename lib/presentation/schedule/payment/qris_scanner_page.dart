import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRISScannerPage extends StatefulWidget {
  const QRISScannerPage({super.key});

  @override
  State<QRISScannerPage> createState() => _QRISScannerPageState();
}

class _QRISScannerPageState extends State<QRISScannerPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? resultText;
  String? resultType;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  void handleScanResult(String data) {
    setState(() {
      resultText = data;

      if (data.startsWith("http")) {
        resultType = "URL";
      } else if (data.startsWith("WIFI:")) {
        resultType = "WiFi Credentials";
      } else if (data.startsWith("BEGIN:VCARD")) {
        resultType = "Contact (vCard)";
      } else if (data.contains("@") && data.contains(".")) {
        resultType = "Email";
      } else if (data.toLowerCase().contains("qris")) {
        resultType = "QRIS";
      } else {
        resultType = "Plain Text";
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Code")),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: resultText == null
                  ? const Center(child: Text("Arahkan kamera ke QR code"))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tipe Deteksi: $resultType",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Isi QR: $resultText",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, resultText);
                          },
                          child: const Text("Gunakan Data Ini"),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      final code = scanData.code;
      if (code != null) {
        controller.pauseCamera();
        handleScanResult(code);
      }
    });
  }
}
