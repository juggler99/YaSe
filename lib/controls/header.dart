import 'package:flutter/material.dart';
import '../../utils/button_utils.dart';
import 'dart:developer';

class Header extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  List<Widget>? items;
  TabController? tabController;
  List<Widget>? tabs;
  Widget? tabBar;
  double? toolbarHeight;

  Header({
    Key? key,
    this.toolbarHeight,
    this.items,
    this.title,
    this.tabController,
    this.tabs,
    this.tabBar,
  }) : super(key: key);

  //@override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    print("Header build");
    var targetSize = preferredSize;
    print("targetSize: $targetSize, toolbarHeight: $toolbarHeight");
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    var _text = Text(this.title!, style: textStyle);
    if (this.items?.isEmpty ?? true)
      _text = Text(this.title!, style: textStyle, textAlign: TextAlign.center);
    var prefHeight = toolbarHeight ?? 80;
    var prefSize = Size.fromHeight(prefHeight);
    var prefSizeObject = null;
    if (this.tabBar == null) {
      prefSizeObject = PreferredSize(preferredSize: prefSize, child: Text(""));
    } else {
      prefSizeObject =
          PreferredSize(preferredSize: prefSize, child: this.tabBar!);
    }
    if (this.tabBar == null) {
      return AppBar(
          toolbarHeight: toolbarHeight,
          backgroundColor: Theme.of(context).primaryColor,
          title: _text,
          actions: this.items);
    }
    return AppBar(
        toolbarHeight: toolbarHeight,
        backgroundColor: Theme.of(context).primaryColor,
        title: _text,
        actions: this.items,
        bottom: prefSizeObject);
  }
}
