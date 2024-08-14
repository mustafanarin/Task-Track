import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';
import 'package:todo_app/service/task_service.dart';

@RoutePage()
class TaskDetailPage extends ConsumerStatefulWidget {
  const TaskDetailPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends ConsumerState<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Task Detail"),
        ),
        body: Center(
          child: Padding(
              padding: context.paddingHorizontalMedium,
              child: const EnhancedCard(
                title: 'her gün yarım saat yürüyüş',
                description:
                    'asdasmdjasasdasmdjasasdasmdjasasdasmdjasasdasmdjasasdasmdjasasdasmdjasasda smdjasasdasmdjas',
                rating: 3,
              )),
        ));
  }
}

class EnhancedCard extends StatelessWidget {
  final String title;
  final String description;
  final int rating;

  const EnhancedCard({
    super.key,
    required this.title,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final model = TaskModel(userId: TaskService().userId);
    return SizedBox(
      height: context.dynamicHeight(0.5),
      child: GestureDetector(
        onTap: () => context.pushRoute(TaskEditRoute()),
        child: Card(
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green.shade400, Colors.green.shade800],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: context.dynamicWidht(0.8),
                          child: Text(title,
                              style: context
                                  .textTheme()
                                  .titleLarge
                                  ?.copyWith(color: Colors.white)),
                        ),
                      ),
                      const Icon(
                        Icons.fitness_center_outlined,
                        color: ProjectColors.white,
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_outward, color: Colors.white70),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9), fontSize: 16),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Text("12 Ağustos",
                          style: context.textTheme().titleSmall?.copyWith(
                              color: Colors.black.withOpacity(0.5)))),
                  const Spacer(),
                  const SizedBox(height: 16),
                  Text("Category: New",
                      style: context
                          .textTheme()
                          .titleMedium
                          ?.copyWith(color: Colors.black.withOpacity(0.5))),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        RatingBar.builder(
                          ignoreGestures: true,
                          itemSize: 20,
                          initialRating: rating.toDouble(),
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
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$rating/5',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
