import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:todo_app/feature/home/viewmodel/task_crud_viewmodel.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/validators/validators.dart';
import 'package:todo_app/product/widgets/project_button.dart';

part '../../../product/part_of/my_icon_list.dart';

@RoutePage()
class TaskAddPage extends StatefulHookConsumerWidget {
  const TaskAddPage({super.key});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<TaskAddPage> {
  @override
  Widget build(BuildContext context) {
    final formkey = useMemoized(() => GlobalKey<FormState>());
    final taskNotifier = ref.read(taskProvider.notifier);
    late final List<IconData> icons;

    useEffect(() {
      icons = MyIconList().icons;
      return () {};
    });

    final newTask = useState(const TaskModel(userId: ""));
    final descriptionLength = useState<int>(0);

    Future<void> submitForm() async {
      if (formkey.currentState!.validate()) {
        try {
          await taskNotifier.addTask(newTask.value);
          Fluttertoast.showToast(
              msg: "Task added successfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ProjectColors.grey,
              textColor: ProjectColors.white,
              fontSize: 16.0);
          context.mounted ? context.maybePop() : null;
        } catch (error) {
          Fluttertoast.showToast(
              msg: 'An error occurred: $error',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ProjectColors.black,
              textColor: ProjectColors.white,
              fontSize: 16.0);
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
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                ),
                style: context.textTheme().titleSmall,
                validator: Validators().validateTaskNameNotEmpty,
                onChanged: (value) {
                  newTask.value = newTask.value.copyWith(name: value);
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: context.textTheme().titleSmall,
                decoration: InputDecoration(
                    counterText: "${descriptionLength.value}/200",
                    labelText: "Description...",
                    alignLabelWithHint: true),
                maxLength: 200,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  descriptionLength.value = value.length;
                  newTask.value = newTask.value.copyWith(description: value);
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<int>(
                decoration:
                    const InputDecoration(labelText: 'Importance score'),
                value: newTask.value.importance,
                items: [1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  );
                }).toList(),
                onChanged: (value) {
                  newTask.value = newTask.value.copyWith(importance: value);
                },
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
                    onTap: () {
                      newTask.value = newTask.value
                          .copyWith(iconCodePoint: icons[index].codePoint);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: newTask.value.iconCodePoint ==
                                icons[index].codePoint
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
              ProjectButton(text: "Save", onPressed: submitForm),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
