import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_dropdown.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/grading_criteria_widget.dart';
import '../../domain/entities/student_data.dart';
import '../providers/prediction_provider.dart';
import '../widgets/prediction_result_card.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _absencesController = TextEditingController();
  final _g2Controller = TextEditingController();

  int? health;
  String? activities;
  String? reason;

  @override
  void dispose() {
    _ageController.dispose();
    _absencesController.dispose();
    _g2Controller.dispose();
    super.dispose();
  }

  void _predict() {
    if (_formKey.currentState!.validate()) {
      final studentData = StudentData(
        health: health,
        activities: activities,
        reason: reason,
        age: int.parse(_ageController.text),
        absences: int.parse(_absencesController.text),
        g2: int.parse(_g2Controller.text),
      );

      context.read<PredictionProvider>().predictGrade(studentData);
    }
  }

  void _reset() {
    context.read<PredictionProvider>().reset();
    _formKey.currentState?.reset();
    setState(() {
      health = null;
      activities = null;
      reason = null;
    });
    _ageController.clear();
    _absencesController.clear();
    _g2Controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
            tooltip: 'Reset Form',
          ),
        ],
      ),
      body: Consumer<PredictionProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Student Information',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                          ),
                          const SizedBox(height: 16),
                          CustomDropdown<int>(
                            label: 'Health (1-5)',
                            value: health,
                            items: [1, 2, 3, 4, 5],
                            onChanged: (val) => setState(() => health = val),
                            validator: (val) =>
                                val == null ? AppConstants.requiredField : null,
                            itemToString: (val) => val.toString(),
                          ),
                          CustomDropdown<String>(
                            label: 'Activities',
                            value: activities,
                            items: ['yes', 'no'],
                            onChanged: (val) =>
                                setState(() => activities = val),
                            validator: (val) =>
                                val == null ? AppConstants.requiredField : null,
                            itemToString: (val) => val,
                          ),
                          CustomDropdown<String>(
                            label: 'Reason',
                            value: reason,
                            items: ['home', 'course', 'other', 'reputation'],
                            onChanged: (val) => setState(() => reason = val),
                            validator: (val) =>
                                val == null ? AppConstants.requiredField : null,
                            itemToString: (val) => val,
                          ),
                          CustomTextField(
                            label: 'Age',
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return AppConstants.requiredField;
                              }
                              final age = int.tryParse(val);
                              if (age == null || age < 15 || age > 25) {
                                return AppConstants.invalidAge;
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            label: 'Absences',
                            controller: _absencesController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return AppConstants.requiredField;
                              }
                              final absences = int.tryParse(val);
                              if (absences == null || absences < 0) {
                                return AppConstants.invalidAbsences;
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            label: 'G2 Score',
                            controller: _g2Controller,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return AppConstants.requiredField;
                              }
                              final g2 = int.tryParse(val);
                              if (g2 == null || g2 < 0 || g2 > 20) {
                                return AppConstants.invalidG2;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  provider.state == PredictionState.loading
                                  ? null
                                  : _predict,
                              child: provider.state == PredictionState.loading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                  : const Text('Predict Grade'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (provider.state == PredictionState.success) ...[
                  TextButton.icon(
                    onPressed: () => _showGradingCriteriaDialog(context),
                    icon: const Icon(Icons.info_outline, size: 16),
                    label: const Text('Check Grading Criteria'),
                  ),
                  const SizedBox(height: 16),
                ],
                _buildResultSection(provider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultSection(PredictionProvider provider) {
    switch (provider.state) {
      case PredictionState.loading:
        return const LoadingWidget(message: 'Analyzing student data...');
      case PredictionState.success:
        return PredictionResultCard(result: provider.result!);
      case PredictionState.error:
        return _buildErrorWidget(
          provider.errorMessage ?? AppConstants.unknownError,
        );
      case PredictionState.initial:
        return const SizedBox.shrink();
    }
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _predict,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _showGradingCriteriaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: GradingCriteriaWidget(isDialog: true),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
