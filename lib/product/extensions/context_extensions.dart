import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext{
  double dynamicHeight(double val) => MediaQuery.sizeOf(this).height * val;
  double dynamicWidht(double val) => MediaQuery.sizeOf(this).width * val;

  TextTheme textTheme(){
    return Theme.of(this).textTheme;
  }
}

extension NumberExtension on BuildContext{
  double get lowValue1 => dynamicHeight(0.01);
  double get lowValue2 => dynamicHeight(0.02);
  double get mediumValue => dynamicHeight(0.03);
  double get highValue => dynamicHeight(0.05);
}

extension PaddingExtension on BuildContext{
  EdgeInsets get paddingAllLow1 => EdgeInsets.all(lowValue1);
  EdgeInsets get paddingAllLow2 => EdgeInsets.all(lowValue2);
  EdgeInsets get paddingHorizontalLow => EdgeInsets.symmetric(horizontal: lowValue2);
  EdgeInsets get paddingHorizontalMedium => EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHorizontalHeigh => EdgeInsets.symmetric(horizontal: highValue);
}