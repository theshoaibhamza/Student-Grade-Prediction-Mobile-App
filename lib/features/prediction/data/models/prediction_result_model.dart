import '../../domain/entities/prediction_result.dart';

class PredictionResultModel extends PredictionResult {
  const PredictionResultModel({
    required super.predictedG3,
    required super.grade,
    required super.passed,
  });

  factory PredictionResultModel.fromJson(Map<String, dynamic> json) {
    return PredictionResultModel(
      predictedG3: (json['predicted_g3'] as num).toDouble(),
      grade: json['grade'] as String,
      passed: json['passed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'predicted_g3': predictedG3, 'grade': grade, 'passed': passed};
  }
}
