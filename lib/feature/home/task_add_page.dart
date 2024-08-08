import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/validators/validators.dart';
import 'package:todo_app/product/widgets/project_button.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, Task>((ref) {
  return TaskNotifier();
});

class Task {
  final String name;
  final int importance;
  final int iconCodePoint;

  Task({this.name = '', this.importance = 1, this.iconCodePoint = 58826});

  Task copyWith({String? name, int? importance, int? iconCodePoint}) {
    return Task(
      name: name ?? this.name,
      importance: importance ?? this.importance,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
    );
  }
}

class TaskNotifier extends StateNotifier<Task> {
  TaskNotifier() : super(Task());

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateImportance(int importance) {
    state = state.copyWith(importance: importance);
  }

  void updateIcon(int iconCodePoint) {
    state = state.copyWith(iconCodePoint: iconCodePoint);
  }
}

@RoutePage()
class TaskAddPage extends StatefulHookConsumerWidget {
  const TaskAddPage({super.key});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<TaskAddPage> {
  final _formKey = GlobalKey<FormState>();

  final List<IconData> _icons = [
    Icons.task_alt_outlined,
    Icons.home_outlined,
    Icons.work_outline,
    Icons.school_outlined,
    Icons.shopping_cart_outlined,
    Icons.fitness_center_outlined,
    Icons.restaurant_outlined,
    Icons.local_hospital_outlined,
    Icons.directions_car_outlined,
    Icons.airplanemode_active_outlined,
    Icons.book_outlined,
    Icons.music_note_outlined,
    Icons.movie_outlined,
    Icons.sports_esports_outlined,
    Icons.nature_people_outlined,
    Icons.pets_outlined,
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final task = ref.read(taskProvider);

      FirebaseFirestore.instance.collection('tasks').add({
        'name': task.name,
        'importance': task.importance,
        'iconCodePoint': task.iconCodePoint,
        'createdAt': FieldValue.serverTimestamp(),
        'category': 'Yeni',
        'categoryId': 1,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task added successfully!')),
        );
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $error')),
        );
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final task = ref.watch(taskProvider);
    final taskNotifier = ref.read(taskProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Padding(
        padding: context.paddingHorizontalMedium,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Task Name'),
                style: context.textTheme().titleSmall,
                validator: Validators().validateTaskNameNotEmpty,
                onChanged: (value) => taskNotifier.updateName(value),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<int>(
                decoration:
                    const InputDecoration(labelText: 'Importance score'),
                value: task.importance,
                items: [1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  );
                }).toList(),
                onChanged: (value) => taskNotifier.updateImportance(value!),
              ),
              const SizedBox(height: 20),
              Text('Select Task Icon', style: context.textTheme().titleMedium),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _icons.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        taskNotifier.updateIcon(_icons[index].codePoint),
                    child: Container(
                      decoration: BoxDecoration(
                        color: task.iconCodePoint == _icons[index].codePoint
                            ? Colors.blue.withOpacity(0.4)
                            : Colors.transparent,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(_icons[index], size: 30),
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
              ProjectButton(text: "Save", onPressed: _submitForm)
            ],
          ),
        ),
      ),
    );
  }
}
