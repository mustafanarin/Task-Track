import 'package:flutter/material.dart';
import 'package:todo_app/product/constants/project_colors.dart';

@immutable
class LightTheme {
  ThemeData getThemeData() => ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
            backgroundColor: ProjectColors.white,
            scrolledUnderElevation: 0,
            elevation: 0,
            centerTitle: true),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                textStyle: _titleMediumStyle,
                elevation: 0,
                backgroundColor: ProjectColors.iris,
                foregroundColor: ProjectColors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ))),
        dialogTheme: DialogThemeData(
          titleTextStyle: _titleMediumStyle.copyWith(fontSize: 20),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all(
                _titleMediumStyle.copyWith(color: Colors.red)),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.iris),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        )),
        textTheme: const TextTheme(
            titleLarge: _titleLargeStyle,
            titleMedium: _titleMediumStyle,
            titleSmall: _titleSmallStyle),
        scaffoldBackgroundColor: ProjectColors.white,
      );
}

const _titleLargeStyle = TextStyle(
    fontFamily: "Roboto",
    color: ProjectColors.iris,
    fontWeight: FontWeight.w600,
    fontSize: 24);

const _titleMediumStyle = TextStyle(
    fontFamily: "Roboto",
    color: ProjectColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 18);

const _titleSmallStyle = TextStyle(
    fontFamily: "Roboto",
    color: ProjectColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 16);
