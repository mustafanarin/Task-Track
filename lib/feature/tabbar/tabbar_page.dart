import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_app/feature/home/views/home_page.dart';
import 'package:todo_app/feature/profile/view/profile_page.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';


@RoutePage()
class TabbarPage extends StatefulHookWidget {
  const TabbarPage({super.key});

  @override
  _TabbarPageState createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  final List<IconData> _icons = [Icons.home, Icons.person];
  final List<Widget> _pages = [const HomePage(), const ProfilePage()];
  

  @override
  Widget build(BuildContext context) {
    final bottomNavIndex = useState<int>(0);
    return Scaffold(
      floatingActionButton: SizedBox(
        height: context.dynamicHeight(0.1),
        width: context.dynamicHeight(0.1),
        child: FloatingActionButton(
          backgroundColor: ProjectColors.iris,
          shape: const CircleBorder(),
          onPressed: () {
            context.pushRoute(const TaskAddRoute());
          },
          child: const Icon(
            Icons.add,
            color: ProjectColors.white,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: 30,
        backgroundColor: ProjectColors.iris,
        inactiveColor: ProjectColors.grey,
        activeColor: ProjectColors.white,
        icons: _icons,
        activeIndex: bottomNavIndex.value,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          bottomNavIndex.value = index;
        },
      ),
      body: IndexedStack(
        index: bottomNavIndex.value,
        children: _pages,
      ),
    );
  }
}
