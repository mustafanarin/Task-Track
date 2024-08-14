import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:todo_app/service/task_service.dart';

// Task service provider
final serviceProvider = Provider<TaskService>((ref) {
  return TaskService();
});

// Task state notifier provider
final taskProvider =
    StateNotifierProvider<TaskNotifier, List<TaskModel>>((ref) {
  final service = ref.watch(serviceProvider);
  return TaskNotifier(service);
});

class TaskNotifier extends StateNotifier<List<TaskModel>> {
  TaskNotifier(this._taskService) : super([]);

  final TaskService _taskService;

  Future<void> loadTasks(int categoryId) async {
    try {
      final tasks = await _taskService.getTasks(categoryId);
      state = tasks;
    } catch (e) {
      print('Error loading tasks: $e');
      state = [];
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await _taskService.addTask(task);
      await loadTasks(task.categoryId);
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _taskService.updateTask(task);
      await loadTasks(task.categoryId);
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> deleteTask(TaskModel task) async {
    try {
      await _taskService.deleteTask(task.id);
      await loadTasks(task.categoryId);
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
