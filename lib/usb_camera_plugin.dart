import 'usb_camera_plugin_platform_interface.dart';

class UsbCameraPlugin {
  /// Opens the USB camera interface
  /// 
  /// Note: This functionality requires the full example app with camera activity.
  /// For testing USB camera features, please run the example app:
  /// 
  /// ```bash
  /// cd example
  /// flutter run
  /// ```
  Future<void> openCamera() async {
    try {
      return await UsbCameraPluginPlatform.instance.openCamera();
    } catch (e) {
      throw Exception(
        'USB Camera functionality requires the example app. '
        'The camera activity is only available in the example project. '
        'Please run: cd example && flutter run\n'
        'Error: $e'
      );
    }
  }

  Future<String?> getPlatformVersion() {
    return UsbCameraPluginPlatform.instance.getPlatformVersion();
  }
}
