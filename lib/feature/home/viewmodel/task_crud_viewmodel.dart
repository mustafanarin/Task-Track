import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:todo_app/service/task_service.dart';

// Task service provider
final serviceProvider = Provider((ref) {
  return TaskService();
});

// Task state notifier provider
final taskProvider =
    StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final service = ref.watch(serviceProvider);
  return TaskNotifier(service, ref);
});

// Sort type provider
enum SortType { name, importance }

// Default sort type is none
final sortTypeProvider = StateProvider<SortType?>((ref) => null);

class TaskState {
  final List<TaskModel> tasks;
  final bool isLoading;

  TaskState({required this.tasks, required this.isLoading});
}

class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier(this._taskService, this._ref) : super(TaskState(tasks: [], isLoading: false));

  final TaskService _taskService;
  final Ref _ref;

  Future<void> loadTasks(int categoryId) async {
    state = TaskState(tasks: state.tasks, isLoading: true);
    try {
      final tasks = await _taskService.getTasks(categoryId);
      state = TaskState(tasks: tasks, isLoading: false);
    } catch (e) {
      print('Görevler yüklenirken hata oluştu: $e');
      state = TaskState(tasks: [], isLoading: false);
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
    if (sortType == null) return;

    switch (sortType) {
      case SortType.name:
        state.tasks.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case SortType.importance:
        state.tasks.sort((a, b) => b.importance.compareTo(a.importance));
        break;
    }
    state = TaskState(tasks: state.tasks, isLoading: false);
  }
}
