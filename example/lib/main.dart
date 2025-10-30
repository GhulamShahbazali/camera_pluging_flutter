import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usb_camera_plugin/usb_camera_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _usbCameraPlugin = UsbCameraPlugin();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('USB Camera Plugin'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.videocam, size: 100, color: Colors.blue),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    await _usbCameraPlugin.openCamera();
                  } catch (e) {
                    print('Error: $e');
                  }
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Open USB Camera'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
