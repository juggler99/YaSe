import 'package:flutter/material.dart';
import './../../utils/dropdown_utils.dart';
import './../../utils/dropdownlist.dart';
import './../../utils/button_utils.dart';
import './../../utils/theme_utils.dart';
import './../controls/bloc_controls/theme_manager/theme_manager.dart';
import 'package:tuple/tuple.dart';

import 'dart:developer';

class EditorControlPanelCustom extends StatefulWidget {
  String title = 'title';
  CustomDropdown<ThemeData> dropdown = CustomDropdown<ThemeData>();
  List<Tuple3<String, String, VoidCallback>>? iconItems = [];
  ThemeManager? themeManager;

  EditorControlPanelCustom(
      {Key? key, required this.dropdown, this.iconItems, this.themeManager})
      : super(key: key);

  @override
  _EditorControlPanelCustomState createState() =>
      _EditorControlPanelCustomState();
}

class _EditorControlPanelCustomState extends State<EditorControlPanelCustom> {
  @override
  Widget build(BuildContext context) {
    var themeDropdown = widget.dropdown;
    List<Widget> rowItems = [
      Expanded(
          flex: 7,
          child: SizedBox(width: 200, height: 50, child: themeDropdown))
    ];
    for (int i = 0; i < widget.iconItems!.length; i++) {
      rowItems.add(getIconButtonFromAsset(widget.iconItems![i].item1,
          widget.iconItems![i].item2, widget.iconItems![i].item3, 1));
    }

    return SizedBox(
        width: 300,
        height: 50,
        child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
            child: Row(
              children: rowItems,
            )));
  }
}
