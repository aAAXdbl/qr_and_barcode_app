import 'package:flutter/material.dart';
import 'package:qr_app/pages/barcode_pages/barcode_generate_page.dart';
import 'package:qr_app/pages/barcode_pages/barcode_scan_page.dart';

class BarcodePage extends StatefulWidget {
  const BarcodePage({super.key});

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const Drawer(
        width: 250,
      ),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 75,
        title: const Text(
          "Barcode",
          style: TextStyle(
            fontSize: 35,
            letterSpacing: 3,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Place the Barcode inside the frame to scan or generate your own Barcode.",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Card(
                  elevation: 10,
                  color: Colors.transparent,
                  child: Image.asset(
                    "assets/barcode-image.jpg",
                    width: 300,
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18,letterSpacing: 2),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BarcodeScanPage()));
                    });
                  },
                  child: const Text("Scan Barcode")),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18,letterSpacing: 2),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BarcodeGeneratePage(),
                          ));
                    });
                  },
                  child: const Text("Generate Barcode"))
            ],
          ),
        ),
      ),
    );
  }
}
