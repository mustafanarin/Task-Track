import 'package:flutter/material.dart';

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
        return [Colors.green.shade400, Colors.green.shade800];
      case CategoryId.continueTask:
        return [Colors.blue.shade400, Colors.blue.shade800];
      case CategoryId.finishTask:
        return [Colors.red.shade400, Colors.red.shade800];
    }
  }

}