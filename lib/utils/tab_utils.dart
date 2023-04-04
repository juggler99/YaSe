import 'package:flutter/material.dart';
import 'dart:developer';

var widthCharacterFactor = 8.0;
var widthWordPadding = 20.0;

Widget getTabItem(
    String label, IconData iconData, Function callback, int tabIndex) {
  final labelWidth = getLabelWidth(label);
  return Tab(
      child: Container(
    constraints: BoxConstraints(
      maxWidth: 500, // Set the maximum width of the row
    ),
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
              child: InkWell(
                  onTap: () => callback(tabIndex),
                  child: Icon(
                    iconData,
                    color: const Color(0xffef5145),
                    size: 24,
                  )),
            ),
          ],
        ),
      ),
    ),
  ));
}

double getLabelWidth(String label) {
  var newLen = (label.length * widthCharacterFactor) + widthWordPadding;
  print(
      "getLabelWidth: $label length: ${label.length} newlen: $newLen widthCharacterFactor: $widthCharacterFactor  widthWordPadding: $widthWordPadding");
  return newLen;
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
