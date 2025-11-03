import 'package:flutter/material.dart';
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
  String _platformVersion = 'Unknown';
  String _cameraStatus = 'Ready';

  @override
  void initState() {
    super.initState();
    _initPlatformState();
    // Auto-open camera after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      _openCamera();
    });
  }

  Future<void> _initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await _usbCameraPlugin.getPlatformVersion() ?? 'Unknown';
    } catch (e) {
      platformVersion = 'Failed: $e';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _openCamera() async {
    setState(() {
      _cameraStatus = 'Opening camera...';
    });

    try {
      await _usbCameraPlugin.openCamera();
      setState(() {
        _cameraStatus = 'Camera opened successfully';
      });
    } catch (e) {
      setState(() {
        _cameraStatus = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('USB Camera Plugin'),
          centerTitle: true,
          elevation: 2,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade50,
                Colors.white,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Icon
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.videocam,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Title
                  const Text(
                    'USB Camera Plugin',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Platform Info
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Platform: $_platformVersion',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Open Camera Button
                  ElevatedButton(
                    onPressed: _openCamera,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.camera_alt, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'Open USB Camera',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Status
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue.shade100,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _cameraStatus.contains('Error')
                              ? Icons.error_outline
                              : _cameraStatus.contains('successfully')
                                  ? Icons.check_circle_outline
                                  : Icons.info_outline,
                          color: _cameraStatus.contains('Error')
                              ? Colors.red
                              : _cameraStatus.contains('successfully')
                                  ? Colors.green
                                  : Colors.blue,
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            _cameraStatus,
                            style: TextStyle(
                              fontSize: 14,
                              color: _cameraStatus.contains('Error')
                                  ? Colors.red
                                  : Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Features
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.stars, color: Colors.blue.shade700),
                              const SizedBox(width: 8),
                              const Text(
                                'Features',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildFeature('📹 Video Recording'),
                          _buildFeature('📸 Photo Capture'),
                          _buildFeature('🎨 Camera Effects'),
                          _buildFeature('⚙️ Advanced Settings'),
                          _buildFeature('🔄 Multi-Camera Support'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Text(
            feature,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
