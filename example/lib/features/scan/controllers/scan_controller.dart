import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usb_camera_plugin/usb_camera_plugin.dart';


import '../../../core/services/analysis_service.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../../routes/app_pages.dart';

class ScanController extends GetxController with WidgetsBindingObserver {
  final ImagePicker _picker = ImagePicker();
  final AnalysisService _analysisService = AnalysisService();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isLoading = false.obs;
  final _usbCameraPlugin = UsbCameraPlugin();

  static const String _macAddressKey = 'saved_mac_address';

  @override
  void onInit() {
    super.onInit();
    _ensureMacAddress();
    _initPlatformState();
    // Add lifecycle observer to detect when camera closes
    WidgetsBinding.instance.addObserver(this);
  }
  
  @override
  void onClose() {
    // Remove lifecycle observer
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When app resumes (comes back from camera)
    if (state == AppLifecycleState.resumed) {
      _checkForCapturedImage();
    }
  }
  
  Future<void> _checkForCapturedImage() async {
    try {
      final imagePath = await _usbCameraPlugin.getLastCapturedImage();
      if (imagePath != null && imagePath.isNotEmpty) {
        // ✅ Image captured from camera!
        selectedImage.value = File(imagePath);
        if (kDebugMode) {
          print('✅ Image captured: $imagePath');
        }
        // Image will show automatically in your UI via Obx
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting captured image: $e');
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
        final status = await Permission.photos.status;
        if (status.isDenied) {
          final result = await Permission.photos.request();
          return result.isGranted;
        }
        return status.isGranted;
      } catch (e) {
        log('Photos permission not available, using image_picker fallback: $e');
        return true;
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

  /// Opens the camera to take a photo
  Future<void> pickImageFromCamera() async {
    try {
      isLoading.value = true;

      // Request permission before accessing camera
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
    //  await pickImageFromGallery();
      _openCamera();
    } else {
      // await pickImageFromCamera();
      _openCamera();
    }
  }
  Future<void> _openCamera() async {
    try {
      await _usbCameraPlugin.openCamera();
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

  /// Clears the selected image
  void clearSelectedImage() {
    selectedImage.value = null;
  }

  /// Encode selected image and send to analysis API
  Future<void> analyzeSelectedImage() async {
    if (selectedImage.value == null) {
      log('Please select an image first');
      return;
    }

    try {
      isLoading.value = true;

      final bytes = await selectedImage.value!.readAsBytes();
      final base64Image = base64Encode(bytes);
      final base64WithPrefix = 'data:image/jpeg;base64,$base64Image';

      final analysisResponse = await _analysisService.analyzeImage(
        imageDataUrl: base64WithPrefix,
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
