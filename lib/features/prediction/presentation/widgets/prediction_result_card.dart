import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../domain/entities/prediction_result.dart';

class PredictionResultCard extends StatelessWidget {
  final PredictionResult result;

  const PredictionResultCard({Key? key, required this.result})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.analytics, color: AppTheme.primaryColor, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Prediction Results',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildResultRow(
              context,
              'Predicted G3 Score',
              '${result.predictedG3.toStringAsFixed(2)}',
              Icons.score,
            ),
            const SizedBox(height: 12),
            _buildResultRow(context, 'Grade', result.grade, Icons.grade),
            const SizedBox(height: 12),
            _buildResultRow(
              context,
              'Status',
              result.passed ? 'Passed' : 'Failed',
              result.passed ? Icons.check_circle : Icons.cancel,
              color: result.passed
                  ? AppTheme.successColor
                  : AppTheme.errorColor,
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: result.passed
                    ? AppTheme.successColor.withValues(alpha: 0.1)
                    : AppTheme.errorColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: result.passed
                      ? AppTheme.successColor
                      : AppTheme.errorColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    result.passed ? Icons.celebration : Icons.warning,
                    color: result.passed
                        ? AppTheme.successColor
                        : AppTheme.errorColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      result.passed
                          ? 'Congratulations! The student is predicted to pass.'
                          : 'The student needs additional support to improve their performance.',
                      style: TextStyle(
                        color: result.passed
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color ?? AppTheme.primaryColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color ?? AppTheme.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
