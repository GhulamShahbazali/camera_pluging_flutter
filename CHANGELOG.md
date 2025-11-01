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
