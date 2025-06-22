class PredictionResult {
  final double predictedG3;
  final String grade;
  final bool passed;

  const PredictionResult({
    required this.predictedG3,
    required this.grade,
    required this.passed,
  });

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(
      predictedG3: (json['predicted_g3'] as num).toDouble(),
      grade: json['grade'] as String,
      passed: json['passed'] as bool,
    );
  }
}
