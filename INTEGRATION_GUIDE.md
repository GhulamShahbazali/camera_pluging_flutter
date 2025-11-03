# Integration Guide: Camera Image to Flutter

## How to integrate captured image in your Flutter app

### 1. Update your ScanController (or any controller):

```dart
import 'package:usb_camera_plugin/usb_camera_plugin.dart';

class ScanController extends GetxController with WidgetsBindingObserver {
  final _usbCameraPlugin = UsbCameraPlugin();
  
  @override
  void onInit() {
    super.onInit();
    // Add observer to listen when app resumes
    WidgetsBinding.instance.addObserver(this);
  }
  
  @override
  void onClose() {
    // Remove observer
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When app comes back from camera
    if (state == AppLifecycleState.resumed) {
      _checkForCapturedImage();
    }
  }
  
  Future<void> _checkForCapturedImage() async {
    try {
      final imagePath = await _usbCameraPlugin.getLastCapturedImage();
      if (imagePath != null && imagePath.isNotEmpty) {
        // ✅ Image captured! Show it
        selectedImage.value = File(imagePath);
        
        // Optional: Navigate to result screen
        // Get.toNamed(AppPages.resultPage);
      }
    } catch (e) {
      print('Error getting image: $e');
    }
  }
  
  Future<void> _openCamera() async {
    try {
      await _usbCameraPlugin.openCamera();
      // When user confirms in camera, app will resume
      // and didChangeAppLifecycleState will be called
    } catch (e) {
      print('Error opening camera: $e');
    }
  }
}
```

### 2. In your widget:

```dart
class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScanController>();
    
    return Scaffold(
      body: Column(
        children: [
          // Show captured image if available
          Obx(() {
            if (controller.selectedImage.value != null) {
              return Image.file(
                controller.selectedImage.value!,
                height: 300,
                fit: BoxFit.cover,
              );
            }
            return SizedBox(height: 300);
          }),
          
          // Camera button
          ElevatedButton(
            onPressed: () => controller._openCamera(),
            child: Text('Open Camera'),
          ),
        ],
      ),
    );
  }
}
```

### 3. Flow:

```
User presses button
    ↓
Camera opens
    ↓
User takes photo
    ↓
Preview shows (Tick/Cancel)
    ↓
User presses Tick (✓)
    ↓
Image saves to SharedPreferences
    ↓
Camera closes
    ↓
Flutter app resumes (didChangeAppLifecycleState)
    ↓
_checkForCapturedImage() called
    ↓
Image loaded to selectedImage
    ↓
UI updates automatically (Obx)
    ↓
Image displays! 🎉
```

### 4. Your exact code update:

Add these to your existing ScanController:

```dart
// Add this at class level
@override
void onInit() {
  super.onInit();
  _ensureMacAddress();
  _initPlatformState();
  WidgetsBinding.instance.addObserver(this); // ← ADD THIS
}

@override
void onClose() {
  WidgetsBinding.instance.removeObserver(this); // ← ADD THIS
  super.onClose();
}

// Add this method
@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  if (state == AppLifecycleState.resumed) {
    _checkForCapturedImage();
  }
}

// Add this method
Future<void> _checkForCapturedImage() async {
  try {
    final imagePath = await _usbCameraPlugin.getLastCapturedImage();
    if (imagePath != null && imagePath.isNotEmpty) {
      selectedImage.value = File(imagePath);
      // Image will automatically show in your UI via Obx
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error getting captured image: $e');
    }
  }
}
```

That's it! Your existing _openCamera() and UI will work automatically!
