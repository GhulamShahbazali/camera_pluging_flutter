import 'usb_camera_plugin_platform_interface.dart';

class UsbCameraPlugin {
  Future<void> openCamera() {
    return UsbCameraPluginPlatform.instance.openCamera();
  }

  Future<String?> getPlatformVersion() {
    return UsbCameraPluginPlatform.instance.getPlatformVersion();
  }
}
