import '../../domain/entities/student_data.dart';

class StudentDataModel extends StudentData {
  const StudentDataModel({
    super.health,
    super.activities,
    super.reason,
    required super.age,
    required super.absences,
    required super.g2,
  });

  factory StudentDataModel.fromJson(Map<String, dynamic> json) {
    return StudentDataModel(
      health: json['health'] as int?,
      activities: json['activities'] as String?,
      reason: json['reason'] as String?,
      age: json['age'] as int,
      absences: json['absences'] as int,
      g2: json['G2'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'health': health,
      'activities': activities,
      'reason': reason,
      'age': age,
      'absences': absences,
      'G2': g2,
    };
  }
}
