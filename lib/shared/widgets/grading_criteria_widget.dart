import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GradingCriteriaWidget extends StatelessWidget {
  final bool isDialog;
  const GradingCriteriaWidget({Key? key, this.isDialog = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isDialog ? 0 : 2,
      margin: isDialog ? EdgeInsets.zero : const EdgeInsets.all(0),
      child: Padding(
        padding: isDialog
            ? const EdgeInsets.all(4.0)
            : const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.grade,
                  color: AppTheme.primaryColor,
                  size: isDialog ? 20 : 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Grading Criteria',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                    fontSize: isDialog ? 16 : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Grade distribution based on G3 score:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                fontSize: isDialog ? 13 : null,
              ),
            ),
            const SizedBox(height: 8),
            _buildGradeRow('A+', '≥ 18', const Color(0xFF4CAF50), isDialog),
            _buildGradeRow('A', '≥ 15', const Color(0xFF8BC34A), isDialog),
            _buildGradeRow('B', '≥ 12', const Color(0xFFFFC107), isDialog),
            _buildGradeRow('C', '≥ 9', const Color(0xFFFF9800), isDialog),
            _buildGradeRow('F', '< 9', const Color(0xFFF44336), isDialog),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeRow(
    String grade,
    String score,
    Color color,
    bool isDialog,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Container(
            width: isDialog ? 32 : 40,
            height: isDialog ? 20 : 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                grade,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isDialog ? 10 : 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            score,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: isDialog ? 12 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
