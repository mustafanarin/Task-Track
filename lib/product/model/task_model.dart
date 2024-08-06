import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String? name;
  final String? category;
  final String? categoryId;
  final String? date;
  final String? importance;
  final String? id;

  const TaskModel({
    this.name,
    this.category,
    this.categoryId,
    this.date,
    this.importance,
    this.id,
  });

  @override
  List<Object?> get props => [name, category, categoryId, date, importance, id];

  TaskModel copyWith({
    String? name,
    String? category,
    String? categoryId,
    String? date,
    String? importance,
    String? id,
  }) {
    return TaskModel(
      name: name ?? this.name,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      importance: importance ?? this.importance,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'categoryId': categoryId,
      'date': date,
      'importance': importance,
      'id': id,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      name: json['name']?.toString(),
      category: json['category']?.toString(),
      categoryId: json['categoryId']?.toString(),
      date: json['date']?.toString(),
      importance: json['importance']?.toString(),
      id: json['id']?.toString(),
    );
  }
}
