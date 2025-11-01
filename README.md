# usb_camera_plugin

A Flutter plugin for accessing and controlling USB cameras on Android devices. This plugin enables you to connect external USB cameras (UVC - USB Video Class) to your Flutter apps and access professional camera features.

## Features

✅ **USB Camera Support** - Connect and control external USB cameras (UVC compatible)  
✅ **Real-time Preview** - Display live camera feed in your Flutter app  
✅ **Video Recording** - Record videos in MP4 format with H.264 encoding  
✅ **Image Capture** - Take high-quality photos  
✅ **Audio Support** - Record audio with AAC encoding  
✅ **Visual Effects** - Apply effects like black & white, soul, zoom  
✅ **Multiple Camera Types** - Supports Camera1, Camera2, and UVC cameras  
✅ **Professional Features** - Resolution control, encoding options, and more

## Platform Support

| Platform | Support |
|----------|---------|
| Android  | ✅ Yes  |
| iOS      | ❌ No   |
| Web      | ❌ No   |
| Windows  | ❌ No   |
| macOS    | ❌ No   |
| Linux    | ❌ No   |

## Requirements

- Flutter SDK: >=3.3.0
- Dart SDK: ^3.8.1
- Android minSdkVersion: 24 (Android 7.0)
- Android compileSdkVersion: 34
- USB OTG support on your Android device
- UVC compatible USB camera

## Installation

### 📦 Add to Your Project

The plugin now works in **ANY Flutter project**! 🎉

**Option 1: From Git (Recommended for now)**

```yaml
dependencies:
  usb_camera_plugin:
    git:
      url: https://github.com/teamtechackers/create_new_camara_plugin.git
```

**Option 2: Local Path (for development)**

```yaml
dependencies:
  usb_camera_plugin:
    path: /path/to/camera_pluging_flutter_v1
```

Then run:

```bash
flutter pub get
```

### 🎯 Two Ways to Use

**Choose based on your needs:**

#### **Option 1: Quick Integration** (5 minutes)
Add plugin to any project for basic camera bridge functionality.

#### **Option 2: Full Features** (30 minutes) ⭐ RECOMMENDED
Get complete camera UI in YOUR project with all features:
- ✅ **USB Camera Detection** - Automatic device discovery
- ✅ **Real-time Preview** - Multiple resolution support
- ✅ **Video Recording** - H.264/MP4 format
- ✅ **Photo Capture** - High-quality images
- ✅ **Effects** - Black & White, Soul, Zoom, and more
- ✅ **Audio Recording** - AAC audio support
- ✅ **Settings & Controls** - Brightness, contrast, resolution
- ✅ **Multi-camera Support** - Switch between cameras
- ✅ **Professional UI** - Modern, intuitive interface

**Works in YOUR project with simple setup!**

---

## 🚀 Quick Start for YOUR Project (test_1, test_2, etc.)

### Step 1: Run Auto-Setup Script

```bash
cd /Users/apple/AndroidStudioProjects/camera_pluging_flutter_v1
./setup_in_project.sh /Users/apple/AndroidStudioProjects/test_1
```

This copies all camera files to your project!

### Step 2: Add to Your pubspec.yaml

```yaml
dependencies:
  usb_camera_plugin:
    path: ../camera_pluging_flutter_v1
```

### Step 3: Update Your build.gradle

Add to `android/app/build.gradle`:

```gradle
android {
    compileSdk 34
    ndkVersion "27.0.12077973"
    
    defaultConfig {
        minSdk 24
        multiDexEnabled true
    }
    
    buildFeatures {
        viewBinding true
        dataBinding true
    }
}

dependencies {
    // Camera dependencies
    implementation 'com.afollestad.material-dialogs:core:3.2.1'
    implementation 'com.geyifeng.immersionbar:immersionbar:3.2.2'
    implementation 'com.github.bumptech.glide:glide:4.10.0'
    implementation 'com.tencent:mmkv:1.2.12'
    implementation 'androidx.lifecycle:lifecycle-viewmodel-ktx:2.2.0'
    implementation 'androidx.multidex:multidex:2.0.1'
    implementation 'org.jetbrains.kotlinx:kotlinx-coroutines-android:1.3.9'
}
```

### Step 4: Update AndroidManifest

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<activity
    android:name="com.jiangdg.demo.MainActivity"
    android:exported="false"
    android:configChanges="orientation|keyboardHidden|keyboard|screenSize"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar" />
```

### Step 5: Use in Flutter!

```dart
import 'package:usb_camera_plugin/usb_camera_plugin.dart';

ElevatedButton(
  onPressed: () async {
    await UsbCameraPlugin().openCamera();
    // Full camera UI opens! 🎉
  },
  child: Text('Open Camera'),
)
```

**Done!** Full camera features in YOUR app! 🚀

📖 **Detailed guide:** See `HOW_TO_USE_WITH_YOUR_PROJECT.md`

### 🚀 Quick Start

```dart
import 'package:usb_camera_plugin/usb_camera_plugin.dart';

// Create plugin instance
final _usbCameraPlugin = UsbCameraPlugin();

// Open camera
await _usbCameraPlugin.openCamera();
```

## Android Setup

Add the following permissions to your `AndroidManifest.xml`:

```xml
<uses-feature android:name="android.hardware.usb.host" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:usb_camera_plugin/usb_camera_plugin.dart';

class CameraScreen extends StatelessWidget {
  final _usbCameraPlugin = UsbCameraPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USB Camera'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await _usbCameraPlugin.openCamera();
            } catch (e) {
              print('Error opening camera: $e');
            }
          },
          child: Text('Open USB Camera'),
        ),
      ),
    );
  }
}
```

### Get Platform Version

```dart
final plugin = UsbCameraPlugin();
String? version = await plugin.getPlatformVersion();
print('Platform version: $version');
```

## API Reference

### UsbCameraPlugin

Main class for interacting with USB cameras.

#### Methods

- **`openCamera()`** - Opens the USB camera interface
  ```dart
  Future<void> openCamera()
  ```

- **`getPlatformVersion()`** - Returns the Android platform version
  ```dart
  Future<String?> getPlatformVersion()
  ```

## Compatible Devices

This plugin works with UVC (USB Video Class) compatible cameras, including:

- External USB webcams
- USB endoscope cameras
- USB microscope cameras
- Industrial USB cameras
- Medical USB cameras
- Most USB cameras that follow the UVC standard

## Use Cases

- 🏥 **Medical Applications** - Endoscope and microscope integration
- 🏭 **Industrial Inspection** - Quality control and monitoring
- 🔬 **Scientific Research** - Laboratory equipment integration
- 📹 **Video Production** - Professional camera integration
- 🎮 **Streaming Apps** - External camera support
- 🔐 **Security Systems** - Surveillance camera integration

## Known Limitations

- Currently supports Android only
- Requires USB OTG support on the device
- Some camera-specific features may not be available on all devices
- iOS support is not available (iOS has restrictions on USB camera access)

## Example App

Check out the [example](example/) directory for a complete working app that demonstrates all features.

## Troubleshooting

### Camera not detected
- Ensure your device supports USB OTG
- Check that the USB camera is UVC compatible
- Verify USB permissions are granted
- Try reconnecting the camera

### Permission errors
- Make sure all required permissions are added to AndroidManifest.xml
- Request runtime permissions for Android 6.0+

### Build errors
- Ensure minSdkVersion is at least 24
- Run `flutter clean` and rebuild

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Credits

This plugin uses the following open-source libraries:

- [AndroidUSBCamera](https://github.com/jiangdongguo/AndroidUSBCamera) by jiangdg
- libUVC - USB Video Class library
- libjpeg-turbo - JPEG encoding/decoding
- libusb - USB device access

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Author

Developed with ❤️ for the Flutter community.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.

## Support

If you find this plugin helpful, please give it a ⭐️ on GitHub!

For bugs and feature requests, please file an issue on the [GitHub repository](https://github.com/teamtechackers/create_new_camara_plugin/issues).
