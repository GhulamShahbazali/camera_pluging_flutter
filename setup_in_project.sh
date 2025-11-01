#!/bin/bash

# USB Camera Plugin - Auto Setup Script
# This script copies camera functionality to your target project

echo "🎥 USB Camera Plugin Setup"
echo "=========================="
echo ""

# Check if target project path is provided
if [ -z "$1" ]; then
    echo "❌ Error: Please provide target project path"
    echo ""
    echo "Usage: ./setup_in_project.sh /path/to/your/project"
    echo "Example: ./setup_in_project.sh /Users/apple/AndroidStudioProjects/test_1"
    exit 1
fi

TARGET_PROJECT="$1"
SOURCE_DIR="$(pwd)/example/android/app/src/main"
TARGET_DIR="$TARGET_PROJECT/android/app/src/main"

# Verify paths exist
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: Source directory not found"
    echo "Please run this script from camera_pluging_flutter_v1 directory"
    exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "❌ Error: Target project not found at: $TARGET_PROJECT"
    exit 1
fi

echo "📂 Source: $SOURCE_DIR"
echo "📂 Target: $TARGET_DIR"
echo ""

# Create directories if they don't exist
mkdir -p "$TARGET_DIR/kotlin/jiangdg"
mkdir -p "$TARGET_DIR/kotlin/com/jiangdg"
mkdir -p "$TARGET_DIR/res/layout"
mkdir -p "$TARGET_DIR/res/drawable"
mkdir -p "$TARGET_DIR/res/values"
mkdir -p "$TARGET_DIR/res/mipmap-xhdpi"
mkdir -p "$TARGET_DIR/res/anim"

echo "📋 Copying camera activity files..."
cp -r "$SOURCE_DIR/kotlin/jiangdg"/* "$TARGET_DIR/kotlin/jiangdg/" 2>/dev/null
echo "✅ Kotlin files copied"

echo "📋 Copying layout resources..."
cp -r "$SOURCE_DIR/res/layout"/* "$TARGET_DIR/res/layout/" 2>/dev/null
echo "✅ Layouts copied"

echo "📋 Copying drawable resources..."
cp -r "$SOURCE_DIR/res/drawable"/* "$TARGET_DIR/res/drawable/" 2>/dev/null
echo "✅ Drawables copied"

echo "📋 Copying value resources..."
cp -r "$SOURCE_DIR/res/values"/* "$TARGET_DIR/res/values/" 2>/dev/null
echo "✅ Values copied"

echo "📋 Copying icon resources..."
cp -r "$SOURCE_DIR/res/mipmap-xhdpi"/* "$TARGET_DIR/res/mipmap-xhdpi/" 2>/dev/null
echo "✅ Icons copied"

echo "📋 Copying animation resources..."
cp -r "$SOURCE_DIR/res/anim"/* "$TARGET_DIR/res/anim/" 2>/dev/null
echo "✅ Animations copied"

echo ""
echo "✅ Setup Complete!"
echo ""
echo "📝 Next Steps:"
echo "============="
echo ""
echo "1️⃣  Add plugin dependency to $TARGET_PROJECT/pubspec.yaml:"
echo "   dependencies:"
echo "     usb_camera_plugin:"
echo "       path: $(pwd)"
echo ""
echo "2️⃣  Add dependencies to $TARGET_PROJECT/android/app/build.gradle:"
echo "   (See HOW_TO_USE_WITH_YOUR_PROJECT.md for list)"
echo ""
echo "3️⃣  Add MainActivity to $TARGET_PROJECT/android/app/src/main/AndroidManifest.xml:"
echo "   <activity android:name=\"com.jiangdg.demo.MainActivity\" .../>"
echo ""
echo "4️⃣  Enable build features in build.gradle:"
echo "   buildFeatures {"
echo "     viewBinding true"
echo "     dataBinding true"
echo "   }"
echo ""
echo "5️⃣  Run commands:"
echo "   cd $TARGET_PROJECT"
echo "   flutter clean"
echo "   flutter pub get"
echo "   flutter run"
echo ""
echo "🎉 Then use: UsbCameraPlugin().openCamera() in your Flutter code!"
echo ""

