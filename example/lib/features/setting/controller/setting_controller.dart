import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../core/constants/app/app_assets.dart';
import '../../../core/controllers/base_controller.dart';
import '../../../core/services/device_activation_service.dart';

class SettingController extends BaseController {
  static const String _macAddressKey = 'saved_mac_address';

  final DeviceActivationService _activationService = DeviceActivationService();
  final TextEditingController macAddressController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _loadSavedMacAddress();
  }

  @override
  void onClose() {
    macAddressController.dispose();
    super.onClose();
  }

  Future<void> _loadSavedMacAddress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedMacAddress = prefs.getString(_macAddressKey);

      if (savedMacAddress != null && savedMacAddress.isNotEmpty) {
        macAddressController.text = savedMacAddress;
        if (kDebugMode) {
          debugPrint('📱 Loaded saved MAC address: $savedMacAddress');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error loading saved MAC address: $e');
      }
    }
  }

  Future<void> _saveMacAddress(String macAddress) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_macAddressKey, macAddress);
      if (kDebugMode) {
        debugPrint('💾 Saved MAC address: $macAddress');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error saving MAC address: $e');
      }
    }
  }

  Future<void> activateDevice() async {
    try {
      if (formKey.currentState != null && !formKey.currentState!.validate()) {
        return;
      }
      showLoading();

      final macAddress = macAddressController.text.trim();

      final result = await safeApiCall(() async {
        log('api called');
        return _activationService.activateDevice(macAddress: macAddress);
      });

      if (result != null) {
        // Save MAC address to SharedPreferences if activation is allowed
        if (result == ActivationStatus.allowed) {
          await _saveMacAddress(macAddress);
        }
        showActivateDialog(status: result);
      } else {
        showError('Device activation failed. Please try again.');
      }
    } catch (e) {
      handleApiError(e);
      hideLoading();
    } finally {
      hideLoading();
    }
  }

  String? macValidator(String? value) {
    final input = (value ?? '').trim();
    if (input.isEmpty) {
      return 'Please enter a MAC address';
    }
    final macRegex = RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
    if (!macRegex.hasMatch(input)) {
      return 'Invalid MAC address. Use format XX:XX:XX:XX:XX:XX';
    }
    return null;
  }

  void showActivateDialog({required ActivationStatus status}) {
    final size = MediaQuery.of(Get.context!).size;
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent, // keep transparent edges
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(24), // prevents full-screen
        content: Center(
          child: SizedBox(
            height: 300,
            width: size.width * 0.8,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.deviceActivationBg),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, right: 30),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Image.asset(
                              AppAssets.closeIcon,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Image.asset(
                      status == ActivationStatus.denied
                          ? AppAssets.rejectIcon
                          : AppAssets.activateIcon,
                      height: 80,
                    ),
                    Center(
                      child: Text(
                        status == ActivationStatus.denied
                            ? 'device_denied'.tr
                            : 'device_activated'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
