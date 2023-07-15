import 'dart:io';
import 'package:YaSe/yase/yase.dart';
import 'package:YaSe/controls/bloc_controls/py_code/py_editor.dart';
import 'package:YaSe/utils/panel_utils.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import '../../utils/file_utils.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import '../../controls/header.dart';
import 'dart:developer';

typedef void CallbackFunction(String? fullPath);

class FileSaveDialog extends StatefulWidget {
  String? targetFolder;
  String? title;
  String? filter;
  String? filename;
  CallbackFunction? callback;

  FileSaveDialog(
      {this.targetFolder,
      this.title,
      this.filename,
      this.filter,
      this.callback});

  @override
  _FileSaveDialogState createState() => _FileSaveDialogState();
}

class _FileSaveDialogState extends State<FileSaveDialog>
    with TickerProviderStateMixin {
  int _numTabs = 1;
  late ScrollController _scrollController;
  late String defaultPath;
  late TreeViewController treeViewController;
  late TreeView treeView;
  final TextEditingController textEditingController = TextEditingController();
  EditPanel? editPanel;
  PyEditor? editor;
  FocusNode? focusNode;

  List<Node> _nodes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> HeaderItems(TextEditingController textEditingController,
      double width, double height) {
    List<Widget> headerItems = [];
    headerItems.add(Container(
        constraints: BoxConstraints(maxWidth: width, maxHeight: height),
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'File Name',
          ),
        )));
    return headerItems;
  }

  String getFinalFilename(BuildContext context) {
    debugger();
    return path.join(widget.targetFolder!, textEditingController.text);
  }

  void _updateText() {
    print("_updateText");
    if (editPanel != null && editor != null) {
      editor?.filename = path.join(
          path.dirname(editor!.filename), editPanel?.getController().text);
      print("editor.filename: ${editor!.filename}");
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    editor = args["editor"] as PyEditor;
    var fullFilePath = (args["editor"] as PyEditor).filename;
    var filename = path.basename(fullFilePath);
    var targetFolder = path.dirname(fullFilePath);
    editPanel = getEditPanel(
        context,
        filename,
        'Save',
        () => {Navigator.pop(context, true)},
        "Cancel",
        () => {Navigator.pop(context, false)},
        height: 100,
        label: "Filename",
        focusNode: focusNode);
    List<Node<FileSystemEntity>> _nodes =
        listFiles(context, targetFolder, filename.split('.').last);

    editPanel?.getController().addListener(_updateText);

    treeViewController = TreeViewController(children: _nodes);

    treeView = TreeView(
        controller: treeViewController,
        allowParentSelect: false,
        supportParentDoubleTap: false,
        //onExpansionChanged: _expandNodeHandler,
        theme: TreeViewTheme(
          colorScheme:
              YaSeApp.of(context)!.widget.AppTheme.colorScheme.copyWith(
                    primary: Colors.grey,
                    secondary: Colors.grey,
                  ),
        ),
        onNodeTap: (key) {
          treeViewController.toggleNode(key);
          print("Node $key tapped");
          //var node = treeViewController.getNode(key);
        });

    var header = Header(toolbarHeight: 100, title: args["title"]);
    print("Selected Node: ${treeViewController.selectedKey}");

    return Scaffold(
        appBar: header,
        body: Container(
            key: Key("TreeViewContainer"),
            //color: Colors.green,
            constraints: BoxConstraints(
                maxWidth: mediaSize.width, maxHeight: mediaSize.height),
            child: treeView),
        bottomSheet: editPanel);
  }
}
