import 'dart:io';

import 'package:flutter/material.dart';
import '../../utils/dlg_utils.dart';
import 'package:path/path.dart' as path;
import '../../utils/file_utils.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import '../../controls/header.dart';
import '../../utils/button_utils.dart';
import 'dart:developer';

typedef void CallbackFunction(String? fullPath);

class FileSaveDialog extends StatefulWidget {
  String? targetFolder;
  String? title;
  String? filter;
  CallbackFunction? callback;

  FileSaveDialog({this.targetFolder, this.title, this.filter, this.callback});

  @override
  _FileSaveDialogState createState() => _FileSaveDialogState();
}

class _FileSaveDialogState extends State<FileSaveDialog>
    with TickerProviderStateMixin {
  int _numTabs = 1;
  late TabController _tabController;
  late ScrollController _scrollController;
  late List<Tab> _tabs = <Tab>[];
  late List<Widget> _tabContent;
  late String defaultPath;
  late TreeViewController treeViewController;

  List<Node> _nodes = [];

  @override
  void initState() {
    super.initState();
  }

  String fileSelect() {
    return "Hello";
  }

  List<Widget> HeaderItems() {
    List<Widget> headerItems = [];
    headerItems.add(getIconButton(context, Icons.add, 'Select', () {
      fileSelect();
    }, 1));
    return headerItems;
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic?>;

    var header =
        Header(toolbarHeight: 100, title: args["title"], items: HeaderItems());

    List<Node<FileSystemEntity>> _nodes =
        listFiles(context, args["targetFolder"]!, args["filter"]!);

    treeViewController = TreeViewController(children: _nodes);

    return Scaffold(
      appBar: header,
      body: TreeView(
          controller: treeViewController,
          allowParentSelect: false,
          supportParentDoubleTap: false,
          //onExpansionChanged: _expandNodeHandler,
          onNodeTap: (key) {
            args["callback"]!(key);
            Navigator.pop(context);
          }),
      bottomSheet: BottomAppBar(
        child: Container(
          child: Row(children: [
            Expanded(
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'File Name',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'File Extension',
                  ),
                ),
              ),
            ),
          ]),
          height: 50.0,
        ),
      ),
    );
  }
}
