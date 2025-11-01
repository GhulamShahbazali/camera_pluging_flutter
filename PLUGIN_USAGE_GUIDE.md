# 🚀 USB Camera Plugin - Usage in ANY Project

## ✅ **Ye Plugin Doosre Projects Mein Kaam Karega!**

---

## 📦 **Step 1: Plugin Add Karo**

Apne **naye project** ki `pubspec.yaml` mein:

```yaml
dependencies:
  flutter:
    sdk: flutter
    
  # USB Camera Plugin
  usb_camera_plugin:
    git:
      url: https://github.com/GhulamShahbazali/camera_pluging_flutter.git
      ref: main
```

Phir:
```bash
flutter pub get
```

---

## ⚙️ **Step 2: Android Configuration**

### A. Update `android/app/build.gradle`:

```gradle
android {
    compileSdk 34
    ndkVersion "27.0.12077973"
    
    defaultConfig {
        minSdk 24  // Important!
        targetSdk 34
        multiDexEnabled true
    }
    
    buildFeatures {
        viewBinding true
        dataBinding true
    }
}
```

### B. Update `android/build.gradle`:

```gradle
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url "https://jitpack.io" }  // Add this
    }
}
```

### C. Update `AndroidManifest.xml`:

Add permissions (plugin already includes them, but for clarity):

```xml
<manifest>
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-feature android:name="android.hardware.usb.host" />
    
    <application>
        <!-- Your activities -->
    </application>
</manifest>
```

---

## 📱 **Step 3: Flutter Code**

```dart
import 'package:flutter/material.dart';
import 'package:usb_camera_plugin/usb_camera_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _usbCamera = UsbCameraPlugin();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('USB Camera Test')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                await _usbCamera.openCamera();
              } catch (e) {
                print('Error: $e');
              }
            },
            child: Text('Open Camera'),
          ),
        ),
      ),
    );
  }
}
```

---

## 🚀 **Step 4: Run Karo!**

```bash
flutter clean
flutter pub get
flutter run
```

---

## 🎯 **Kya Milega:**

Button click karne par:
- ✅ USB Camera detection
- ✅ Video recording
- ✅ Photo capture
- ✅ Effects & filters
- ✅ Settings panel
- ✅ Full camera UI

---

## 🐛 **Troubleshooting:**

### Error: "minSdk must be 24"
**Fix:** `android/app/build.gradle` mein `minSdk 24` set karo

### Error: "NDK version mismatch"
**Fix:** `ndkVersion = "27.0.12077973"` add karo

### Error: "JitPack repository not found"
**Fix:** `android/build.gradle` mein `maven { url "https://jitpack.io" }` add karo

### Error: "MultiDex issue"
**Fix:** `multiDexEnabled true` add karo `defaultConfig` mein

---

## ✅ **Final Checklist:**

- [ ] Plugin added to pubspec.yaml
- [ ] `minSdk 24` set
- [ ] `ndkVersion` set
- [ ] JitPack repository added
- [ ] MultiDex enabled
- [ ] ViewBinding/DataBinding enabled
- [ ] `flutter pub get` run kiya
- [ ] `flutter clean` kiya

---

## 🎉 **Result:**

**Your project + Plugin = Full USB Camera App!**

Kisi bhi project mein use karo - same features milenge! 💪

