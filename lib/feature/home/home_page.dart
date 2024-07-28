import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/constants/project_strings.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _bottomNavIndex = 0;
  List<IconData> icons = [
    Icons.home,
    Icons.person
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: RichText(text: TextSpan(text: ProjectStrings.appName1,style: context.textTheme().titleLarge?.copyWith(color: ProjectColors.black),children: [TextSpan(text: ProjectStrings.appName2,style: context.textTheme().titleLarge)])),
    ),
   floatingActionButton: SizedBox(height: context.dynamicHeight(0.1),
   width: context.dynamicHeight(0.1),
     child: FloatingActionButton(
      backgroundColor: ProjectColors.iris,
      shape: StadiumBorder(),
      onPressed: () {  },
      child: Icon(Icons.add,color: ProjectColors.white,size: 30,),
        //
     ),
   ),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: AnimatedBottomNavigationBar(
      iconSize: 30,
      backgroundColor: Colors.white,
      inactiveColor: ProjectColors.grey,
    activeColor: ProjectColors.iris,
      icons: icons,
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      onTap: (index) => setState(() => _bottomNavIndex = index),
      //other params
   ),
   body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardWidget(title: 'New Added', color: Colors.green),
            CardWidget(title: 'Continues', color: Colors.amber),
            CardWidget(title: 'Finished', color: Colors.blue),
          ],
        ),
);
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final Color color;

  CardWidget({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: context.paddingHorizontalHeigh,
      child: Card(
        color:  color,
        child: SizedBox(
          width: context.dynamicWidht(1),
          height: 170,    
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}