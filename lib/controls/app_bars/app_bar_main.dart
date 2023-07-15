import 'package:flutter/material.dart';

class AppBarMain extends StatefulWidget {
  List<PopupMenuItem<ListTile>>? navMenuItems;
  List<PopupMenuItem<ListTile>>? drawerItems;
  String? title;
  AppBar? appBar;

  AppBarMain({Key? key, this.navMenuItems, this.drawerItems, this.title})
      : super(key: key);
  @override
  _AppBarMainState createState() => _AppBarMainState();
}

class _AppBarMainState extends State<AppBarMain> {
  IconButton? _searchIconButton;
  List<Widget>? _widgets;
  @override
  void initState() {
    super.initState();
    _searchIconButton = IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          //implement search bar
        });
    _widgets = [
      ...<Widget>[this._searchIconButton!],
      ...widget.navMenuItems!
    ];
  }

  @override
  Widget build(BuildContext context) => widget.appBar = AppBar(
      centerTitle: true,
      automaticallyImplyLeading: true,
      title: Text(widget.title!),
      actions: this._widgets);
}
