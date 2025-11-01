# How to Use Full Camera Features in Your Project

## 🎯 Goal
You want to click a button in **test_1** (your project) and get the **full camera UI** from example app!

## ✅ **Solution: 2-Step Integration**

### Step 1: Add Plugin to Your Project

In your `test_1/pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Add USB Camera Plugin
  usb_camera_plugin:
    path: ../camera_pluging_flutter_v1
```

Run: `flutter pub get`

---

### Step 2: Copy Example Activities to Your Project

Copy camera activities from example to test_1:

#### A. Copy Kotlin Files

```bash
# From example to test_1
cp -r camera_pluging_flutter_v1/example/android/app/src/main/kotlin/jiangdg \
      test_1/android/app/src/main/kotlin/
```

#### B. Copy Resources

```bash
# Copy layouts
cp -r camera_pluging_flutter_v1/example/android/app/src/main/res/layout/* \
      test_1/android/app/src/main/res/layout/

# Copy drawables  
cp -r camera_pluging_flutter_v1/example/android/app/src/main/res/drawable/* \
      test_1/android/app/src/main/res/drawable/

# Copy values
cp -r camera_pluging_flutter_v1/example/android/app/src/main/res/values/* \
      test_1/android/app/src/main/res/values/

# Copy mipmaps (icons)
cp -r camera_pluging_flutter_v1/example/android/app/src/main/res/mipmap-xhdpi/* \
      test_1/android/app/src/main/res/mipmap-xhdpi/

# Copy animations
cp -r camera_pluging_flutter_v1/example/android/app/src/main/res/anim/* \
      test_1/android/app/src/main/res/anim/
```

#### C. Update test_1 build.gradle

Add to `test_1/android/app/build.gradle`:

```gradle
android {
    compileSdk 34
    ndkVersion "27.0.12077973"
    
    defaultConfig {
        minSdk 24
        targetSdk 34
        multiDexEnabled true
    }
    
    buildFeatures {
        viewBinding true
        dataBinding true
    }
}

dependencies {
    // Existing dependencies...
    
    // Camera UI dependencies
    implementation 'com.afollestad.material-dialogs:core:3.2.1'
    implementation 'com.geyifeng.immersionbar:immersionbar:3.2.2'
    implementation 'com.github.bumptech.glide:glide:4.10.0'
    implementation 'com.github.bumptech.glide:okhttp3-integration:4.10.0'
    implementation 'com.tencent:mmkv:1.2.12'
    implementation 'androidx.lifecycle:lifecycle-viewmodel-ktx:2.2.0'
    implementation 'androidx.lifecycle:lifecycle-livedata-ktx:2.2.0'
    implementation 'androidx.lifecycle:lifecycle-runtime-ktx:2.2.0'
    implementation 'com.github.CymChad:BaseRecyclerViewAdapterHelper:2.9.50'
    implementation 'androidx.multidex:multidex:2.0.1'
    implementation 'org.jetbrains.kotlinx:kotlinx-coroutines-android:1.3.9'
    implementation 'com.github.zjupure:webpdecoder:2.7.4.16.0'
    implementation 'com.tencent.bugly:crashreport:4.1.9.3'
    implementation 'com.tencent.bugly:nativecrashreport:3.9.0'
}
```

#### D. Update AndroidManifest

Add to `test_1/android/app/src/main/AndroidManifest.xml`:

```xml
<manifest>
    <application>
        
        <!-- Your existing MainActivity -->
        <activity android:name=".MainActivity" .../>
        
        <!-- ADD THIS: Full Camera Activity -->
        <activity
            android:name="com.jiangdg.demo.MainActivity"
            android:exported="false"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize"
            android:screenOrientation="portrait"
            android:theme="@style/Theme.AppCompat.Light.NoActionBar"
            android:launchMode="singleTask" />
            
        <activity
            android:name="com.jiangdg.demo.SplashActivity"
            android:exported="false" />
            
    </application>
</manifest>
```

---

### Step 3: Use in Your Flutter Code

In `test_1/lib/main.dart`:

```dart
import 'package:usb_camera_plugin/usb_camera_plugin.dart';

// In your widget
final _usbCameraPlugin = UsbCameraPlugin();

ElevatedButton(
  onPressed: () async {
    // This will now open FULL camera UI!
    await _usbCameraPlugin.openCamera();
  },
  child: Text('Open Camera'),
)
```

**Done!** Ab test_1 mein button dabane par full camera UI khulega! 🎉

---

## 🚀 Alternative: Quick Script

Main ek script bana deta hoon jo automatically sab kuch setup kar de:

```bash
#!/bin/bash
# setup_camera_in_test1.sh

SOURCE_DIR="camera_pluging_flutter_v1/example/android/app/src/main"
TARGET_DIR="test_1/android/app/src/main"

echo "Setting up USB Camera in test_1..."

# Copy Kotlin files
cp -r $SOURCE_DIR/kotlin/jiangdg $TARGET_DIR/kotlin/

# Copy resources
cp -r $SOURCE_DIR/res/layout/* $TARGET_DIR/res/layout/ 2>/dev/null
cp -r $SOURCE_DIR/res/drawable/* $TARGET_DIR/res/drawable/ 2>/dev/null
cp -r $SOURCE_DIR/res/values/* $TARGET_DIR/res/values/ 2>/dev/null
cp -r $SOURCE_DIR/res/mipmap-xhdpi/* $TARGET_DIR/res/mipmap-xhdpi/ 2>/dev/null
cp -r $SOURCE_DIR/res/anim/* $TARGET_DIR/res/anim/ 2>/dev/null

echo "✅ Files copied!"
echo "Now:"
echo "1. Add dependencies to test_1/android/app/build.gradle"
echo "2. Add MainActivity to AndroidManifest"
echo "3. Run: flutter pub get"
echo "4. Run: flutter run"
```

---

## 📊 Final Result

```
test_1 (Your Project)
  ├── Button Click
  ├── Plugin Call
  └── ✅ Full Camera UI Opens!
       ├── USB Detection
       ├── Video Recording
       ├── Photo Capture
       ├── Effects
       └── All Features!
```

**Your project stays separate, camera functionality integrated!** 💪

