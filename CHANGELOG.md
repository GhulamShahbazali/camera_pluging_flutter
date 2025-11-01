## 0.1.0

* **MAJOR UPDATE**: Plugin now works in ANY Flutter project! 🎉
* Added built-in CameraActivity - no need for example app
* Smart fallback: Uses full features if example app present, basic version otherwise
* Plugin can now be used in test_1, test_2, or any external project
* Added AppCompat dependency for camera activity
* Registered CameraActivity in AndroidManifest
* Ready for production use in external projects

## 0.0.5

* **IMPROVED ERROR HANDLING**: Better error messages when camera activity not found
* Added helpful error message directing users to example app
* Implemented getPlatformVersion method in Android plugin
* Better exception handling in Dart API
* Clear documentation in code about example app requirement

## 0.0.4

* **IMPORTANT**: Simplified plugin structure
* Updated documentation to reflect current architecture limitations
* Plugin now available for testing through example app
* Removed complex source inclusion approach that caused compilation errors
* **Recommendation**: Use the example app for testing USB camera functionality
* Note: Full external project integration requires additional native module packaging work

## 0.0.3

* **CRITICAL FIX**: Fixed "Project with path ':libausbc' could not be found" error
* Changed from project module dependencies to direct source inclusion
* libausbc source code now included directly in the plugin via sourceSets
* Using AAR files for libnative and libuvc instead of project dependencies
* Plugin now works properly when used as a dependency in consumer projects
* No more submodule resolution issues

## 0.0.2

* **CRITICAL FIX**: Fixed gradle build configuration issue
* Removed dependency on rootProject.ext properties that were causing build failures in consumer projects
* All gradle files now use hardcoded values for compatibility
* Fixed error: "Cannot get property 'versionCompiler' on extra properties extension as it does not exist"
* Fixed error: "compileSdkVersion is not specified"

## 0.0.1

* Initial release
* Support for USB cameras on Android devices
* Basic camera operations:
  - Open USB camera interface
  - Get platform version
* Integration with AndroidUSBCamera library (libausbc)
* Support for UVC (USB Video Class) cameras
* Built-in support for:
  - Real-time camera preview
  - Video recording (H.264)
  - Image capture
  - Audio recording (AAC)
  - Visual effects
* Example app demonstrating plugin usage
* Android minSdkVersion: 24
* Android targetSdkVersion: 35
