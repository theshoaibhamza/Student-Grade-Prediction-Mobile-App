class StudentData {
  final int? health;
  final String? activities;
  final String? reason;
  final int age;
  final int absences;
  final int g2;

  const StudentData({
    this.health,
    this.activities,
    this.reason,
    required this.age,
    required this.absences,
    required this.g2,
  });

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
