import 'package:flutter/material.dart';

class FileManagerTabBar extends StatefulWidget {
  List<Tab>? items;
  FileManagerTabBar({Key? key, this.items}) : super(key: key);
  @override
  _FileManagerTabBarState createState() => _FileManagerTabBarState();

  Tab add(String name, Widget content) {
    var tab = Tab(text: name, child: content);
    this.items!.add(tab);
    return tab;
  }

  void remove({String? name, int index: -1}) {
    if (name == null || name.length > 0) {
      if (index > -1) {
        this.items!.removeAt(index);
      }
    }
  }
}

class _FileManagerTabBarState extends State<FileManagerTabBar> {
  @override
  void initState() {
    super.initState();
    widget.items = <Tab>[];
  }

  @override
  Widget build(BuildContext context) {
    widget.items = <Tab>[];
    return widget;
  }
}
