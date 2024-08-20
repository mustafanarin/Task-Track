import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/home/viewmodel/task/task_crud_viewmodel.dart';


import '../../../../product/constants/category_id_enum.dart';
import '../../../../service/task_service.dart';


// Task count state notifier provider
final taskCountProvider =
    StateNotifierProvider<TaskCountNotifier, TaskCountState>((ref) {
  final service = ref.watch(serviceProvider);
  return TaskCountNotifier(service, ref);
});


class TaskCountState {
  final Map<int, int> taskCounts;

  TaskCountState(this.taskCounts);
}

class TaskCountNotifier extends StateNotifier<TaskCountState> {
  final TaskService _taskService;
  final Ref ref;

  TaskCountNotifier(this._taskService, this.ref) : super(TaskCountState({}));

  Future<void> updateTaskCounts() async {
    final newTasks = await _taskService.getTasks(CategoryId.newTask.value);
    final continueTasks =
        await _taskService.getTasks(CategoryId.continueTask.value);
    final finishedTasks =
        await _taskService.getTasks(CategoryId.finishTask.value);

    state = TaskCountState({
      CategoryId.newTask.value: newTasks.length,
      CategoryId.continueTask.value: continueTasks.length,
      CategoryId.finishTask.value: finishedTasks.length,
    });
  }
}
