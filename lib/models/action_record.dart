import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_record.freezed.dart';
part 'action_record.g.dart';

enum ActionType {
  createTask,
  updateTask,
  deleteTask,
  createCategory,
  updateCategory,
  deleteCategory,
  moveTask,
  updatePriority,
  toggleComplete,
  addTag,
  removeTag,
  addAttachment,
  removeAttachment,
  updateDueDate,
}

@freezed
class ActionRecord with _$ActionRecord {
  const factory ActionRecord({
    required String id,
    required ActionType type,
    required DateTime timestamp,
    required Map<String, dynamic> previousState,
    required Map<String, dynamic> newState,
    String? entityId,
    String? description,
  }) = _ActionRecord;

  factory ActionRecord.fromJson(Map<String, dynamic> json) =>
      _$ActionRecordFromJson(json);
}

class ActionStack {
  final List<ActionRecord> _stack = [];

  void push(ActionRecord action) {
    _stack.add(action);
  }

  ActionRecord? pop() {
    if (_stack.isNotEmpty) {
      return _stack.removeLast();
    }
    return null;
  }

  ActionRecord? peek() {
    if (_stack.isNotEmpty) {
      return _stack.last;
    }
    return null;
  }

  bool get isEmpty => _stack.isEmpty;

  int get size => _stack.length;

  void clear() {
    _stack.clear();
  }

  List<ActionRecord> getActions() {
    return List.unmodifiable(_stack);
  }

  List<ActionRecord> getActionsByType(ActionType type) {
    return _stack.where((action) => action.type == type).toList();
  }

  List<ActionRecord> getActionsByEntity(String entityId) {
    return _stack.where((action) => action.entityId == entityId).toList();
  }
}
