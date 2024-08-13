import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';

@RoutePage()
class TaskListPage extends ConsumerStatefulWidget {
  const TaskListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskDetailState();
}

class _TaskDetailState extends ConsumerState<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Tasks"),
      ),
      body: Padding(
        padding: context.paddingHorizontalLow,
        child: ListView.builder(itemBuilder: (context, index) {
          return Card(
            color: Colors.pink[50],
            child: ListTile(
                onTap: () => context.pushRoute(const TaskDetailRoute()),
                title: const Text(
                  "Sinemaya git",
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Row(
                  children: [
                    RatingBar.builder(
                      ignoreGestures: true,
                      itemSize: 20,
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const Spacer(),
                    const Text(
                      "12 Ağustos",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    )
                  ],
                ),
                leading: const Icon(Icons.fitness_center_outlined),
                ),
          );
        }),
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