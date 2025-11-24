import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_scroll/date_picker_scroll.dart';
import 'package:date_picker_scroll/src/extensions/string_extension.dart';

class DateScrollView extends StatelessWidget {
  const DateScrollView({
    Key? key,
    required this.onChanged,
    required this.dates,
    required this.controller,
    required this.options,
    required this.scrollViewOptions,
    required this.selectedIndex,
    required this.locale,
    required this.onTap,
  }) : super(key: key);

  /// A controller for scroll views whose items have the same size.
  final FixedExtentScrollController controller;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<int> onChanged;

  /// This is a list of dates.
  final List dates;

  /// A set that allows you to specify options related to ListWheelScrollView.
  final DatePickerOptions options;

  /// A set that allows you to specify options related to ScrollView.
  final ScrollViewDetailOptions scrollViewOptions;

  /// The currently selected date index.
  final int selectedIndex;

  /// Set calendar language
  final Locale locale;

  /// Adds the onTap property to enable clicking to navigate dates.
  ///
  /// The onTap property allows users to navigate dates by clicking on them.
  final ValueChanged<int> onTap;

  double _getScrollViewWidth(BuildContext context) {
    final padding = scrollViewOptions.horizontalPadding * 2;
    if (scrollViewOptions.width != null) {
      return scrollViewOptions.width! + padding;
    }

    double textWidth = 0;
    for (final date in dates) {
      final text = '$date${scrollViewOptions.label}';
      final selectedWidth = text.width(
        context,
        style: scrollViewOptions.selectedTextStyle,
      );
      final unselectedWidth = text.width(
        context,
        style: scrollViewOptions.textStyle,
      );
      textWidth = max(textWidth, max(selectedWidth, unselectedWidth));
    }

    if (locale.languageCode == ar) {
      return textWidth + 40;
    }

    return textWidth + 8 + padding;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int _maximumCount = constraints.maxHeight ~/ options.itemExtent;
        return Container(
          margin: scrollViewOptions.margin,
          width: _getScrollViewWidth(context),
          child: ListWheelScrollView.useDelegate(
            itemExtent: options.itemExtent,
            diameterRatio: options.diameterRatio,
            controller: controller,
            physics: const FixedExtentScrollPhysics(),
            perspective: options.perspective,
            onSelectedItemChanged: onChanged,
            childDelegate: options.isLoop ??
                    scrollViewOptions.isLoop && dates.length > _maximumCount
                ? ListWheelChildLoopingListDelegate(
                    children: List<Widget>.generate(
                      dates.length,
                      (index) => _buildDateView(index: index),
                    ),
                  )
                : ListWheelChildListDelegate(
                    children: List<Widget>.generate(
                      dates.length,
                      (index) => _buildDateView(index: index),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildDateView({required int index}) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: scrollViewOptions.horizontalPadding,
        ),
        alignment: scrollViewOptions.alignment,
        child: Text(
          '${dates[index]}${scrollViewOptions.label}',
          style: selectedIndex == index
              ? scrollViewOptions.selectedTextStyle
              : scrollViewOptions.textStyle,
          textScaler: TextScaler.linear(scrollViewOptions.textScaleFactor),
          textAlign: scrollViewOptions.textAlign,
        ),
      ),
    );
  }
}
