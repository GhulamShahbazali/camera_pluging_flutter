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

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  usb_camera_plugin: ^0.0.1
```

Then run:

```bash
flutter pub get
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
