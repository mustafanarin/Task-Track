import 'package:flutter/material.dart';
import 'package:todo_app/product/constants/project_colors.dart';

class LightTheme{

  ThemeData themeData = ThemeData.light().copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),)
      )
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ProjectColors.iris),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      )
    ),
    textTheme:  const TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Roboto",
        color: ProjectColors.iris,
        fontWeight: FontWeight.w600,
        fontSize: 24
      ),
      titleMedium: TextStyle(
        fontFamily: "Roboto",
        color: ProjectColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18
      ),
      titleSmall: TextStyle(
        fontFamily: "Roboto",
        color: ProjectColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16
      )
    ),
  );

}