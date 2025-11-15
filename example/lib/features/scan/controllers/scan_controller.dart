// ignore_for_file: eol_at_end_of_file, document_ignores

import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:usb_camera_plugin/usb_camera_plugin.dart';

import '../../../core/services/analysis_service.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../../routes/app_pages.dart';

class ScanController extends GetxController  with WidgetsBindingObserver{
  final ImagePicker _picker = ImagePicker();
  final AnalysisService _analysisService = Get.put(AnalysisService());

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isLoading = false.obs;

  static const String _macAddressKey = 'saved_mac_address';
  final _usbCameraPlugin = UsbCameraPlugin();
  @override
  void onInit() {
    super.onInit();
    _initPlatformState();
    _ensureMacAddress();
    WidgetsBinding.instance.addObserver(this as WidgetsBindingObserver);
  }
  @override
  void onClose() {
    // Remove lifecycle observer
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When app resumes (comes back from camera)
    if (state == AppLifecycleState.resumed) {
      _checkForCapturedImage();
    }
  }
  Future<void> _ensureMacAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final mac = prefs.getString(_macAddressKey);
    if (mac == null || mac.isEmpty) {
      showCustomSnackbar(
        title: '',
        message: 'activate_device_before_scanning',
        type: SnackbarType.warning,
      );
      Get.toNamed(AppPages.settingPage);
    }
  }

  Future<bool> requestGalleryPermission() async {
    if (Platform.isAndroid) {
      try {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;

        PermissionStatus status;

        if (sdkInt >= 33) {
          status = await Permission.photos.status;
          if (status.isDenied) {
            final result = await Permission.photos.request();
            return result.isGranted;
          }
        } else {
          status = await Permission.storage.status;
          if (status.isDenied) {
            final result = await Permission.storage.request();
            return result.isGranted;
          }
        }
        return status.isGranted;
      } catch (e) {
        log('Failed to get gallery permission: $e');
        return false;
      }
    } else if (Platform.isIOS) {
      final status = await Permission.photos.status;
      if (status.isDenied) {
        final result = await Permission.photos.request();
        return result.isGranted;
      }
      return status.isGranted;
    }

    return true;
  }

  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isDenied) {
      final result = await Permission.camera.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  Future<void> pickImageFromGallery() async {
    try {
      isLoading.value = true;

      final hasPermission = await requestGalleryPermission();
      if (!hasPermission) {
        showCustomSnackbar(
          title: '',
          message: 'grant_photo_permission',
          type: SnackbarType.warning,
        );
        return;
      }

      final image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      log('Failed to select image: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      isLoading.value = true;

      final hasPermission = await requestCameraPermission();
      if (!hasPermission) {
        showCustomSnackbar(
          title: '',
          message: 'grant_camera_permission',
          type: SnackbarType.warning,
        );
        return;
      }

      final image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
        log('Photo taken successfully');
      }
    } catch (e) {
      log('Failed to take photo: $e');
      showCustomSnackbar(
        title: '',
        message: 'failed_take_photo',
        type: SnackbarType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final prefs = await SharedPreferences.getInstance();
    final mac = prefs.getString(_macAddressKey);
    if (mac == null || mac.isEmpty) {
      showCustomSnackbar(
        title: 'Activation required',
        message: 'Please activate device in settings before scanning',
        type: SnackbarType.warning,
      );
      Get.toNamed(AppPages.settingPage);
      return;
    }

    if (kDebugMode) {
      await pickImageFromGallery();
    } else {
      await pickImageFromGallery();
    }
  }
  Future<void> _checkForCapturedImage() async {
    try {
      if (kDebugMode) {
        print('🔍 Checking for captured image...');
      }

      final imagePath = await _usbCameraPlugin.getLastCapturedImage();

      if (kDebugMode) {
        print('📸 Image path received: $imagePath');
      }

      if (imagePath != null && imagePath.isNotEmpty) {
        // ✅ Image captured from camera!
        final imageFile = File(imagePath);

        if (await imageFile.exists()) {
          if (kDebugMode) {
            print('✅ Image file exists: $imagePath');
            print('✅ File size: ${await imageFile.length()} bytes');
          }

          // ✅ Set image directly - User will click Analyze button manually
          selectedImage.value = imageFile;

          if (kDebugMode) {
            print('✅ Image set to selectedImage - Ready for analysis');
          }
        } else {
          if (kDebugMode) {
            print('❌ Image file does not exist: $imagePath');
          }
        }
      } else {
        if (kDebugMode) {
          print('⚠️ No image path found');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting captured image: $e');
      }
    }
  }






    Future<void> _initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await _usbCameraPlugin.getPlatformVersion() ?? 'Unknown';
    } catch (e) {
      platformVersion = 'Failed: $e';
    }

  }








    Future<void> _openCamera() async {
    try {
      await _usbCameraPlugin.openCamera();

      // Camera opened, now wait for it to close and check for image
      // Check multiple times in case of timing issues
      for (int i = 0; i < 10; i++) {
        await Future.delayed(const Duration(milliseconds: 500));
        await _checkForCapturedImage();
        if (selectedImage.value != null) {
          if (kDebugMode) {
            print('✅ Image loaded after ${(i + 1) * 500}ms');
          }
          break;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  void showImageSourceDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Select Image Source'),
        content: const Text('Choose how you want to select an image'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              pickImageFromCamera();
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              pickImageFromGallery();
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
  }

  void clearSelectedImage() {
    selectedImage.value = null;
  }

  Future<void> analyzeSelectedImage() async {
    if (selectedImage.value == null) {
      log('Please select an image first');
      return;
    }

    try {
      isLoading.value = true;

      // Check if analysis service is ready
      if (_analysisService.isAnalyzerReady.isFalse) {
        showCustomSnackbar(
          title: 'Analyzer Not Ready',
          message: 'The analysis engine is still loading. Please wait.',
          type: SnackbarType.warning,
        );
        return;
      }

      // FIX: Rotate image based on EXIF data to match Python orientation
      final fixedFile = await FlutterExifRotation.rotateImage(
        path: selectedImage.value!.path,
      );

      final analysisResponse = await _analysisService.analyzeImage(
        imageFile: File(fixedFile.path),
      );

      Get.toNamed(AppPages.resultPage, arguments: analysisResponse);
      selectedImage.value = null;
    } catch (e) {
      showCustomSnackbar(
        title: '',
        message: 'failed_analyze_image',
        type: SnackbarType.error,
      );
      log('Failed to analyze image: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
