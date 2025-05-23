enum RecurrenceType { daily, weekly, monthly }

class RecurrencePattern {
  final RecurrenceType type;
  final List<int>? daysOfWeek; // for weekly: 1=Mon,...7=Sun
  final int? dayOfMonth; // for monthly: 1-31

  RecurrencePattern.daily()
    : type = RecurrenceType.daily,
      daysOfWeek = null,
      dayOfMonth = null;

  RecurrencePattern.weekly({required this.daysOfWeek})
    : type = RecurrenceType.weekly,
      dayOfMonth = null;

  RecurrencePattern.monthly({required this.dayOfMonth})
    : type = RecurrenceType.monthly,
      daysOfWeek = null;

  Map<String, dynamic> toJson() => {
    'type': type.toString().split('.').last,
    if (daysOfWeek != null) 'daysOfWeek': daysOfWeek,
    if (dayOfMonth != null) 'dayOfMonth': dayOfMonth,
  };

  factory RecurrencePattern.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String;
    switch (typeStr) {
      case 'daily':
        return RecurrencePattern.daily();
      case 'weekly':
        return RecurrencePattern.weekly(
          daysOfWeek: List<int>.from(json['daysOfWeek']),
        );
      case 'monthly':
        return RecurrencePattern.monthly(dayOfMonth: json['dayOfMonth']);
      default:
        throw ArgumentError('Invalid recurrence type');
    }
  }
}
