import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/constants/project_strings.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardWidget(title: 'New Added', color: Colors.green, categoryId: 1,),
          CardWidget(title: 'Continues', color: Colors.amber, categoryId: 2,),
          CardWidget(title: 'Finished', color: Colors.blue, categoryId: 3,),
        ],
      ),
    );
  }
}
// enum oluştur new continue finish diye bunlara değe roalrak 1 2 3 ver burda direkt yazma
//

class CardWidget extends StatelessWidget {
  final String title;
  final Color color;
  final int categoryId;

  const CardWidget({super.key, required this.title, required this.color, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingHorizontalHeigh,
      child: GestureDetector(
        onTap: () => context.pushRoute(TaskListRoute(categoryId: categoryId)),
        child: Card(
          color: color,
          child: SizedBox(
            width: context.dynamicWidht(1),
            height: 170,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
