import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
  return TaskNotifier(service,ref);
});

// Sort type provider
enum SortType { creationDate, name, importance }

// Default sort type is creation Date
final sortTypeProvider = StateProvider<SortType>((ref) => SortType.creationDate);

class TaskNotifier extends StateNotifier<List<TaskModel>> {
  TaskNotifier(this._taskService, this._ref) : super([]);

  final TaskService _taskService;
  final Ref _ref;

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

  
  void sortTasks(SortType sortType) {
    _ref.read(sortTypeProvider.notifier).state = sortType;
    _sortTasks();
  }


  void _sortTasks() {
    final sortType = _ref.read(sortTypeProvider);
    switch (sortType) {
      case SortType.creationDate:
        state.sort((a, b) {
          final dateFormat = DateFormat('d MMMM');
          final dateA = dateFormat.parse(a.createdAt ?? "");
          final dateB = dateFormat.parse(b.createdAt ?? "");
          return dateB.compareTo(dateA); 
        });
        break;
      case SortType.name:
        state.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case SortType.importance:
        state.sort((a, b) => b.importance.compareTo(a.importance));
        break;
    }
    state = [...state];
  }

}
