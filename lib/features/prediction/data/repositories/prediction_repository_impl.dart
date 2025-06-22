import '../../../../core/errors/failures.dart';
import '../../domain/entities/prediction_result.dart';
import '../../domain/entities/student_data.dart';
import '../../domain/repositories/prediction_repository.dart';
import '../datasources/prediction_remote_data_source.dart';
import '../models/student_data_model.dart';

class PredictionRepositoryImpl implements PredictionRepository {
  final PredictionRemoteDataSource remoteDataSource;

  PredictionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PredictionResult>> predictGrade(
    StudentData studentData,
  ) async {
    try {
      final studentDataModel = StudentDataModel(
        health: studentData.health,
        activities: studentData.activities,
        reason: studentData.reason,
        age: studentData.age,
        absences: studentData.absences,
        g2: studentData.g2,
      );

      final result = await remoteDataSource.predictGrade(studentDataModel);
      return Either.right(result);
    } on ServerFailure catch (e) {
      return Either.left(e);
    } on NetworkFailure catch (e) {
      return Either.left(e);
    } catch (e) {
      return Either.left(UnknownFailure(e.toString()));
    }
  }
}
