import 'package:flutter/material.dart';

Container getTextFieldContainer(String label, double maxWidth,
    {double edgeInset = 10,
    void Function()? onTap = null,
    bool readOnly = false}) {
  return Container(
    constraints: BoxConstraints(maxWidth: maxWidth),
    padding: EdgeInsets.all(edgeInset),
    child: TextField(
      controller: TextEditingController(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      onTap: onTap,
      readOnly: readOnly,
    ),
  );
}
