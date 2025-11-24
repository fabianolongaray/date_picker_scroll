import 'package:flutter/material.dart';

class DatePickerOptions {
  const DatePickerOptions({
    this.itemExtent = 30.0,
    this.diameterRatio = 3,
    this.perspective = 0.01,
    this.isLoop,
    this.backgroundColor = Colors.white,
    this.indicatorColor,
    this.indicatorBorderRadius,
  });

  /// Size of each child in the main axis
  final double itemExtent;

  /// {@macro flutter.rendering.wheelList.diameterRatio}
  final double diameterRatio;

  /// {@macro flutter.rendering.wheelList.perspective}
  final double perspective;

  /// Optional boolean to define if all/none scrollViews should loop
  final bool? isLoop;

  /// The color to paint behind the date picker
  final Color backgroundColor;

  /// The color of the indicator displayed in the center of the ScrollDatePicker
  final Color? indicatorColor;

  /// The border radius of the indicator displayed in the center of the ScrollDatePicker
  final BorderRadius? indicatorBorderRadius;
}
