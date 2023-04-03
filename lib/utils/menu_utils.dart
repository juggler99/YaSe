import 'package:flutter/material.dart';
import 'dart:developer';

class ExtendedMenu extends StatefulWidget {
  @override
  _ExtendedMenuState createState() => _ExtendedMenuState();
}

class _ExtendedMenuState extends State<ExtendedMenu> {
  int selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                    child: DropdownButton(
                  value: selectedValue,
                  items: [
                    DropdownMenuItem(
                      child: Text("Male"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Female"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("Other"),
                      value: 3,
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedValue = int.parse(value.toString());
                    });
                  },
                )))));
  }
}

/// Returns a [PopupMenuButton] with the given [listTileItems] and [headerHeight]
PopupMenuItem<ListTile> getPopupMenuItemNav(
    BuildContext context, IconData? argIcon, String label, String NavTarget,
    {bool allowBack = true,
    bool popPrev = true,
    List<double> edgeItems = const [0, 0, 0, 0]}) {
  Icon? icon = argIcon != null ? Icon(argIcon) : null;
  return PopupMenuItem<ListTile>(
      child: getListTile(context, icon, label, NavTarget));
}

/// Returns a [ListTile] item with given icon, label and NavegationTarget
ListTile getListTile(
    BuildContext context, Icon? icon, String label, String NavTarget,
    {bool allowBack = true,
    bool popPrev = true,
    List<double> edgeItems = const [0, 0, 0, 0]}) {
  if (!NavTarget.startsWith('/')) {
    NavTarget = '/' + NavTarget;
  }
  return ListTile(
    contentPadding: EdgeInsets.fromLTRB(
        edgeItems[0], edgeItems[1], edgeItems[2], edgeItems[3]),
    leading: icon,
    title: Text(label),
    onTap: () {
      if (popPrev) {
        Navigator.pop(context);
      }
      if (allowBack) {
        Navigator.pushNamed(context, NavTarget);
      } else {
        Navigator.pushReplacementNamed(context, NavTarget);
      }
    },
  );
}
