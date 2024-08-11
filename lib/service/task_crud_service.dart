import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/feature/home/model/task_model.dart';

class TaskService {
  final _collection = FirebaseFirestore.instance.collection("tasks");

  Future<void> addTask(TaskModel task) async {
    try {
      await _collection.add({
        'name': task.name,
        'importance': task.importance,
        'iconCodePoint': task.iconCodePoint,
        'createdAt': FieldValue.serverTimestamp(),
        'category': 'Yeni',
        'categoryId': 1,
      });
    } catch (e) {
      throw Exception('An error occurred while adding the task: $e');
    }
  }
}