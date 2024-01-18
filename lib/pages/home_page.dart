import 'package:flutter/material.dart';
import 'package:qr_app/pages/qr_code_pages/qr_code_page.dart';
import 'barcode_pages/barcode_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List pages = [
    const QrCodePage(),
    const BarcodePage(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: onTap,
          selectedItemColor: Colors.red.shade600,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code), label: "QR Code",),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: "Barcode"),
          ]),
      body: pages[currentIndex],
    );
  }
}
