import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskeep/views/task_detail/task_detail_page.dart';
import 'package:taskeep/viewmodels/task_viewmodel.dart';

class HomePage extends ConsumerWidget {
  static const String routeName = '/home';

  static Map<String, Widget Function(BuildContext, Object?)> get routes => {
    routeName: (context, state) => const HomePage(),
  };

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskkeep'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {}, // TODO: Navigate to Calendar
          ),
        ],
      ),
      body:
          tasks.isEmpty
              ? const Center(child: Text('No tasks. Add one!'))
              : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle:
                        task.dueDate != null
                            ? Text('Due: ${task.dueDate}')
                            : null,
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (val) {
                        ref
                            .read(taskViewModelProvider.notifier)
                            .updateTask(task.copyWith(isCompleted: val!));
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TaskDetailPage(taskId: task.id),
                        ),
                      );
                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to Add Task
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
