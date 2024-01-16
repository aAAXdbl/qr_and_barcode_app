import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:share_plus/share_plus.dart';

class BarcodeScanPage extends StatefulWidget {
  const BarcodeScanPage({super.key});

  @override
  State<BarcodeScanPage> createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends State<BarcodeScanPage> {
  String barcodeResult = "Scanned Data will appear here";
  bool isScan = false;

  Future<void> scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
      if (!mounted) return;
      setState(() {
        barcodeResult = barcode.toString();
        isScan = true;
      });
    } on PlatformException {
      barcodeResult = "Fail to read Barcode";
    }
  }

  void copyClipboard() {
    Clipboard.setData(ClipboardData(text: barcodeResult)).then((_) {
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
    Share.share(barcodeResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Barcode Scanner",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/barcode-scan-image.png",
                width: 300,
              ),
              const SizedBox(height: 15),
              Text(
                barcodeResult,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                label: const Text("Scan Code"),
                icon: const Icon(Icons.document_scanner_outlined),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: scanBarcode,
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
                            onPressed: isScan ? shareCode : null,
                            icon:
                                const Icon(Icons.share, color: Colors.white70),
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
        ),
      ),
    );
  }
}
