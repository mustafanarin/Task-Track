import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/home/viewmodel/task_crud_viewmodel.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';

@RoutePage()
class TaskListPage extends HookConsumerWidget {
  final int categoryId;
  const TaskListPage(this.categoryId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskNotifier = ref.read(taskProvider.notifier);
    final tasks = ref.watch(taskProvider);
    Future<void> fetchData() async {
      await taskNotifier.loadTasks(categoryId);
    }

    useEffect(() {
      fetchData();
      return null;
    }, [categoryId]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: Padding(
        padding: context.paddingHorizontalLow,
        child: tasks.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
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
                          label: 'Sil',
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: context.paddingAllLow1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green.shade400,
                              Colors.green.shade800
                            ],
                          ),
                        ),
                        child: ListTile(
                          onTap: () =>
                              context.pushRoute(TaskDetailRoute(model: task)),
                          title: Text(
                            task.name,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
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
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (double value) {},
                              ),
                              const Spacer(),
                              Text(
                                "${task.createdAt}",
                                style: TextStyle(
                                    color: Colors.grey[300], fontSize: 15),
                              )
                            ],
                          ),
                          leading: Icon(
                            IconData(task.iconCodePoint,
                                fontFamily: 'MaterialIcons'),
                            color: Colors.white,
                          ),
                          trailing: Icon(Icons.arrow_outward,
                              color: Colors.white.withOpacity(0.6)),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
//POPUO MENU
// PopupMenuButton(
//                   icon: const Icon(Icons.menu_outlined),
//                   onSelected: (String result) {
//                     switch (result) {
//                       case 'dialog':
//                         showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 title: const Text(
//                                   "DÜZENLE",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                                 content: const Text(
//                                   "Alert dialog",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                       onPressed: () {
//                                         print("iptal");
//                                         context.maybePop();
//                                       },
//                                       child: const Text("iptal")),
//                                   ElevatedButton(
//                                       onPressed: () {
//                                         print("kaydet");
//                                         context.maybePop();
//                                       },
//                                       child: const Text("Kaydet"))
//                                 ],
//                               );
//                             });
//                       case "delete":
//                         print("delete");
//                     }
//                   },
//                   itemBuilder: (context) => <PopupMenuEntry<String>>[
//                     const PopupMenuItem<String>(
//                       value: 'dialog',
//                       child: Text('Edit'),
//                     ),
//                     const PopupMenuItem<String>(
//                       value: 'delete',
//                       child: Text('Delete'),
//                     ),
//                   ],
//                 )
