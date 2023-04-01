//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '/yase/yase.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:flutter_gen/utils/file_utils.dart';
import 'package:flutter_gen/utils/button_utils.dart';
import 'package:flutter_gen/utils/dlg_utils.dart';
import '../bloc_controls/py_code/py_editor.dart';
import '../bloc_controls/doc_provider/document.dart';
import 'package:flutter_gen/controls/header.dart';
import 'dart:developer';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

class DocumentManager extends StatefulWidget {
  @override
  _DocumentManagerState createState() => _DocumentManagerState();
}

class _DocumentManagerState extends State<DocumentManager>
    with TickerProviderStateMixin {
  int _numTabs = 1;
  late TabController _tabController;
  late ScrollController _scrollController;
  late List<Tab> _tabs;
  late List<Widget> _tabContent;
  late List<Document> _documents;
  late String defaultPath;

  @override
  void initState() {
    print("Document Manager Initstate");
    super.initState();
    _tabController = TabController(length: _numTabs, vsync: this);
    _scrollController = ScrollController();
    String defaultFilename = "Untitled1.py";
    _tabs = [Tab(text: "Untitled1.py")];
    var filename = getDefaultFullPath();
    _tabContent = [createPyEditor(filename)];
    _documents = [];
    DocumentAddToList(context, defaultFilename, "YaSe", "", _documents);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    double screenWidth = MediaQuery.of(context).size.width;
    var tabWidth = screenWidth / _tabController.length;
    _scrollController.animateTo(
      _tabController.index * tabWidth,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Align createTabBar() {
    Color? colorTab = Theme.of(context).primaryColor.withOpacity(0.3);
    Color? colorTabBackground = Theme.of(context).primaryColor.withOpacity(0.1);
    Color? colorTabSelected = Theme.of(context).primaryColor.withOpacity(0.5);
    print(
        "colorTab: ${colorTab.alpha} colorTabBackground: ${colorTabBackground.alpha} colorTabSelected: ${colorTabSelected.alpha}");
    colorTab = Colors.orange[300];
    colorTabBackground = Colors.orange[100];
    colorTabSelected = Colors.orange[500];
    BorderSide borderSide = BorderSide(color: colorTabSelected!);
    BorderSide borderSide0 = BorderSide(color: colorTabSelected, width: 0.0);
    Border border = Border(
        top: borderSide,
        left: borderSide,
        right: borderSide,
        bottom: borderSide);
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(0.0),
            color: colorTabBackground, // set the color in between the tabs
            child: TabBar(
              indicatorPadding: EdgeInsets.symmetric(horizontal: -8.0),
              padding: EdgeInsets.all(0.0),
              isScrollable: true,
              tabs: _tabs.map((tab) {
                final label = tab.text ?? '';
                final labelWidth =
                    (label.length * 10.0) + 40.0; // calculate label width
                return Container(
                  height: 32,
                  width: labelWidth,
                  decoration: BoxDecoration(
                      border: border,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8))),
                  child: Center(child: tab),
                );
              }).toList(),
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                color: colorTabSelected, // set the color of the indicator
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.zero,
              onTap: (index) {
                print("on Tap: $index");
              },
            )));
  }

  String getDefaultFileName() {
    return "Untitled${_numTabs}.py";
  }

  String getDefaultFullPath() {
    return concatPaths(
        [YaSeApp.of(context)!.widget.YaSeAppPath, getDefaultFileName()]);
  }

  TabBarView createTabView() {
    print("createTabView");
    return TabBarView(
      children: List.generate(
        _numTabs,
        (index) => index < _tabContent.length
            ? _tabContent[index]
            : createPyEditor(getDefaultFullPath()),
      ),
      controller: _tabController,
    );
  }

  PyEditor createPyEditor(String filename) {
    var stateKey = GlobalKey<PyEditorState>();
    var editor = PyEditor(filename, key: stateKey);
    return editor;
  }

  List<Widget> HeaderItems() {
    List<Widget> headerItems = [];
    headerItems.add(getIconButton(context, Icons.add, 'Add', () {
      documentAdd(null);
    }, 1));
    headerItems
        .add(getIconButton(context, Icons.file_open_outlined, 'Open', () {
      documentOpen(() => createPyEditor(getDefaultFullPath()));
    }, 1));
    headerItems.add(getIconButton(context, Icons.save, 'Save', () {
      documentSave();
    }, 1));
    headerItems.add(getIconButton(context, Icons.info, 'Info', () {
      documentInfo();
    }, 1));
    headerItems.add(getIconButton(context, Icons.arrow_right, 'Run', () {
      documentRun();
    }, 1, iconSize: 42));
    return headerItems;
  }

  void documentAdd(String? fullPath) {
    setState(() {
      debugger();
      final app = YaSeApp.of(context);
      _numTabs++; // add a new tab
      String filename = fullPath ?? 'Untitiled$_numTabs.py';
      var editor = createPyEditor(getDefaultFullPath());
      if (fullPath != null) {
        var contents = read(fullPath);
        debugger();
        editor = createPyEditor(filename);
        var globalEditorKey = editor.key as GlobalKey<PyEditorState>;
        globalEditorKey.currentState!.setContents(contents);
      }
      var file = File(filename);
      _tabs.add(Tab(text: file.path.split(path.separator).last));
      _tabContent.add(editor);
      _tabController = TabController(length: _numTabs, vsync: this);
      _tabController.animateTo(_tabController.length - 1);
      DocumentAddToList(context, filename, "YaSe", "", _documents);
      //_onTabChanged();
    });
  }

  void documentOpen(createInstanceFunc) {
    Navigator.pushNamed(context, "/file_open", arguments: <String, dynamic>{
      "targetFolder": YaSeApp.of(context)!.widget.YaSeAppPath,
      "title": "Open File",
      "filter": '.py',
      "callback": documentAdd
    });
  }

  void documentInfo() {
    debugger();
    var editor = _tabContent[_tabController.index] as PyEditor;
    String filename = "None";
    if (_documents[_tabController.index].filename != null)
      filename = _documents[_tabController.index].filename!;
    PromptUser(context, "YaSe", "Info: \r\n${filename}", "OK", "");
    setState(() {});
  }

  void documentSave() {
    debugger();
    var editor = _tabContent[_tabController.index] as PyEditor;
    //var content = editor.contents;
    String content = "Helo World";
    write(_documents[_tabController.index].filename!, content!);
    setState(() {});
  }

  void documentRun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('Document Manager build');
    AppBar.preferredHeightFor(context, Size(double.infinity, 100));
    print("Tabs: $_tabs");
    print("Tab Content: $_tabContent");
    print("Tab Count: $_numTabs");
    var header = Header(
        toolbarHeight: 100,
        title: "Ya Se",
        items: HeaderItems(),
        tabs: _tabs,
        tabController: _tabController,
        tabBar: createTabBar());
    var docManager = DefaultTabController(
      length: _numTabs,
      child: Scaffold(
        appBar: header,
        body: createTabView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _numTabs++; // add a new tab
              _tabs.add(Tab(text: 'Untitiled$_numTabs'));
              _tabContent.add(Text('This is Tab $_numTabs'));
              _tabController = TabController(length: _numTabs, vsync: this);
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
    return docManager;
  }
}

void DocumentAddToList(BuildContext context, String filename, String appFolder,
    String content, List<Document> documents) {
  var doc = createDocument(context, filename, appFolder, content);
  print("DocumentAddToList: ${doc.filename}");
  documents.add(doc);
}
