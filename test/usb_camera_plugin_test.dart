import 'package:flutter_test/flutter_test.dart';
import 'package:usb_camera_plugin/usb_camera_plugin.dart';
import 'package:usb_camera_plugin/usb_camera_plugin_platform_interface.dart';
import 'package:usb_camera_plugin/usb_camera_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUsbCameraPluginPlatform
    with MockPlatformInterfaceMixin
    implements UsbCameraPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final UsbCameraPluginPlatform initialPlatform = UsbCameraPluginPlatform.instance;

  test('$MethodChannelUsbCameraPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUsbCameraPlugin>());
  });

  test('getPlatformVersion', () async {
    UsbCameraPlugin usbCameraPlugin = UsbCameraPlugin();
    MockUsbCameraPluginPlatform fakePlatform = MockUsbCameraPluginPlatform();
    UsbCameraPluginPlatform.instance = fakePlatform;

    expect(await usbCameraPlugin.getPlatformVersion(), '42');
  });
}
