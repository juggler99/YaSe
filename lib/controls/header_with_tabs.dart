import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';

class HeaderWithTabs extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  List<Widget>? items;
  TabController? tabController;
  List<Widget>? tabs;
  Widget? tabBar;
  double? toolbarHeight;

  HeaderWithTabs(
      {Key? key,
      this.toolbarHeight,
      this.items,
      this.title,
      this.tabController,
      this.tabs,
      this.tabBar})
      : super(key: key);

  //@override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    print(
        "HeaderWithTabs build ${this.hashCode} tabBar: $tabBar ${tabBar.hashCode}");
    var targetSize = preferredSize;
    print("targetSize: $targetSize, toolbarHeight: $toolbarHeight");
    TextStyle? textStyle =
        YaSeApp.of(context)!.widget.AppTheme.textTheme.titleLarge;
    var _text = Text(this.title!, style: textStyle);
    if (this.items?.isEmpty ?? true)
      _text = Text(this.title!, style: textStyle, textAlign: TextAlign.center);
    var prefHeight = toolbarHeight ?? preferredSize.height;
    var prefSize = Size.fromHeight(prefHeight);
    print('prefSize: $prefSize, prefHeight: $prefHeight');
    var prefSizeObject = null;
    prefSizeObject =
        PreferredSize(preferredSize: prefSize, child: this.tabBar!);
    return AppBar(
        toolbarHeight: 100,
        backgroundColor:
            YaSeApp.of(context)!.widget.AppTheme.colorScheme.background,
        title: _text,
        actions: this.items,
        bottom: prefSizeObject);
  }
}
