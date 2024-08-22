import 'package:flutter/material.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

@immutable
class LightTheme {
  ThemeData getThemeData(BuildContext context) => ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
            backgroundColor: ProjectColors.white,
            scrolledUnderElevation: 0,
            elevation: 0,
            centerTitle: true),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                textStyle: context.textTheme().titleMedium?.copyWith(
                  fontSize: 18,
                ),
                elevation: 0,
                backgroundColor: ProjectColors.iris,
                foregroundColor: ProjectColors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ))),
         dialogTheme: DialogTheme(
           titleTextStyle: context.textTheme().titleMedium?.copyWith(
             fontSize: 20
           ),
        ),// TODO COPY WİTH TEXT AYARLA
        textButtonTheme: TextButtonThemeData(
         style: ButtonStyle(
            textStyle: WidgetStateProperty.all(
              Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.red
              )
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.iris),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        )),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontFamily: "Roboto",
                color: ProjectColors.iris,
                fontWeight: FontWeight.w600,
                fontSize: 24),
            titleMedium: TextStyle(
                fontFamily: "Roboto",
                color: ProjectColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18),
            titleSmall: TextStyle(
                fontFamily: "Roboto",
                color: ProjectColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
        scaffoldBackgroundColor: ProjectColors.white,
      );
}

