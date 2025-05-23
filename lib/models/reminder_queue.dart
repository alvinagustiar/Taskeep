import 'package:freezed_annotation/freezed_annotation.dart';
import 'task.dart';

part 'reminder_queue.freezed.dart';
part 'reminder_queue.g.dart';

@freezed
class ReminderItem with _$ReminderItem {
  const factory ReminderItem({
    required String id,
    required DateTime dueDate,
    required String taskId,
    required String taskTitle,
    @Default(false) bool isProcessed,
  }) = _ReminderItem;

  factory ReminderItem.fromJson(Map<String, dynamic> json) =>
      _$ReminderItemFromJson(json);
}

class ReminderQueue {
  final List<ReminderItem> _queue = [];

  void enqueue(ReminderItem item) {
    // Insert based on due date (priority queue)
    int index = 0;
    while (index < _queue.length &&
        _queue[index].dueDate.isBefore(item.dueDate)) {
      index++;
    }
    _queue.insert(index, item);
  }

  ReminderItem? dequeue() {
    if (_queue.isEmpty) return null;
    return _queue.removeAt(0);
  }

  ReminderItem? peek() {
    if (_queue.isEmpty) return null;
    return _queue.first;
  }

  List<ReminderItem> get upcomingReminders {
    final now = DateTime.now();
    return _queue
        .where((item) => !item.isProcessed && item.dueDate.isAfter(now))
        .toList();
  }

  List<ReminderItem> get overdueReminders {
    final now = DateTime.now();
    return _queue
        .where((item) => !item.isProcessed && item.dueDate.isBefore(now))
        .toList();
  }

  bool get isEmpty => _queue.isEmpty;
  int get length => _queue.length;

  void clear() {
    _queue.clear();
  }

  void removeById(String id) {
    _queue.removeWhere((item) => item.id == id);
  }
}
