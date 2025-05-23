import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:collection';

part 'reminder.freezed.dart';
part 'reminder.g.dart';

enum ReminderStatus { pending, sent, cancelled }

@freezed
class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    required String taskId,
    required DateTime scheduledFor,
    required String title,
    required String message,
    @Default(ReminderStatus.pending) ReminderStatus status,
    DateTime? sentAt,
  }) = _Reminder;

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);
}

class ReminderQueue {
  final Queue<Reminder> _queue = Queue<Reminder>();
  final Set<String> _processed = {};

  void enqueue(Reminder reminder) {
    if (!_processed.contains(reminder.id)) {
      _queue.add(reminder);
    }
  }

  Reminder? dequeue() {
    if (_queue.isEmpty) return null;
    final reminder = _queue.removeFirst();
    _processed.add(reminder.id);
    return reminder;
  }

  Reminder? peek() {
    return _queue.isEmpty ? null : _queue.first;
  }

  bool get isEmpty => _queue.isEmpty;

  int get size => _queue.length;

  void clear() {
    _queue.clear();
    _processed.clear();
  }

  List<Reminder> getDueReminders(DateTime now) {
    return _queue
        .where(
          (reminder) =>
              reminder.scheduledFor.isBefore(now) &&
              reminder.status == ReminderStatus.pending,
        )
        .toList();
  }

  void removeByTaskId(String taskId) {
    _queue.removeWhere((reminder) => reminder.taskId == taskId);
  }

  List<Reminder> getByTaskId(String taskId) {
    return _queue.where((reminder) => reminder.taskId == taskId).toList();
  }

  bool hasProcessed(String reminderId) {
    return _processed.contains(reminderId);
  }

  void addProcessed(String reminderId) {
    _processed.add(reminderId);
  }
}
