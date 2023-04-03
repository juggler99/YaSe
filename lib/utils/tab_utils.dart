import 'package:flutter/material.dart';

var widthCharacterFactor = 10.0;
var widthWordPadding = 0.0;

Widget getTabItem(String label, IconData iconData) {
  final labelWidth = getLabelWidth(label);
  return Tab(
      child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      //color: isSelected ? Colors.blue : Colors.white,
    ),
    child: Center(
      child: SizedBox(
        height: 40,
        width: labelWidth,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                label,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(
                iconData,
                color: const Color(0xffef5145),
                size: 21,
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}

double getLabelWidth(String label) {
  return (label.length * widthCharacterFactor) + widthWordPadding;
}

double getTabLabelWidth(Tab tab) {
  if (tab.text != null) {
    return getLabelWidth(tab.text!);
  }
  if (tab.child is Container) {
    final container = tab.child as Container;
    if (container.child is SizedBox) {
      final sizedBox = container.child as SizedBox;
      return sizedBox.width!;
    } else if (container.child is Center) {
      final center = container.child as Center;
      if (center.child is SizedBox) {
        final child = center.child as SizedBox;
        return child.width!;
      }
    }
  }
  // return a default value
  return 80.0;
}