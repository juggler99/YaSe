import 'package:flutter/material.dart';

/// Returns a [DropdownMenuItem] with the given [strItem]
DropdownMenuItem<String> makeDropdownMenuItem(String strItem) {
  final item = DropdownMenuItem(
    child: Text(strItem),
    value: strItem,
  );
  return item;
}
