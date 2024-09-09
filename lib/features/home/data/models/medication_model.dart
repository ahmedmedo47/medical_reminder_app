class Medication {
  final String name;
  final String dosage;
  final String time; 
  final String id;
  final String frequency;
  final DateTime startDate;
  final bool isCompleted;
  final String type;
  final List<String>? days;

  Medication({
    required this.name,
    required this.dosage,
    required this.time,
    required this.id,
    required this.frequency,
    required this.startDate,
    required this.isCompleted,
    required this.type,
    this.days,
  });

  Medication copyWith({
    String? name,
    String? dosage,
    String? time,
    String? id,
    String? frequency,
    DateTime? startDate,
    bool? isCompleted,
    String? type,
    List<String>? days,
  }) {
    return Medication(
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      time: time ?? this.time,
      id: id ?? this.id,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      isCompleted: isCompleted ?? this.isCompleted,
      type: type ?? this.type,
      days: days ?? this.days,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'time': time,
      'id': id,
      'frequency': frequency,
      'startDate': startDate.toIso8601String(),
      'isCompleted': isCompleted,
      'type': type,
      'days': days,
    };
  }

  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      name: map['name'],
      dosage: map['dosage'],
      time: map['time'],
      id: map['id'],
      frequency: map['frequency'],
      startDate: DateTime.parse(map['startDate']),
      isCompleted: map['isCompleted'] == 1,
      type: map['type'],
      days: List<String>.from(map['days'] ?? []),
    );
  }
}
