import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:todo_app/service/task_crud_service.dart';

class TaskNotifier extends StateNotifier<TaskModel> {
  TaskNotifier(this._taskService) : super(TaskModel());

  final TaskService _taskService;

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateImportance(int importance) {
    state = state.copyWith(importance: importance);
  }

  void updateIcon(int iconCodePoint) {
    state = state.copyWith(iconCodePoint: iconCodePoint);
  }

  Future<void> submitTask() async {
    try {
      await _taskService.addTask(state);
      state = TaskModel();
    } catch (e) {
      print('Error submitting task: $e');
      rethrow;
    }
  }

}