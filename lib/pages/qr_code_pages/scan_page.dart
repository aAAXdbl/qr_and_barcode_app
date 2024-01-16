import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String qrResult = "Scanned Data will appear here";
  bool isScan = false;

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        qrResult = qrCode.toString();
        isScan = true;
      });
    } on PlatformException {
      qrResult = "Fail to read QR Code";
    }
  }

  void copyClipboard() {
    Clipboard.setData(ClipboardData(text: qrResult)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text(
            textAlign: TextAlign.center,
            'Copied to your clipboard !',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }

  void shareCode() {
    Share.share(qrResult);
  }

  Future<void> _launchUrl() async {
    final url = Uri.parse(qrResult);
    try {
      await launchUrl(url);
    } on Exception {
      // URL çalışmazsa bunu bir URL olmadığını göster
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text(
            'Could not launch URL',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "QR Code Scanner",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Image.asset(
              "assets/scan-image.png",
              width: 300,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(qrResult,
                style: const TextStyle(
                  fontSize: 18,
                )),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              label: const Text("Scan Code"),
              icon: const Icon(Icons.qr_code_scanner),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: scanQR,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isScan
                      ? ElevatedButton.icon(
                          onPressed: isScan ? copyClipboard : null,
                          icon: const Icon(Icons.copy, color: Colors.white70),
                          label: const Text("Copy",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent))
                      : const SizedBox.shrink(),
                  isScan
                      ? ElevatedButton.icon(
                          onPressed: isScan ? _launchUrl : null,
                          icon: const Icon(Icons.open_in_browser,
                              color: Colors.white70),
                          label: const Text("Browser",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent))
                      : const SizedBox.shrink(),
                  isScan
                      ? ElevatedButton.icon(
                          onPressed: isScan ? shareCode : null,
                          icon: const Icon(Icons.share, color: Colors.white70),
                          label: const Text(
                            "Share",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent))
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
