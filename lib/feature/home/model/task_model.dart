class TaskModel {
  final String name;
  final int importance;
  final int iconCodePoint;

  TaskModel({this.name = '', this.importance = 1, this.iconCodePoint = 58826});

  TaskModel copyWith({String? name, int? importance, int? iconCodePoint}) {
    return TaskModel(
      name: name ?? this.name,
      importance: importance ?? this.importance,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
    );
  }
}