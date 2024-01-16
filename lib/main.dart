import 'package:flutter/material.dart';
import 'package:qr_app/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR APP',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
