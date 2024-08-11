import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:todo_app/feature/home/viewmodel/task_add_provider.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/validators/validators.dart';
import 'package:todo_app/product/widgets/project_button.dart';
import 'package:todo_app/service/task_crud_service.dart';

@RoutePage()
class TaskAddPage extends StatefulHookConsumerWidget {
  const TaskAddPage({super.key});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<TaskAddPage> {
  
  // Provider
  final taskProvider = StateNotifierProvider<TaskNotifier, TaskModel>((ref) {
    final service = TaskService();
    return TaskNotifier(service);
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final formkey = useMemoized(() => GlobalKey<FormState>());
    final task = ref.watch(taskProvider);
    final taskNotifier = ref.read(taskProvider.notifier);
    late final List<IconData> icons;

    useEffect(() {
      icons = MyIconList().icons;
      return () {};
    });
    void _submitForm() async {
    if (formkey.currentState!.validate()) {
      try {
        await ref.read(taskProvider.notifier).submitTask();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task added successfully!')),
        );
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $error')),
        );
      }
    }
  }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Padding(
        padding: context.paddingHorizontalMedium,
        child: Form(
          key: formkey,
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
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        taskNotifier.updateIcon(icons[index].codePoint),
                    child: Container(
                      decoration: BoxDecoration(
                        color: task.iconCodePoint == icons[index].codePoint
                            ? Colors.blue.withOpacity(0.4)
                            : Colors.transparent,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icons[index], size: 30),
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

class MyIconList {
  late final List<IconData> icons;

  MyIconList() {
    icons = [
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
  }
}
