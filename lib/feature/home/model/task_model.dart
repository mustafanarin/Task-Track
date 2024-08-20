import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TaskModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String description;
  final int importance;
  final int iconCodePoint;
  final String? createdAt;
  final String category;
  final int categoryId;

  const TaskModel({
    this.id = "",
    required this.userId,
    this.name = "",
    this.description = "",
    this.importance = 1,
    this.iconCodePoint = 62504,
    this.createdAt,
    this.category = 'New',
    this.categoryId = 1,
  });

  TaskModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    int? importance,
    int? iconCodePoint,
    String? createdAt,
    String? category,
    int? categoryId,
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      importance: importance ?? this.importance,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'importance': importance,
      'iconCodePoint': iconCodePoint,
      'createdAt': createdAt,
      'category': category,
      'categoryId': categoryId,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? "",
      importance: map['importance']?.toInt() ?? 1,
      iconCodePoint: map['iconCodePoint']?.toInt() ?? 62504,
      createdAt: map['createdAt'] ?? "Error",
      category: map['category'] ?? 'New',
      categoryId: map['categoryId']?.toInt() ?? 1,
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id,userId:$userId, name: $name, importance: $importance, iconCodePoint: $iconCodePoint, createdAt: $createdAt, category: $category, categoryId: $categoryId)';
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        description,
        importance,
        iconCodePoint,
        createdAt,
        category,
        categoryId
      ];
}
