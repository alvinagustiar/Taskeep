import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/task.dart';
import '../../models/category.dart';
import '../../services/supabase_service.dart';

class TaskDetailScreen extends ConsumerWidget {
  final String taskId;

  const TaskDetailScreen({
    super.key,
    required this.taskId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Replace with actual task data from provider
    final task = Task(
      id: taskId,
      title: 'Example Task',
      description:
          'This is an example task description that shows the details of the task.',
      createdAt: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 1)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit task
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // TODO: Implement delete task
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Created ${_formatDate(task.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (task.dueDate != null) ...[
              const SizedBox(height: 4),
              Text(
                'Due ${_formatDate(task.dueDate!)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _isDueToday(task.dueDate!)
                          ? Theme.of(context).colorScheme.error
                          : null,
                    ),
              ),
            ],
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(task.description),
            const SizedBox(height: 24),
            Text(
              'Sub-tasks',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            // TODO: Replace with actual sub-tasks
            const Text('No sub-tasks yet'),
            const SizedBox(height: 24),
            Text(
              'Tags',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: task.tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  onDeleted: () {
                    // TODO: Implement remove tag
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Attachments',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            // TODO: Replace with actual attachments
            const Text('No attachments yet'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add sub-task
        },
        child: const Icon(Icons.add_task),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  bool _isDueToday(DateTime dueDate) {
    final now = DateTime.now();
    return dueDate.year == now.year &&
        dueDate.month == now.month &&
        dueDate.day == now.day;
  }
}
