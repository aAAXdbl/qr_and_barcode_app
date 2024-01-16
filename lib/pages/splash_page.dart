import 'package:flutter/material.dart';
import 'package:qr_app/pages/home_page.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    goPage();
  }

  void goPage() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xff6ff7e8),
              Color(0xff1f7ea1),
            ],
          )),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/qr-animation-white.json",
                repeat: false,
                width: 200,
                height: 150,
                fit: BoxFit.contain,
                frameRate: const FrameRate(240.00),
              ),
              const SizedBox(height: 25),
              const Text(
                "QR Code",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
