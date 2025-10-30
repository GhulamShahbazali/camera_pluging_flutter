import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'usb_camera_plugin_platform_interface.dart';

class MethodChannelUsbCameraPlugin extends UsbCameraPluginPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('usb_camera_plugin');

  @override
  Future<void> openCamera() async {
    await methodChannel.invokeMethod<void>('openCamera');
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
