import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class BarcodeGeneratePage extends StatefulWidget {
  const BarcodeGeneratePage({super.key});

  @override
  State<BarcodeGeneratePage> createState() => _BarcodeGeneratePageState();
}

class _BarcodeGeneratePageState extends State<BarcodeGeneratePage> {
  ScreenshotController screenshotController = ScreenshotController();
  TextEditingController urlController = TextEditingController();
  bool isGenerate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          "Generate Barcode",
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
                width: 250,
                color: Colors.white,
                child: BarcodeWidget(
                  data: urlController.text,
                  barcode: Barcode.code128(),
                ),
              ),
            ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              onEditingComplete: () {
                if (urlController.text.isNotEmpty) {
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
          const SizedBox(height: 10),
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
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  } else {
                    isGenerate = true;
                  }
                });
              },
              child: const Text("Generate Barcode")),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                isGenerate
                    ? ElevatedButton.icon(
                        onPressed: () {
                          if (urlController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.blueAccent,
                                content: Text(
                                  'Generate your Barcode first',
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
                            backgroundColor: Colors.blueAccent))
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
      print('Error sharing QR code: $error');
    }
  }
}
