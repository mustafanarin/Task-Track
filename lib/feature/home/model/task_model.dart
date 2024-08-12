import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TaskModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final int importance;
  final int iconCodePoint;
  final DateTime? createdAt;
  final String category;
  final int categoryId;

  const TaskModel({
    this.id = "",
    required this.userId,
    this.name = "",
    this.importance = 1,
    this.iconCodePoint = 62504,
    this.createdAt,
    this.category = 'Yeni',
    this.categoryId = 1,
  });

  TaskModel copyWith({
    String? id,
    String? userId,
    String? name,
    int? importance,
    int? iconCodePoint,
    DateTime? createdAt,
    String? category,
    int? categoryId,
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
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
      'importance': importance,
      'iconCodePoint': iconCodePoint,
      'createdAt': createdAt?.toIso8601String(),
      'category': category,
      'categoryId': categoryId,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      importance: map['importance']?.toInt() ?? 1,
      iconCodePoint: map['iconCodePoint']?.toInt() ?? 62504,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      category: map['category'] ?? 'Yeni',
      categoryId: map['categoryId']?.toInt() ?? 1,
    );
  }


  @override
  String toString() {
    return 'TaskModel(id: $id,userId:$userId, name: $name, importance: $importance, iconCodePoint: $iconCodePoint, createdAt: $createdAt, category: $category, categoryId: $categoryId)';
  }
  
  @override
  List<Object?> get props => [id, userId, name, importance, iconCodePoint, createdAt, category, categoryId];
}