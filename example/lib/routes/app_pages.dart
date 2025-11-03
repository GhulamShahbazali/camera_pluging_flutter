import 'package:get/get.dart';


import '../core/api/models/analysis_response.dart';
import '../features/body_area/presentation/body_area_home.dart';
import '../features/captured_image/captured_image_screen.dart';
import '../features/result/presentation/result_page.dart';
import '../features/scan/presentaion/scan_page.dart';
import '../features/setting/presentation/setting_page.dart';
import '../features/splash/presentation/splash_screen.dart';

class AppPages {
  static const initial = '/splash';
  static const scanPage = '/scanPage';
  static const settingPage = '/setting';
  static const bodyAreaHome = '/body-area-home';
  static const resultPage = '/result-page';
  static const capturedImagePage = '/captured-image';

  static final routes = [
    GetPage(name: scanPage, page: () => const ScanPage()),
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(
      name: resultPage,
      page: () {
        final analysisResponse = Get.arguments is AnalysisResponse
            ? Get.arguments as AnalysisResponse
            : throw ArgumentError('AnalysisResponse is required');
        return ResultPage(analysisResponse: analysisResponse);
      },
    ),
    GetPage(
      name: capturedImagePage,
      page: () {
        final imagePath = Get.arguments as String;
        return CapturedImageScreen(imagePath: imagePath);
      },
    ),
    GetPage(name: settingPage, page: () => const SettingPage()),
    GetPage(name: bodyAreaHome, page: () => const BodyAreaHome()),
  ];
}
