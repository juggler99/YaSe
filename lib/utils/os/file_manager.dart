import 'dart:io';
import '/yase/yase.dart';
import 'package:flutter/material.dart';
import '../../utils/file_utils.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import '../../controls/header.dart';
import '../../utils/button_utils.dart';
import 'dart:developer';

typedef void CallbackFunction(String? fullPath);

class FileManagerDialog extends StatefulWidget {
  String? targetFolder;
  String? title;
  String? filter;
  CallbackFunction? callback;

  FileManagerDialog(
      {this.targetFolder, this.title, this.filter, this.callback});

  @override
  _FileManagerDialogState createState() => _FileManagerDialogState();
}

class _FileManagerDialogState extends State<FileManagerDialog>
    with TickerProviderStateMixin {
  int _numTabs = 1;
  late ScrollController _scrollController;
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

  Future<void> showContextMenu(BuildContext context, Offset offset) async {
    debugger();
    await showMenu<Function>(
      context: context,
      position: RelativeRect.fromLTRB(0, 0, 100, 100),
      items: [
        PopupMenuItem(
          value: () => print("New Folder"),
          child: Text("New Folder"),
        ),
        PopupMenuItem(
          value: () => print("New File"),
          child: Text("New File"),
        ),
        PopupMenuItem(
          value: () => print("Delete"),
          child: Text("Delete"),
        ),
        //PopupMenuDivider(),
        PopupMenuItem(
          value: () => print("Rename"),
          child: Text("Rename"),
        ),
      ],
    );
  }

  Widget customTreeNode(BuildContext context, Node treeNode) {
    //debugger();
    return GestureDetector(
        onLongPress: () async {
          var renderBox = context.findRenderObject() as RenderBox;
          var offset = renderBox.localToGlobal(Offset.zero);
          await showContextMenu(context, offset);
        },
        child: Container(
            color: Colors.transparent,
            child: Row(children: [
              Icon(Icons.folder),
              Text(treeNode.label),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args;
    var protoArgs = ModalRoute.of(context)!.settings.arguments;
    String title = "File Manager";
    String targetFolder = YaSeApp.of(context)!.widget.YaSeAppPath;
    Function callback = (key) {};
    if (protoArgs != null) {
      args = protoArgs as Map<String, dynamic>;
      title = args["title"];
      callback = args["callback"];
    }
    print("file_manager, build");
    var header = Header(toolbarHeight: 100, title: title, items: HeaderItems());

    List<Node<FileSystemEntity>> _nodes = listFiles(context, targetFolder, "");

    treeViewController = TreeViewController(children: _nodes);

    return Scaffold(
      appBar: header,
      body: TreeView(
          controller: treeViewController,
          allowParentSelect: false,
          supportParentDoubleTap: false,
          nodeBuilder: customTreeNode,
          //onExpansionChanged: _expandNodeHandler,
          onNodeTap: (key) async {
            debugger();
            var renderBox = context.findRenderObject() as RenderBox;
            var offset = renderBox.localToGlobal(Offset.zero);
            await showContextMenu(context, offset);
          }),
    );
  }
}
