import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/product/constants/collection_enum.dart';

class TaskService {
  final _collection = FirebaseFirestore.instance.collection(CollectionEnum.tasks.value);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser?.uid ?? '';

  Future<void> addTask(TaskModel task) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User not authenticated');
      }

      final now = DateTime.now();
      final currentDayAndMonth = DateFormat(_DateFormatType.dayAndMonth.value).format(now);

      final updatedTask = task.copyWith(
        userId: userId,
        createdAt: currentDayAndMonth,
        description: task.description,
        iconCodePoint: task.iconCodePoint == 62504 ? 62504 : task.iconCodePoint,
      );

      final newTask = await _collection.add(updatedTask.toMap());

      await newTask.update({_TaskDocumant.id.value: newTask.id});
    } catch (e) {
      throw Exception('An error occurred while adding the task: $e');
    }
  }

  Future<List<TaskModel>> getTasks(int categoryId) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User not authenticated');
      }
      final querySnapshot = await _collection
          .where(
            _TaskDocumant.userId.value,
            isEqualTo: userId,
          )
          .where(_TaskDocumant.categoryId.value, isEqualTo: categoryId)
          .orderBy(_TaskDocumant.createdAt.value, descending: true)
          .get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data[_TaskDocumant.id.value] = doc.id;
        return TaskModel.fromMap(data);
      }).toList();
    } catch (e) {
      throw Exception('An error occurred while fetching tasks: $e');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User not authenticated');
      }
      await _collection.doc(task.id).update(task.toMap());
    } catch (e) {
      throw Exception('An error occurred while updating the task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User not authenticated');
      }
      await _collection.doc(taskId).delete();
    } catch (e) {
      throw Exception('An error occurred while deleting the task: $e');
    }
  }
}

enum _TaskDocumant {
  id("id"),
  userId("userId"),
  categoryId("categoryId"),
  createdAt("createdAt");

  final String value;

  const _TaskDocumant(this.value);
}

enum _DateFormatType {
  dayAndMonth('d MMMM');

  final String value;

  const _DateFormatType(this.value);
}
