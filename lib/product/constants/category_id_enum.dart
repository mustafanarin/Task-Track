import 'package:flutter/material.dart';
import 'package:todo_app/product/constants/project_colors.dart';

enum CategoryId {
  newTask(1),
  continueTask(2),
  finishTask(3);

  final int value;
  const CategoryId(this.value);
}

class CardColor{

  List<Color> colorByCategory(CategoryId categoryId) {
    switch (categoryId) {
      case CategoryId.newTask:
        return [ProjectColors.green400, ProjectColors.green800];
      case CategoryId.continueTask:
        return [ProjectColors.blue400, ProjectColors.blue800];
      case CategoryId.finishTask:
        return [ProjectColors.red400, ProjectColors.red800];
    }
  }

}