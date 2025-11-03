import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'usb_camera_plugin_method_channel.dart';

abstract class UsbCameraPluginPlatform extends PlatformInterface {
  UsbCameraPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static UsbCameraPluginPlatform _instance = MethodChannelUsbCameraPlugin();

  static UsbCameraPluginPlatform get instance => _instance;

  static set instance(UsbCameraPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> openCamera() {
    throw UnimplementedError('openCamera() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }
  
  Future<String?> getLastCapturedImage() {
    throw UnimplementedError('getLastCapturedImage() has not been implemented.');
  }
}
