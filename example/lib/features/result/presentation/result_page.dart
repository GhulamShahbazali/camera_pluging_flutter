// ignore_for_file: prefer_single_quotes, document_ignores, prefer_int_literals, eol_at_end_of_file

import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_pages.dart';
import '../controller/result_controller.dart';
import '../../../core/widgets/ultrascan4d.dart';
import '../../../core/widgets/setting_icon.dart';
import '../../body_area/widget/text_button.dart';
import '../../../core/constants/ui/app_colors.dart';
import '../../../core/api/models/analysis_response.dart';
import '../../../core/constants/ui/app_text_styles.dart';
import '../../../core/widgets/background_container.dart';

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
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 18),
                  child: SettingIconWidget(),
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

              // Display Annotated Image with error handling
              if (controller.analysisResponse.analysis?.annotatedImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        base64Decode(
                          controller.analysisResponse.analysis!.annotatedImage!
                              .split(',')
                              .last,
                        ),
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Text(
                                "Failed to load image",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text("No detection image available"),
                    ),
                  ),
                ),
              // Text('analysis_summary'.tr, style: AppTextStyles.heading4),

              // Obx(
              //   () => Padding(
              //     padding: const EdgeInsets.all(20),
              //     child: Text(
              //       controller.resultLink.value,
              //       style: AppTextStyles.body2,
              //     ),
              //   ),
              // ),
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
                      const SizedBox(height: 4),

                      const SizedBox(height: 4),
                      if (controller.analysisResponse.analysis!.hairColor !=
                          null)
                        Text(
                          'hair_color'.trParams({
                            'category':
                                '${controller.analysisResponse.analysis!.hairColor!.name}',
                            'value':
                                '${controller.analysisResponse.analysis!.hairColor!.value?.toStringAsFixed(1)}',
                          }),
                          style: AppTextStyles.body2,
                        ),
                      if (controller.analysisResponse.analysis!.hairThickness !=
                          null)
                        Text(
                          'hair_thickness'.trParams({
                            'category':
                                '${controller.analysisResponse.analysis!.hairThickness!.name}',
                            'value':
                                '${controller.analysisResponse.analysis!.hairThickness!.value?.toStringAsFixed(1)}',
                          }),
                          style: AppTextStyles.body2,
                        ),
                      if (controller.analysisResponse.analysis!.skinColor !=
                          null)
                        Text(
                          'skin_color'.trParams({
                            'category':
                                '${controller.analysisResponse.analysis!.skinColor!.name}',
                            'value':
                                '${controller.analysisResponse.analysis!.skinColor!.value?.toStringAsFixed(1)}',
                          }),
                          style: AppTextStyles.body2,
                        ),
                      const SizedBox(height: 8),
                      Obx(
                        () => Text(
                          controller.submitMessage.value.isEmpty
                              ? 'submitting_result'.tr
                              : controller.submitMessage.value,
                          style: AppTextStyles.body2.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
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
                          Get.offAndToNamed(AppPages.scanPage);
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
