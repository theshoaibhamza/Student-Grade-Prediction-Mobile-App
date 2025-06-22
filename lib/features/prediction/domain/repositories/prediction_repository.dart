import '../../../../core/errors/failures.dart';
import '../entities/prediction_result.dart';
import '../entities/student_data.dart';

abstract class PredictionRepository {
  Future<Either<Failure, PredictionResult>> predictGrade(
    StudentData studentData,
  );
}

// Either class for functional programming approach
class Either<L, R> {
  final L? left;
  final R? right;
  final bool isLeft;

  Either._(this.left, this.right, this.isLeft);

  factory Either.left(L value) => Either._(value, null, true);
  factory Either.right(R value) => Either._(null, value, false);

  T fold<T>(T Function(L) onLeft, T Function(R) onRight) {
    if (isLeft) {
      return onLeft(left!);
    } else {
      return onRight(right!);
    }
  }

  bool get isRight => !isLeft;
}
