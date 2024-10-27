import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:todo_app/feature/home/providers/task_crud_provider.dart';
import 'package:todo_app/feature/profile/provider/language_provider.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/validators/validators.dart';
import 'package:todo_app/product/widgets/project_button.dart';

import '../../../product/widgets/project_textfield.dart';

part '../../../product/utility/app_part/my_icon_list.dart';

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

    final isLoading = useState(false);

    final newTask = useState(const TaskModel(userId: ""));

    Future<void> submitForm() async {
      if (formkey.currentState!.validate()) {
        isLoading.value = true;
        try {
          await taskNotifier.addTask(newTask.value);
          Fluttertoast.showToast(
              msg: "toastSuccessAddMessage".localize(ref),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ProjectColors.grey,
              textColor: ProjectColors.white,
              fontSize: 16.0);
          context.mounted ? context.maybePop() : null;
        } catch (error) {
          isLoading.value = false;
          Fluttertoast.showToast(
              msg: '${"toastErrorAddMessage".localize(ref)} $error',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ProjectColors.black,
              textColor: ProjectColors.white,
              fontSize: 16.0);
        }
      }
    }

    return isLoading.value
        ? Container(
            color: ProjectColors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("taskAddAppbarTitle".localize(ref)),
            ),
            body: Padding(
              padding: context.paddingHorizontalMedium,
              child: Form(
                key: formkey,
                child: ListView(
                  children: [
                    SizedBox(height: context.lowValue2),
                    _TextFormFieldName(newTask: newTask),
                    SizedBox(height: context.lowValue2),
                    _TextfieldDescription(newTask: newTask),
                    SizedBox(height: context.lowValue2),
                    _DropdownImportanceScore(newTask: newTask),
                    SizedBox(height: context.lowValue2),
                    const _TextIconListTitle(),
                    SizedBox(height: context.lowValue1),
                    _GridViewTaskIconList(newTask: newTask),
                    SizedBox(height: context.highValue),
                    ProjectButton(
                        text: "saveButtonText".localize(ref),
                        onPressed: submitForm),
                    SizedBox(height: context.mediumValue),
                  ],
                ),
              ),
            ),
          );
  }
}

class _TextIconListTitle extends ConsumerWidget {
  const _TextIconListTitle();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Text("iconListTitle".localize(ref),
        style: context.textTheme().titleMedium);
  }
}

class _TextFormFieldName extends ConsumerWidget {
  const _TextFormFieldName({
    required this.newTask,
  });

  final ValueNotifier<TaskModel> newTask;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ProjectTextfield(
      label: Text("tfhintTaskName".localize(ref)),
      keyBoardType: TextInputType.text,
      validator: Validators().validateTaskNameNotEmpty,
      onChanged: (value) {
        newTask.value = newTask.value.copyWith(name: value);
      },
    );
  }
}

class _TextfieldDescription extends HookConsumerWidget {
  const _TextfieldDescription({
    required this.newTask,
  });

  final ValueNotifier<TaskModel> newTask;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final descriptionLength = useState<int>(0);
    return ProjectTextfield(
      keyBoardType: TextInputType.multiline,
      validator: null,
      label: Text("tfhintTaskDes".localize(ref)),
      decoration: InputDecoration(
        counterText: "${descriptionLength.value}/200",
        alignLabelWithHint: true,
      ),
      maxLength: 200,
      maxLines: 3,
      minLines: 3,
      onChanged: (value) {
        descriptionLength.value = value.length;
        newTask.value = newTask.value.copyWith(description: value);
      },
    );
  }
}


class _DropdownImportanceScore extends ConsumerWidget {
  const _DropdownImportanceScore({
    required this.newTask,
  });

  final ValueNotifier<TaskModel> newTask;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return DropdownButtonFormField<int>(
      decoration:
           InputDecoration(labelText: "dropdownImportance".localize(ref)),
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
    );
  }
}

class _GridViewTaskIconList extends HookWidget {
  const _GridViewTaskIconList({
    required this.newTask,
  });

  final ValueNotifier<TaskModel> newTask;

  @override
  Widget build(BuildContext context) {
    late final List<IconData> icons;
    useEffect(() {
      icons = MyIconList().icons;
      return () {};
    });
    return GridView.builder(
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
            newTask.value =
                newTask.value.copyWith(iconCodePoint: icons[index].codePoint);
          },
          child: Container(
            decoration: BoxDecoration(
              color: newTask.value.iconCodePoint == icons[index].codePoint
                  ? Colors.blue.withOpacity(0.4)
                  : Colors.transparent,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icons[index], size: 30),
          ),
        );
      },
    );
  }
}
