// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo_app/feature/home/viewmodel/task_crud_viewmodel.dart';
// import 'package:todo_app/service/task_service.dart';

// // Task count state notifier provider
// final taskCountProvider = StateNotifierProvider<TaskCountNotifier, TaskCountState>((ref) {
//   final service = ref.watch(serviceProvider);
//   return TaskCountNotifier(service);
// });

// class TaskCountState {
//   final int newTaskCount;
//   final int continueTaskCount;
//   final int finishedTaskCount;
//   final bool isLoading;

//   TaskCountState({
//     required this.newTaskCount,
//     required this.continueTaskCount,
//     required this.finishedTaskCount,
//     required this.isLoading,
//   });
// }

// class TaskCountNotifier extends StateNotifier<TaskCountState> {
//   TaskCountNotifier(this._taskService)
//       : super(TaskCountState(newTaskCount: 0, continueTaskCount: 0, finishedTaskCount: 0, isLoading: true)) {
//     loadTaskCounts();
//   }

//   final TaskService _taskService;

//   Future<void> loadTaskCounts() async {
//     state = TaskCountState(
//       newTaskCount: state.newTaskCount,
//       continueTaskCount: state.continueTaskCount,
//       finishedTaskCount: state.finishedTaskCount,
//       isLoading: true,
//     );

//     try {
//       final newTasks = await _taskService.getTasks(1);
//       final continueTasks = await _taskService.getTasks(2);
//       final finishedTasks = await _taskService.getTasks(3);

//       state = TaskCountState(
//         newTaskCount: newTasks.length,
//         continueTaskCount: continueTasks.length,
//         finishedTaskCount: finishedTasks.length,
//         isLoading: false,
//       );
//     } catch (e) {
//       print('Error loading task counts: $e');
//       state = TaskCountState(newTaskCount: 0, continueTaskCount: 0, finishedTaskCount: 0, isLoading: false);
//     }
//   }
// }
