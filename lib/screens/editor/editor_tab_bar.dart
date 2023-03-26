import 'package:flutter/material.dart';

class EditorTabBar extends StatefulWidget {
  const EditorTabBar({Key? key}) : super(key: key);
  @override
  _EditorTabBarState createState() => _EditorTabBarState();
}

class _EditorTabBarState extends State<EditorTabBar>
    with TickerProviderStateMixin {
  List<Tab> tabList = [
    Tab(
      text: 'untitled',
    ),
    Tab(text: "+")
  ];

  TabController? _tabController;
  double screenSize = 100;
  double screenRatio = 1;
  Color bgColor = Colors.white;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[],
    );
  }
}
