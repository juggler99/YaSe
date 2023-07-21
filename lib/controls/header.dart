import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  List<Widget>? items;
  TabController? tabController;
  List<Widget>? tabs;
  Widget? tabBar;
  double? toolbarHeight;
  bool? goBackArrow;
  bool? centerTitle;

  Header(
      {Key? key,
      this.toolbarHeight,
      this.items,
      this.title,
      this.centerTitle = true,
      this.goBackArrow = true})
      : super(key: key);

  //@override
  Size get preferredSize => const Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    print("Header build ${this.hashCode} tabBar: $tabBar ${tabBar.hashCode}");
    TextStyle? textStyle =
        YaSeApp.of(context)!.widget.AppTheme.textTheme.titleLarge;
    var _text = Text(this.title!, style: textStyle);
    if (this.items?.isEmpty ?? true)
      _text = Text(this.title!, style: textStyle, textAlign: TextAlign.center);
    var appBar = AppBar(
        toolbarHeight: toolbarHeight,
        backgroundColor:
            YaSeApp.of(context)!.widget.AppTheme.colorScheme.background,
        title: _text,
        centerTitle: this.centerTitle,
        actions: this.items,
        automaticallyImplyLeading: this.goBackArrow!);
    return appBar;
  }
}
