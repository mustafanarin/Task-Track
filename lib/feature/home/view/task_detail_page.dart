import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:todo_app/product/constants/category_id_enum.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/constants/project_strings.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';

@RoutePage()
class TaskDetailPage extends ConsumerStatefulWidget {
  final TaskModel model;
  final CategoryId category;
  const TaskDetailPage(this.model, this.category, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends ConsumerState<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(ProjectStrings.taskDetailAppbarTitle),
        ),
        body: Center(
          child: Padding(
              padding: context.paddingHorizontalMedium,
              child: _EnhancedCard(
                model: widget.model,
                title: widget.model.name,
                description: widget.model.description,
                rating: widget.model.importance,
                categoryName: widget.model.category,
                date: widget.model.createdAt ?? "",
                iconCodePoint: widget.model.iconCodePoint, 
                category: widget.category,
              )),
        ));
  }
}

class _EnhancedCard extends StatelessWidget {
  final TaskModel model;
  final String title;
  final String description;
  final int rating;
  final String categoryName;
  final String date;
  final int iconCodePoint;
  final CategoryId category;

  const _EnhancedCard({
    required this.model,
    required this.title,
    required this.description,
    required this.rating,
    required this.categoryName,
    required this.date,
    required this.iconCodePoint, 
    required this.category,
  });

  @override
  Widget build(BuildContext context) {

    final List<Color> cardColor = CardColor().colorByCategory(category);

    return SizedBox(
      height: context.dynamicHeight(0.5),
      child: GestureDetector(
        onTap: () => context.pushRoute(TaskEditRoute(model: model)),
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
            child: Padding(
              padding: context.paddingAllLow2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  _TaskTitleAndIconRow(title: title, iconCodePoint: iconCodePoint),
                  SizedBox(height: context.lowValue1),
                  _TextDescription(description: description),
                  const Spacer(),
                  _TextTaskDate(date: date),
                  SizedBox(height: context.lowValue1),
                  _TextCategoryName(categoryName: categoryName),
                  SizedBox(height: context.lowValue1),
                  _RatingBarRow(rating: rating),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TaskTitleAndIconRow extends StatelessWidget {
  const _TaskTitleAndIconRow({
    super.key,
    required this.title,
    required this.iconCodePoint,
  });

  final String title;
  final int iconCodePoint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            width: context.dynamicWidht(0.8),
            child: Text(title,
                style: context
                    .textTheme()
                    .titleLarge
                    ?.copyWith(color: ProjectColors.white)),
          ),
        ),
        Icon(
          IconData(iconCodePoint, fontFamily: "MaterialIcons"),
          color: ProjectColors.white,
        ),
        const Spacer(),
        const Icon(Icons.arrow_outward, color: Colors.white70),
      ],
    );
  }
}

class _TextDescription extends StatelessWidget {
  const _TextDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: context.textTheme().titleSmall?.copyWith(color: ProjectColors.white.withOpacity(0.9)),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _TextTaskDate extends StatelessWidget {
  const _TextTaskDate({
    super.key,
    required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: Text(date,
            style: context.textTheme().titleSmall?.copyWith(
                color: ProjectColors.black.withOpacity(0.5))));
  }
}

class _TextCategoryName extends StatelessWidget {
  const _TextCategoryName({
    super.key,
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Text("Category: $categoryName",
        style: context
            .textTheme()
            .titleMedium
            ?.copyWith(color: ProjectColors.black.withOpacity(0.5)));
  }
}

class _RatingBarRow extends StatelessWidget {
  const _RatingBarRow({
    super.key,
    required this.rating,
  });

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              color: ProjectColors.amber,
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
            color: ProjectColors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$rating/5',
            style: const TextStyle(
                color: ProjectColors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
