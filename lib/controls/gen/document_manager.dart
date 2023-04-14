//import 'dart:html';
import 'dart:io';
import 'package:YaSe/controls/bloc_controls/py_code/py_code_bloc.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import './../../utils/menu_utils.dart';
import '../bloc_controls/py_code/py_code_controller_token.dart';
import '/yase/yase.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import './../../utils/file_utils.dart';
import './../../utils/button_utils.dart';
import './../../utils/dlg_utils.dart';
import './../../utils/tab_utils.dart';
import './../../utils/python_utils.dart';
import '../bloc_controls/py_code/py_editor.dart';
import '../bloc_controls/doc_provider/document.dart';
import './../../controls/header.dart';
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
    var filename = getDefaultFullPath();
    var editor = createPyEditor(filename);
    _tabs = [
      getTabItem(defaultFilename, Icons.close, documentClose, editor.hashCode)
          as Tab
    ];
    _tabContent = [editor];
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
                final labelWidth = getTabLabelWidth(tab);
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
    PyCodeControllerToken pyCodeControllerToken = PyCodeControllerToken();
    print("PyCodeBloc : ${pyCodeControllerToken.hashCode}");
    print(
        "DocMan TextController: ${pyCodeControllerToken.getTextController().hashCode}");
    var editor = PyEditor(filename, pyCodeControllerToken);
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
      final app = YaSeApp.of(context);
      _numTabs++; // add a new tab
      String filename = fullPath ?? 'Untitled$_numTabs.py';
      var editor = createPyEditor(getDefaultFullPath());
      if (fullPath != null) {
        var contents = read(fullPath);
        editor = createPyEditor(filename);
        editor.pyCodeControllerToken.getTextController().text = contents;
      }
      var file = File(filename);
      _tabs.add(getTabItem(file.path.split(path.separator).last, Icons.close,
          documentClose, editor.hashCode) as Tab);
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
    var editor = _tabContent[_tabController.index] as PyEditor;
    String filename = "None";
    if (_documents[_tabController.index].filename != null)
      filename = _documents[_tabController.index].filename!;
    PromptUser(context, "YaSe", "Info: \r\n${filename}", "OK", "");
    setState(() {});
  }

  void documentSave() {
    var editor = _tabContent[_tabController.index] as PyEditor;
    if (editor.filename.split(path.separator).last == getDefaultFileName() ||
        editor.filename == "") {
      Navigator.pushNamed(context, "/file_save", arguments: <String, dynamic>{
        "targetFolder": YaSeApp.of(context)!.widget.YaSeAppPath,
        "title": "Save File As",
        "filter": '.py',
        "callback": () => editor.updateFilename
      });
    }
    String content = editor.pyCodeControllerToken.getTextController().text;
    write(_documents[_tabController.index].filename!, content);
    editor.setDirty(false);
    setState(() {});
  }

  int getTabIndexByEditorHashCode(int hashcode) {
    for (var i = 0; i < _tabContent.length; i++) {
      if (_tabContent[i].hashCode == hashcode) return i;
    }
    return -1;
  }

  void documentClose(int hashcode, {bool validateDirty = true}) {
    var tabIndex = getTabIndexByEditorHashCode(hashcode);
    if (tabIndex < 0) return;
    var editor = _tabContent[tabIndex] as PyEditor;
    if (validateDirty && editor.isDirty()) {
      PromptUser(context, "YaSe",
          "Save changes to ${_documents[tabIndex].filename}?", "Yes", "No",
          onTrue: () => {documentSave()},
          onFalse: () => {documentClose(tabIndex, validateDirty: false)});
    } else {
      _documents.removeAt(tabIndex);
      _tabContent.removeAt(tabIndex);
      _tabs.removeAt(tabIndex);
      _numTabs--;
      _tabController = TabController(length: _numTabs, vsync: this);
      if (tabIndex > 0) {
        _tabController.animateTo(tabIndex - 1);
      } else {
        if (_numTabs > 0)
          _tabController.animateTo(0);
        else {
          //close the editor
          Navigator.of(context).pop();
        }
      }
      setState(() {});
    }
    setState(() {});
  }

  void documentRun() {
    var editor = _tabContent[_tabController.index] as PyEditor;
    var text = editor.getPyCodeControllerToken().getTextController().text;
    String result = "";
    Future.delayed(Duration.zero, () async {
      Navigator.pushNamed(context, "/python_console",
          arguments: <String, dynamic>{
            "title": 'Ya Se',
            "body": await runPython(script: text)
          });
    });
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
