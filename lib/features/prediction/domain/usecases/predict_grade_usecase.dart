import '../../../../core/errors/failures.dart';
import '../entities/prediction_result.dart';
import '../entities/student_data.dart';
import '../repositories/prediction_repository.dart';

class PredictGradeUseCase {
  final PredictionRepository repository;

  PredictGradeUseCase(this.repository);

  Future<Either<Failure, PredictionResult>> call(
    StudentData studentData,
  ) async {
    return await repository.predictGrade(studentData);
  }
}
