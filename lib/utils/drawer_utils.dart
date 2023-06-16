import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';

/// Returns a [Drawer] with the given [listTileItems] and [headerHeight]
Drawer getListViewAsDrawer(BuildContext context, double? headerHeight,
    String label, List<ListTile> listTileItems,
    {List<double> edgeItems = const [0, 0, 0, 0]}) {
  List<Widget> listViewItems = [
    Container(
      height: headerHeight,
      child: DrawerHeader(
        decoration: BoxDecoration(
            color: YaSeApp.of(context)!.widget.AppTheme.primaryColor),
        child: Text(label),
      ),
    ),
  ];
  listViewItems.addAll(listTileItems);
  return Drawer(
      child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.fromLTRB(
              edgeItems[0], edgeItems[1], edgeItems[2], edgeItems[3]),
          children: listViewItems));
}
