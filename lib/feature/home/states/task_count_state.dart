class TaskCountState {
  final Map<int, int> taskCounts;
  final bool isLoading;

  TaskCountState(this.taskCounts, this.isLoading);

  TaskCountState copyWith({
    Map<int, int>? taskCounts,
    bool? isLoading,
  }) {
    return TaskCountState(
      taskCounts ?? this.taskCounts,
      isLoading ?? this.isLoading,
    );
  }
}