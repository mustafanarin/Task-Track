import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:todo_app/feature/home/viewmodel/task/task_crud_viewmodel.dart';
import 'package:todo_app/product/constants/category_id_enum.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/constants/project_strings.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';

import '../model/short_type_enum.dart';

@RoutePage()
class TaskListPage extends HookConsumerWidget {
  final int categoryId;
  final CategoryId category;
  final String categoryName;
  const TaskListPage(this.categoryId, this.category, this.categoryName,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Color> cardColor = CardColor().colorByCategory(category);
    final taskNotifier = ref.read(taskProvider.notifier);
    final taskState = ref.watch(taskProvider);

    useEffect(() {
      Future.microtask(() => taskNotifier.loadTasks(categoryId));
      return null;
    }, [categoryId]);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: [const _PopupShortMenu()],
      ),
      body: Padding(
        padding: context.paddingHorizontalLow,
        child: taskState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : taskState.tasks.isEmpty
                ? Center(
                    child: Text(
                        "No ${categoryName.toLowerCase()} missions yet.",
                        style: const TextStyle(color: Colors.black)))
                : _ListviewBuilderTasks(
                    cardColor: cardColor,
                    category: category,
                  ),
      ),
    );
  }
}

class _ListviewBuilderTasks extends ConsumerWidget {
  const _ListviewBuilderTasks({
    required this.cardColor,
    required this.category,
  });

  final List<Color> cardColor;
  final CategoryId category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskNotifier = ref.read(taskProvider.notifier);
    final taskState = ref.watch(taskProvider);

    return ListView.builder(
      itemCount: taskState.tasks.length,
      itemBuilder: (context, index) {
        final task = taskState.tasks[index];
        return Slidable(
          key: ValueKey(index),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  taskNotifier.deleteTask(task);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: ProjectStrings.delete,
              ),
            ],
          ),
          child: _ListTileTaskContainer(
              cardColor: cardColor, task: task, category: category),
        );
      },
    );
  }
}

class _PopupShortMenu extends ConsumerWidget {
  const _PopupShortMenu();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskNotifier = ref.read(taskProvider.notifier);

    return PopupMenuButton(
      icon: const Icon(Icons.menu_outlined),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          onTap: () => taskNotifier.sortTasks(SortType.name),
          child: const Text(ProjectStrings.shortByName),
        ),
        PopupMenuItem<String>(
          onTap: () => taskNotifier.sortTasks(SortType.importance),
          child: const Text(ProjectStrings.shortByImportance),
        ),
      ],
    );
  }
}

class _ListTileTaskContainer extends StatelessWidget {
  const _ListTileTaskContainer({
    required this.cardColor,
    required this.task,
    required this.category,
  });

  final List<Color> cardColor;
  final TaskModel task;
  final CategoryId category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: cardColor),
        ),
        child: ListTile(
          onTap: () => context
              .pushRoute(TaskDetailRoute(model: task, category: category)),
          title: Text(
            task.name,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          subtitle: Row(
            children: [
              RatingBar.builder(
                ignoreGestures: true,
                itemSize: 20,
                initialRating: task.importance.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: ProjectColors.amber,
                ),
                onRatingUpdate: (double value) {},
              ),
              const Spacer(),
              Text(
                "${task.createdAt}",
                style: TextStyle(color: Colors.grey[300], fontSize: 15),
              )
            ],
          ),
          leading: Icon(
            IconData(task.iconCodePoint, fontFamily: 'MaterialIcons'),
            color: Colors.white,
          ),
          trailing:
              Icon(Icons.arrow_outward, color: Colors.white.withOpacity(0.6)),
        ),
      ),
    );
  }
}
