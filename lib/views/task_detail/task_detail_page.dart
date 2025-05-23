import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskeep/viewmodels/task_viewmodel.dart';

class TaskDetailPage extends ConsumerWidget {
  final String taskId;
  const TaskDetailPage({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskViewModelProvider);
    final task = tasks.firstWhere((t) => t.id == taskId);

    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(taskViewModelProvider.notifier).deleteTask(taskId);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (task.description != null) Text(task.description!),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                task.dueDate != null ? 'Due: \${task.dueDate}' : 'No due date',
              ),
              onTap: () {}, // TODO: Pick due date
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.checklist),
              title: const Text('Sub-Tasks'),
              onTap: () {}, // TODO: Manage sub-tasks
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Dependencies'),
              onTap: () {}, // TODO: Manage dependencies
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.repeat),
              title: const Text('Recurrence'),
              onTap: () {}, // TODO: Recurrence settings
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Attachments'),
              onTap: () {}, // TODO: Manage attachments
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.label),
              title: const Text('Tags'),
              onTap: () {}, // TODO: Tag management
            ),
          ],
        ),
      ),
    );
  }
}
