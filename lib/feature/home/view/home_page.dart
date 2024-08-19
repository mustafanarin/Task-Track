import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/feature/home/viewmodel/task_crud_viewmodel.dart';
import 'package:todo_app/product/constants/category_id_enum.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/constants/project_strings.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(taskCountProvider.notifier).updateTaskCounts();
  }

  @override
  Widget build(BuildContext context) {
    // taskCountProvider'ı dinleyerek sayfa açıldığında ve taskProvider'da değişiklik olduğunda sayıların güncellenmesini sağlıyoruz.
    // ref.listen<TaskState>(taskProvider, (previous, next) {
    //   ref.read(taskCountProvider.notifier).updateTaskCounts();
    // });

    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: ProjectStrings.appName1,
                style: context
                    .textTheme()
                    .titleLarge
                    ?.copyWith(color: ProjectColors.black),
                children: [
              TextSpan(
                  text: ProjectStrings.appName2,
                  style: context.textTheme().titleLarge)
            ])),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardWidget(
            title: 'New Added',
            color: Colors.green.shade600,
            categoryId: CategoryId.newTask.value,
            category: CategoryId.newTask, categoryName: 'New Added',
          ),
          CardWidget(
            title: 'Continues',
            color: Colors.blue.shade600,
            categoryId: CategoryId.continueTask.value,
            category: CategoryId.continueTask, categoryName: 'Continues',
          ),
          CardWidget(
            title: 'Finished',
            color: Colors.red.shade600,
            categoryId: CategoryId.finishTask.value,
            category: CategoryId.finishTask, categoryName: 'Finished',
          ),
        ],
      ),
    );
  }
}

class CardWidget extends ConsumerWidget {
  final String title;
  final Color color;
  final int categoryId;
  final CategoryId category;
  final String categoryName;

  const CardWidget( 
      {super.key,
      required this.title,
      required this.color,
      required this.categoryId,
      required this.category,
      required this.categoryName,
      });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskCount = ref.watch(taskCountProvider).taskCounts[categoryId] ?? 0;

    final List<Color> cardColor = CardColor().colorByCategory(category);

    return Padding(
      padding: context.paddingHorizontalHeigh,
      child: GestureDetector(
        onTap: () => context.pushRoute(TaskListRoute(
            categoryId: categoryId, category: category, categoryName: categoryName)),
        child: Card(
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: cardColor,
              ),
            ),
            width: context.dynamicWidht(1),
            height: 170,
            child: Center(
              child: Text(
                '$title ($taskCount)',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
