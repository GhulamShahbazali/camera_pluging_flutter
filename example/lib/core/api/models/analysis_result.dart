// // lib/core/api/models/analysis_result.dart
// // ignore_for_file: sort_constructors_first, eol_at_end_of_file
//
//
//
// import 'analysis_detail.dart';
//
// class AnalysisResult {
//   final AnalysisDetail? skinColor;
//   final AnalysisDetail? hairColor;
//   final AnalysisDetail? hairThickness;
//   final int? folliclesDetected;
//
//   // --- ADD THIS LINE ---
//   final String? annotatedImage;
//
//   AnalysisResult({
//     this.skinColor,
//     this.hairColor,
//     this.hairThickness,
//     this.folliclesDetected,
//     this.annotatedImage, // --- ADD THIS LINE ---
//   });
//
//   factory AnalysisResult.fromJson(Map<String, dynamic> json) {
//     return AnalysisResult(
//       skinColor: json['skinColor'] != null
//           ? AnalysisDetail.fromJson(json['skinColor'] as Map<String, dynamic>)
//           : null,
//       hairColor: json['hairColor'] != null
//           ? AnalysisDetail.fromJson(json['hairColor'] as Map<String, dynamic>)
//           : null,
//       hairThickness: json['hairThickness'] != null
//           ? AnalysisDetail.fromJson(
//               json['hairThickness'] as Map<String, dynamic>,
//             )
//           : null,
//       folliclesDetected: json['folliclesDetected'] as int?,
//
//       // --- ADD THIS LINE ---
//       annotatedImage: json['annotatedImage'] as String?,
//     );
//   }
// }


// lib/core/api/models/analysis_result.dart
// ignore_for_file: sort_constructors_first, eol_at_end_of_file


import 'analysis_detail.dart';

class AnalysisResult {
  final AnalysisDetail? skinColor;
  final AnalysisDetail? hairColor;
  final AnalysisDetail? hairThickness;
  final int? folliclesDetected;

  // --- ADD THIS LINE ---
  final String? annotatedImage;

  AnalysisResult({
    this.skinColor,
    this.hairColor,
    this.hairThickness,
    this.folliclesDetected,
    this.annotatedImage, // --- ADD THIS LINE ---
  });

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    return AnalysisResult(
      skinColor: json['skinColor'] != null
          ? AnalysisDetail.fromJson(json['skinColor'] as Map<String, dynamic>)
          : null,
      hairColor: json['hairColor'] != null
          ? AnalysisDetail.fromJson(json['hairColor'] as Map<String, dynamic>)
          : null,
      hairThickness: json['hairThickness'] != null
          ? AnalysisDetail.fromJson(
        json['hairThickness'] as Map<String, dynamic>,
      )
          : null,
      folliclesDetected: json['folliclesDetected'] as int?,

      // --- ADD THIS LINE ---
      annotatedImage: json['annotatedImage'] as String?,
    );
  }
}
