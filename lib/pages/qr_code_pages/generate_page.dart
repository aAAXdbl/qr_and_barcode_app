import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  ScreenshotController screenshotController = ScreenshotController();
  TextEditingController urlController = TextEditingController();
  bool isGenerate = false;

  Future<void> _launchUrl() async {
    final url = Uri.parse(urlController.text);
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: const Text(
          "Generate QR Code",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(children: [
          if (urlController.text.isNotEmpty)
            Screenshot(
              controller: screenshotController,
              child: Container(
                color: Colors.white,
                child: QrImageView(
                  data: urlController.text,
                  version: QrVersions.auto,
                  size: 200,
                ),
              ),
            ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              onEditingComplete: () {
                if (urlController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.blueAccent,
                      content: Text(
                        textAlign: TextAlign.center,
                        'Enter your data :)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold,color:Colors.white),
                      ),
                    ),
                  );
                }else {
                  isGenerate = true;
                }
                // Close Keyboard.
                FocusScope.of(context).unfocus();
              },
              controller: urlController,
              decoration: InputDecoration(
                hintText: "Enter your data",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  if (urlController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.blueAccent,
                        content: Text(
                          textAlign: TextAlign.center,
                          'Enter your data :)',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold,color:Colors.white),
                        ),
                      ),
                    );
                  } else {
                    isGenerate = true;
                  }
                });
              },
              child: const Text("Generate QR Code")),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                isGenerate
                    ? ElevatedButton.icon(
                        onPressed: _launchUrl,
                        icon: const Icon(Icons.open_in_browser,
                            color: Colors.white70),
                        label: const Text("Browser",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ))
                    : const SizedBox.shrink(),
                isGenerate
                    ? ElevatedButton.icon(
                        onPressed: () {
                          if (urlController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.blueAccent,
                                content: Text(
                                  'Generate your QR code first',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          } else {
                            _shareQrCode();
                          }
                        },
                        icon: const Icon(Icons.share, color: Colors.white70),
                        label: const Text(
                          "Share",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ))
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ]),
      )),
    );
  }

  _shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;

    try {
      final image =
          await screenshotController.capture(); // Değişkeni burada tanımlayın
      if (image != null) {
        String fileName = DateTime.now().microsecondsSinceEpoch.toString();
        final imagePath = await File('$directory/$fileName.png').create();
        await imagePath.writeAsBytes(image);
        Share.shareXFiles([XFile(imagePath.path)], text: "My QR Code");
      }
    } catch (error) {
      print('Error sharing QR Code: $error');
    }
  }
}
