// class AnalysisResponse {
//   AnalysisResponse({
//     required this.success,
//     this.notes,
//     this.analysis,
//     this.timestamp,
//     this.annotatedImage,
//     this.qualityMetrics,
//   });
//
//   factory AnalysisResponse.fromJson(Map<String, dynamic> json) {
//     return AnalysisResponse(
//       analysis: json['analysis'] != null
//           ? Analysis.fromJson(json['analysis'] as Map<String, dynamic>)
//           : null,
//       annotatedImage: json['annotated_image'] as String?,
//       notes: json['notes'] != null
//           ? List<String>.from(json['notes'] as List)
//           : null,
//       qualityMetrics: json['quality_metrics'] != null
//           ? QualityMetrics.fromJson(
//               json['quality_metrics'] as Map<String, dynamic>,
//             )
//           : null,
//       success: json['success'] as bool? ?? false,
//       timestamp: json['timestamp'] as String?,
//     );
//   }
//   final Analysis? analysis;
//   final String? annotatedImage;
//   final List<String>? notes;
//   final QualityMetrics? qualityMetrics;
//   final bool success;
//   final String? timestamp;
//
//   Map<String, dynamic> toJson() {
//     return {
//       'analysis': analysis?.toJson(),
//       'annotated_image': annotatedImage,
//       'notes': notes,
//       'quality_metrics': qualityMetrics?.toJson(),
//       'success': success,
//       'timestamp': timestamp,
//     };
//   }
// }
//
// class Analysis {
//   Analysis({
//     this.skinColor,
//     this.hairColor,
//     this.confidence,
//     this.analysisTime,
//     this.hairThickness,
//     this.folliclesDetected,
//   });
//
//   factory Analysis.fromJson(Map<String, dynamic> json) {
//     return Analysis(
//       analysisTime: json['analysis_time'] as String?,
//       confidence: json['confidence'] as int?,
//       folliclesDetected: json['follicles_detected'] as int?,
//       hairColor: json['hair_color'] != null
//           ? HairColor.fromJson(json['hair_color'] as Map<String, dynamic>)
//           : null,
//       hairThickness: json['hair_thickness'] != null
//           ? HairThickness.fromJson(
//               json['hair_thickness'] as Map<String, dynamic>,
//             )
//           : null,
//       skinColor: json['skin_color'] != null
//           ? SkinColor.fromJson(json['skin_color'] as Map<String, dynamic>)
//           : null,
//     );
//   }
//   final int? confidence;
//   final HairColor? hairColor;
//   final String? analysisTime;
//   final SkinColor? skinColor;
//   final int? folliclesDetected;
//   final HairThickness? hairThickness;
//
//   Map<String, dynamic> toJson() {
//     return {
//       'analysis_time': analysisTime,
//       'confidence': confidence,
//       'follicles_detected': folliclesDetected,
//       'hair_color': hairColor?.toJson(),
//       'hair_thickness': hairThickness?.toJson(),
//       'skin_color': skinColor?.toJson(),
//     };
//   }
// }
//
// class HairColor {
//   HairColor({this.category, this.value});
//
//   factory HairColor.fromJson(Map<String, dynamic> json) {
//     return HairColor(
//       category: json['category'] as String?,
//       value: json['value'] as int?,
//     );
//   }
//   final String? category;
//   final int? value;
//
//   Map<String, dynamic> toJson() {
//     return {'category': category, 'value': value};
//   }
// }
//
// class HairThickness {
//   HairThickness({this.category, this.scale, this.value});
//
//   factory HairThickness.fromJson(Map<String, dynamic> json) {
//     return HairThickness(
//       category: json['category'] as String?,
//       scale: json['scale'] as String?,
//       value: (json['value'] as num?)?.toDouble(),
//     );
//   }
//   final String? scale;
//   final double? value;
//   final String? category;
//
//   Map<String, dynamic> toJson() {
//     return {'category': category, 'scale': scale, 'value': value};
//   }
// }
//
// class SkinColor {
//   SkinColor({this.category, this.value});
//
//   factory SkinColor.fromJson(Map<String, dynamic> json) {
//     return SkinColor(
//       category: json['category'] as String?,
//       value: json['value'] as int?,
//     );
//   }
//   final String? category;
//   final int? value;
//
//   Map<String, dynamic> toJson() {
//     return {'category': category, 'value': value};
//   }
// }
//
// class QualityMetrics {
//   QualityMetrics({
//     this.detectionMethod,
//     this.focusMeasure,
//     this.lightingQuality,
//     this.resolution,
//   });
//
//   factory QualityMetrics.fromJson(Map<String, dynamic> json) {
//     return QualityMetrics(
//       detectionMethod: json['detection_method'] as String?,
//       focusMeasure: (json['focus_measure'] as num?)?.toDouble(),
//       lightingQuality: json['lighting_quality'] as String?,
//       resolution: json['resolution'] as String?,
//     );
//   }
//   final String? detectionMethod;
//   final double? focusMeasure;
//   final String? lightingQuality;
//   final String? resolution;
//
//   Map<String, dynamic> toJson() {
//     return {
//       'detection_method': detectionMethod,
//       'focus_measure': focusMeasure,
//       'lighting_quality': lightingQuality,
//       'resolution': resolution,
//     };
//   }
// }


// ignore_for_file: sort_constructors_first, document_ignores, eol_at_end_of_file


import 'analysis_result.dart';

class AnalysisResponse {
  final AnalysisResult? analysis;

  AnalysisResponse({this.analysis});

  factory AnalysisResponse.fromJson(Map<String, dynamic> json) {
    return AnalysisResponse(
      analysis: json['analysis'] != null
      // --- FIX ---
      // Cast the 'dynamic' type to the type we expect
          ? AnalysisResult.fromJson(json['analysis'] as Map<String, dynamic>)
          : null,
    );
  }
}



