import 'package:flutter/material.dart';
import '../../domain/entities/prediction_result.dart';
import '../../domain/entities/student_data.dart';
import '../../domain/usecases/predict_grade_usecase.dart';

enum PredictionState { initial, loading, success, error }

class PredictionProvider extends ChangeNotifier {
  final PredictGradeUseCase predictGradeUseCase;

  PredictionProvider(this.predictGradeUseCase);

  PredictionState _state = PredictionState.initial;
  PredictionResult? _result;
  String? _errorMessage;

  PredictionState get state => _state;
  PredictionResult? get result => _result;
  String? get errorMessage => _errorMessage;

  Future<void> predictGrade(StudentData studentData) async {
    _setState(PredictionState.loading);
    _errorMessage = null;

    try {
      final either = await predictGradeUseCase(studentData);

      either.fold(
        (failure) {
          _errorMessage = failure.message;
          _setState(PredictionState.error);
        },
        (result) {
          _result = result;
          _setState(PredictionState.success);
        },
      );
    } catch (e) {
      _errorMessage = e.toString();
      _setState(PredictionState.error);
    }
  }

  void reset() {
    _state = PredictionState.initial;
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }

  void _setState(PredictionState newState) {
    _state = newState;
    notifyListeners();
  }
}
