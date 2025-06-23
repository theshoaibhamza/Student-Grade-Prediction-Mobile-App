import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'core/network/dio_client.dart';
import 'shared/theme/app_theme.dart';
import 'features/prediction/data/datasources/prediction_remote_data_source.dart';
import 'features/prediction/data/repositories/prediction_repository_impl.dart';
import 'features/prediction/domain/usecases/predict_grade_usecase.dart';
import 'features/prediction/presentation/providers/prediction_provider.dart';
import 'features/prediction/presentation/screens/prediction_screen.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

void main() {
  runApp(const StudentPredictorApp());
}

class StudentPredictorApp extends StatelessWidget {
  const StudentPredictorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Core dependencies
        Provider<DioClient>(create: (context) => DioClient()),

        // Data sources
        Provider<PredictionRemoteDataSource>(
          create: (context) =>
              PredictionRemoteDataSourceImpl(context.read<DioClient>()),
        ),

        // Repositories
        Provider<PredictionRepositoryImpl>(
          create: (context) => PredictionRepositoryImpl(
            context.read<PredictionRemoteDataSource>(),
          ),
        ),
        // Use cases
        Provider<PredictGradeUseCase>(
          create: (context) =>
              PredictGradeUseCase(context.read<PredictionRepositoryImpl>()),
        ),

        // Providers
        ChangeNotifierProvider<PredictionProvider>(
          create: (context) =>
              PredictionProvider(context.read<PredictGradeUseCase>()),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const PredictionScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// main file