import 'package:flutter/material.dart';
import 'dart:io';
import 'package:usb_camera_plugin/usb_camera_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'USB Camera Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CameraHomePage(),
    );
  }
}

class CameraHomePage extends StatefulWidget {
  const CameraHomePage({super.key});

  @override
  State<CameraHomePage> createState() => _CameraHomePageState();
}

class _CameraHomePageState extends State<CameraHomePage> with WidgetsBindingObserver {
  final _usbCameraPlugin = UsbCameraPlugin();
  String? _capturedImagePath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When app comes back to foreground, check for captured image
    if (state == AppLifecycleState.resumed) {
      _checkForCapturedImage();
    }
  }

  Future<void> _checkForCapturedImage() async {
    try {
      final imagePath = await _usbCameraPlugin.getLastCapturedImage();
      if (imagePath != null && imagePath.isNotEmpty) {
        setState(() {
          _capturedImagePath = imagePath;
        });
        // Navigate to result screen
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CapturedImageScreen(imagePath: imagePath);

              },
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error checking for captured image: $e');
    }
  }

  Future<void> _openCamera() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _usbCameraPlugin.openCamera();
      // Camera will open, and when user confirms, image will be saved
      // When user returns to this app, didChangeAppLifecycleState will check for image
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USB Camera Plugin'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.camera_alt,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 32),
            const Text(
              'USB Camera Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tap the button below to open camera',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            if (_capturedImagePath != null) ...[
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.file(
                    File(_capturedImagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Last Captured Image',
                style: TextStyle(color: Colors.green),
              ),
              const SizedBox(height: 32),
            ],
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _openCamera,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.camera),
              label: Text(_isLoading ? 'Opening...' : 'Open Camera'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

