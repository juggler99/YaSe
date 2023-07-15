import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';

class EditorHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void addNewDocument() {}

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
        title: const Text('Ya Se'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add), iconSize: 35, onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.arrow_right),
              iconSize: 45,
              onPressed: () {})
        ]);
  }
}
