# USB Camera Plugin - Usage Guide

## 🎯 Two Ways to Use the Plugin

### Option 1: Quick Start (Basic UI) ⚡

Works immediately in any project - no configuration needed!

```dart
import 'package:usb_camera_plugin/usb_camera_plugin.dart';

final plugin = UsbCameraPlugin();
await plugin.openCamera(); // Shows simple blue screen confirming plugin works
```

This launches the **CameraActivity** which shows a blue screen with plugin status.

---

### Option 2: Full Camera Features 🚀

To get the complete camera UI with recording, capture, and effects:

#### Step 1: Update Your AndroidManifest

Add to `/android/app/src/main/AndroidManifest.xml`:

```xml
<manifest>
    <!-- Add inside <application> tag -->
    <application>
        
        <!-- Your existing activities -->
        
        <!-- Add this for full camera features -->
        <activity
            android:name="com.jiangdg.demo.MainActivity"
            android:exported="false"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize"
            android:screenOrientation="portrait"
            android:theme="@style/Theme.AppCompat.Light.NoActionBar"
            android:launchMode="singleTask" />
            
    </application>
</manifest>
```

#### Step 2: Use in Your Flutter Code

```dart
import 'package:usb_camera_plugin/usb_camera_plugin.dart';

final plugin = UsbCameraPlugin();
await plugin.openCamera(); // Now launches full camera UI!
```

---

## 📱 What You Get with Full Features

- ✅ **USB Camera Detection** - Automatic device discovery
- ✅ **Real-time Preview** - Multiple resolution support  
- ✅ **Video Recording** - H.264/MP4 format
- ✅ **Photo Capture** - High-quality images
- ✅ **Effects** - Black & White, Soul, Zoom
- ✅ **Audio Recording** - AAC audio
- ✅ **Settings & Controls** - Brightness, contrast, etc.
- ✅ **Multi-camera Support** - Switch between cameras

---

## 🔧 Example: Complete AndroidManifest

For `test_1/android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    
    <application
        android:name="${applicationName}"
        android:label="test_1"
        android:icon="@mipmap/ic_launcher">
        
        <!-- Your main Flutter activity -->
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        
        <!-- ADD THIS: Full USB Camera Features -->
        <activity
            android:name="com.jiangdg.demo.MainActivity"
            android:exported="false"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize"
            android:screenOrientation="portrait"
            android:theme="@style/Theme.AppCompat.Light.NoActionBar"
            android:launchMode="singleTask" />
        
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>
```

---

## ⚙️ Build Configuration

Make sure your `android/app/build.gradle` has:

```gradle
android {
    compileSdk 34
    ndkVersion "27.0.12077973"
    
    defaultConfig {
        minSdk 24  // Important!
        targetSdk 34
    }
}
```

---

## 🎯 Summary

| Setup | Result |
|-------|--------|
| No config | Basic blue screen (plugin working confirmation) |
| With MainActivity in manifest | **Full camera UI with all features!** |

**Recommendation**: Add MainActivity to your AndroidManifest for full features! 🚀

---

## 🐛 Troubleshooting

**Error: "Activity not found"**
- Make sure you added MainActivity to your AndroidManifest

**Error: "minSdkVersion must be 24"**
- Update your `build.gradle` to use minSdk 24

**Manifest merge conflict**
- Don't declare MainActivity in multiple places
- Plugin already provides the class, just declare it in your app's manifest

---

## 📞 Support

For issues, check the [GitHub repository](https://github.com/teamtechackers/create_new_camara_plugin/issues)

