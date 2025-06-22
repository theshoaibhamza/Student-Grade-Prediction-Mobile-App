class AppConstants {
  static const String appName = 'Student Performance Predictor';
  static const String baseUrl = 'https://web-production-4baa4.up.railway.app';
  static const String predictEndpoint = '/predict';

  // API Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Form Validation Messages
  static const String requiredField = 'This field is required';
  static const String invalidAge = 'Please enter a valid age';
  static const String invalidAbsences =
      'Please enter a valid number of absences';
  static const String invalidG2 = 'Please enter a valid G2 score';

  // Success Messages
  static const String predictionSuccess = 'Prediction completed successfully';

  // Error Messages
  static const String networkError =
      'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'An unknown error occurred.';
  static const String predictionFailed = 'Failed to get prediction.';

  // Grading Criteria
  static const String gradingCriteriaTitle = 'Grading Criteria';
  static const String gradingCriteriaDescription =
      'Grade distribution based on G3 score:';

  // Grading thresholds
  static const double gradeAThreshold = 18.0;
  static const double gradeBThreshold = 15.0;
  static const double gradeCThreshold = 12.0;
  static const double gradeDThreshold = 9.0;
}
