import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../core/api/models/analysis_response.dart';
import '../../../core/constants/app/app_utils.dart';
import '../../../core/constants/ui/app_colors.dart';
import '../../../core/constants/ui/app_text_styles.dart';
import '../../../core/widgets/background_container.dart';
import '../../../core/widgets/setting_icon.dart';
import '../../../core/widgets/ultrascan4d.dart';
import '../../../routes/app_pages.dart';
import '../../body_area/widget/text_button.dart';
import '../controller/result_controller.dart';


class ResultPage extends StatelessWidget {
  const ResultPage({required this.analysisResponse, super.key});
  final AnalysisResponse analysisResponse;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ResultController(analysisResponse: analysisResponse),
    );

    return Scaffold(
      body: BackgroundContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     SettingIconWidget(
                       haveArrowIcon: true,
                       onTap: () {
                         Get.back();
                         Get.back();
                       },
                     ),
                     SettingIconWidget(),

                  ],
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('protocol'.tr, style: AppTextStyles.heading4),
                  Transform.translate(
                    offset: const Offset(0, -8),
                    child: Text(
                      'and_result'.tr,
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.yellowColor,
                      ),
                    ),
                  ),
                  const Ultrascan4d(),
                ],
              ),

              if (controller.analysisResponse.annotatedImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        base64Decode(
                          AppUtils.stripPrefix(
                            controller.analysisResponse.annotatedImage,
                          )!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (controller.analysisResponse.analysis != null) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'analysis_summary'.tr,
                        style: AppTextStyles.heading4,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'confidence_follicles'.trParams({
                          'conf':
                              '${controller.analysisResponse.analysis!.confidence}',
                          'foll':
                              '${controller.analysisResponse.analysis!.folliclesDetected}',
                        }),
                        style: AppTextStyles.body2,
                      ),
                      const SizedBox(height: 4),
                      if (controller.analysisResponse.analysis!.hairColor !=
                          null)
                        Text(
                          'hair_color'.trParams({
                            'category':
                                '${controller.analysisResponse.analysis!.hairColor!.category}',
                            'value':
                                '${controller.analysisResponse.analysis!.hairColor!.value}',
                          }),
                          style: AppTextStyles.body2,
                        ),
                      if (controller.analysisResponse.analysis!.hairThickness !=
                          null)
                        Text(
                          'hair_thickness'.trParams({
                            'category':
                                '${controller.analysisResponse.analysis!.hairThickness!.category}',
                            'value':
                                '${controller.analysisResponse.analysis!.hairThickness!.value}',
                          }),
                          style: AppTextStyles.body2,
                        ),
                      if (controller.analysisResponse.analysis!.skinColor !=
                          null)
                        Text(
                          'skin_color'.trParams({
                            'category':
                                '${controller.analysisResponse.analysis!.skinColor!.category}',
                            'value':
                                '${controller.analysisResponse.analysis!.skinColor!.value}',
                          }),
                          style: AppTextStyles.body2,
                        ),
                      const SizedBox(height: 8),
                      Obx(
                        () => Text(
                          controller.submitMessage.value.isEmpty
                              ? 'submitting_result'.tr
                              : controller.submitMessage.value,
                          style: AppTextStyles.body2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextButton(
                        text: 'back_to_scan'.tr,
                        onTap: () {
                          Get.toNamed(AppPages.scanPage);
                        },
                        paddingHorizontal: 40,
                        paddingVertical: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
