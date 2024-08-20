import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:todo_app/feature/home/view/task_add_page.dart';
import 'package:todo_app/feature/home/viewmodel/task/task_crud_viewmodel.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/constants/project_strings.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';
import 'package:todo_app/product/validators/validators.dart';
import 'package:todo_app/product/widgets/project_button.dart';

@RoutePage()
class TaskEditPage extends StatefulHookConsumerWidget {
  final TaskModel model;
  const TaskEditPage(this.model, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends ConsumerState<TaskEditPage> {
  @override
  Widget build(BuildContext context) {
    final formkey = useMemoized(() => GlobalKey<FormState>());
    final taskNotifier = ref.read(taskProvider.notifier);
    final updateLoading = ref.watch(taskProvider).isLoading;
    final newTask = useState(widget.model);

    Future<void> submitForm() async {
      if (formkey.currentState!.validate()) {
        try {
          await taskNotifier.updateTask(newTask.value);
          Fluttertoast.showToast(
              msg: ProjectStrings.toastSuccessUpdateMessage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ProjectColors.grey,
              textColor: ProjectColors.white,
              fontSize: 16.0);
          context.mounted
              ? context.router.replaceAll([const TabbarRoute()])
              : null;
        } catch (error) {
          Fluttertoast.showToast(
              msg: '${ProjectStrings.toastErrorAddMessage} $error',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ProjectColors.black,
              textColor: ProjectColors.white,
              fontSize: 16.0);
        }
      }
    }

    return updateLoading ? Container(
            color: ProjectColors.white,
            child: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
      appBar: AppBar(
        title: const Text(ProjectStrings.taskEditAppbarTitle),
      ),
      body: Padding(
        padding: context.paddingHorizontalMedium,
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              SizedBox(height: context.lowValue2),
              _TextfieldTaskName(
                newTask: newTask,
                model: widget.model,
              ),
              SizedBox(height: context.lowValue2),
              _TextfieldDescription(
                model: widget.model,
                newTask: newTask,
              ),
              SizedBox(height: context.lowValue2),
              _DropdownImportanceScore(widget: widget, newTask: newTask),
              SizedBox(height: context.lowValue2),
              _DropdownChangeCategory(widget: widget, newTask: newTask),
              SizedBox(height: context.lowValue2),
              const _TaskIconListTitle(),
              SizedBox(height: context.lowValue1),
              _GridviewTaskIconList(newTask: newTask),
              SizedBox(height: context.highValue),
              ProjectButton(
                  text: ProjectStrings.saveButtonText, onPressed: submitForm),
              SizedBox(height: context.mediumValue),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextfieldTaskName extends HookWidget {
  const _TextfieldTaskName({
    required this.newTask,
    required this.model,
  });

  final ValueNotifier<TaskModel> newTask;
  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    final tfTitle = useTextEditingController(text: model.name);
    return TextFormField(
      controller: tfTitle,
      decoration: const InputDecoration(
        labelText: ProjectStrings.tfhintTaskName,
      ),
      style: context.textTheme().titleSmall,
      validator: Validators().validateTaskNameNotEmpty,
      onChanged: (value) {
        newTask.value = newTask.value.copyWith(name: value);
      },
    );
  }
}

class _TextfieldDescription extends HookWidget {
  const _TextfieldDescription({
    required this.model,
    required this.newTask,
  });

  final ValueNotifier<TaskModel> newTask;
  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    final descriptionLength = useState<int>(model.description.length);
    final tfDescription = useTextEditingController(text: model.description);
    return TextFormField(
      controller: tfDescription,
      style: context.textTheme().titleSmall,
      decoration: InputDecoration(
          counterText: "${descriptionLength.value}/200",
          labelText: ProjectStrings.tfhintTaskDes,
          alignLabelWithHint: true),
      maxLength: 200,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.done,
      onChanged: (value) {
        descriptionLength.value = value.length;
        newTask.value = newTask.value.copyWith(description: value);
      },
    );
  }
}

class _DropdownImportanceScore extends StatelessWidget {
  const _DropdownImportanceScore({
    required this.widget,
    required this.newTask,
  });

  final TaskEditPage widget;
  final ValueNotifier<TaskModel> newTask;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration:
          const InputDecoration(labelText: ProjectStrings.dropdownImportance),
      value: widget.model.importance,
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

class _DropdownChangeCategory extends StatelessWidget {
  const _DropdownChangeCategory({
    required this.widget,
    required this.newTask,
  });

  final TaskEditPage widget;
  final ValueNotifier<TaskModel> newTask;

  @override
  Widget build(BuildContext context) {
    String getCategoryName(int value) {
      switch (value) {
        case 1:
          return ProjectStrings.categoryNameNew;
        case 2:
          return ProjectStrings.categoryNameContinue;
        case 3:
          return ProjectStrings.categoryNameFinished;
      }
      return "";
    }

    return DropdownButtonFormField<int>(
      decoration:
          const InputDecoration(labelText: ProjectStrings.dropdownCategory),
      value: widget.model.categoryId,
      items: [
        DropdownMenuItem<int>(
          value: 1,
          child: Text(
            ProjectStrings.categoryNameNew,
            style: context.textTheme().titleSmall,
          ),
        ),
        DropdownMenuItem<int>(
          value: 2,
          child: Text(
            ProjectStrings.categoryNameContinue,
            style: context.textTheme().titleSmall,
          ),
        ),
        DropdownMenuItem<int>(
          value: 3,
          child: Text(
            ProjectStrings.categoryNameFinished,
            style: context.textTheme().titleSmall,
          ),
        ),
      ],
      onChanged: (value) {
        newTask.value = newTask.value.copyWith(categoryId: value);
        newTask.value =
            newTask.value.copyWith(category: getCategoryName(value ?? 1));
      },
    );
  }
}

class _TaskIconListTitle extends StatelessWidget {
  const _TaskIconListTitle();

  @override
  Widget build(BuildContext context) {
    return Text(ProjectStrings.iconListTitle,
        style: context.textTheme().titleMedium);
  }
}

class _GridviewTaskIconList extends HookWidget {
  const _GridviewTaskIconList({
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
