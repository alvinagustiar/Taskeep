import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskPriority {
  high,
  medium,
  low,
}

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String description,
    required DateTime createdAt,
    required DateTime? dueDate,
    @Default(TaskPriority.medium) TaskPriority priority,
    @Default(false) bool isCompleted,
    @Default([]) List<String> tags,
    @Default([]) List<String> attachments,
    @Default([]) List<String> dependencies,
    String? categoryId,
    String? parentTaskId,
    @Default(false) bool isRecurring,
    String? recurrencePattern,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  static List<Task> fromJsonList(List<dynamic> list) {
    return list
        .map((item) => Task.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

@freezed
class SubTask with _$SubTask {
  const factory SubTask({
    required String id,
    required String title,
    required bool isCompleted,
    String? description,
    String? nextId,
  }) = _SubTask;

  factory SubTask.fromJson(Map<String, dynamic> json) =>
      _$SubTaskFromJson(json);
}
