import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/pages/splash_page.dart';
import 'package:qr_app/theme/change_theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ChangeTheme(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR APP',
      theme: Provider.of<ChangeTheme>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
