// lib/core/api/models/analysis_detail.dart

// ignore_for_file: sort_constructors_first, document_ignores, eol_at_end_of_file

class AnalysisDetail {
  final String? name;
  final double? value;

  AnalysisDetail({this.name, this.value});

  factory AnalysisDetail.fromJson(Map<String, dynamic> json) {
    return AnalysisDetail(
      name: json['name'] as String?,
      value: (json['value'] as num?)?.toDouble(),
    );
  }
}
