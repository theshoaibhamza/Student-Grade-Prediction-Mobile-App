import 'dart:convert';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../models/prediction_result_model.dart';
import '../models/student_data_model.dart';

abstract class PredictionRemoteDataSource {
  Future<PredictionResultModel> predictGrade(StudentDataModel studentData);
}

class PredictionRemoteDataSourceImpl implements PredictionRemoteDataSource {
  final DioClient dioClient;

  PredictionRemoteDataSourceImpl(this.dioClient);

  @override
  Future<PredictionResultModel> predictGrade(
    StudentDataModel studentData,
  ) async {
    try {
      final response = await dioClient.dio.post(
        AppConstants.predictEndpoint,
        data: jsonEncode(studentData.toJson()),
      );

      if (response.statusCode == 200) {
        return PredictionResultModel.fromJson(response.data);
      } else {
        throw ServerFailure(AppConstants.serverError);
      }
    } catch (e) {
      if (e is ServerFailure) {
        rethrow;
      }
      throw NetworkFailure(AppConstants.networkError);
    }
  }
}
