//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import '../bloc_controls/py_code/py_code_controller_token.dart';
import '/yase/yase.dart';
import './../../utils/file_utils.dart';
import './../../utils/button_utils.dart';
import './../../utils/dlg_utils.dart';
import './../../utils/tab_utils.dart';
import './../../utils/python_utils.dart';
import '../bloc_controls/py_code/py_editor.dart';
import '../bloc_controls/doc_provider/document.dart';
import './../../controls/header_with_tabs.dart';
import 'package:path/path.dart' as path;
import 'dart:developer';

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
  late HeaderWithTabs header;
  String defaultFilenameOnly = 'untitled';
  String defaultFilenameExtension = '.py';

  String resolveFilename(int index) {
    return "$defaultFilenameOnly${index}$defaultFilenameExtension";
  }

  @override
  void initState() {
    print("Document Manager Initstate");
    super.initState();
    _tabController = TabController(length: _numTabs, vsync: this);
    _scrollController = ScrollController();
    String defaultFilename = resolveFilename(1);
    var filename = getDefaultFullPath();
    var editor = createPyEditor(filename);
    _tabs = [
      getTabItem(context, defaultFilename, editor.hashCode,
          iconData: Icons.close, callback: documentClose) as Tab
    ];
    _tabContent = [editor];
    _documents = [];
    DocumentAddToList(context, defaultFilename, "YaSe", "", _documents);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _tabContent.forEach((element) {
      (element as PyEditor).pyCodeControllerToken.dispose();
    });
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

  String getDefaultFileName() {
    return resolveFilename(_numTabs);
  }

  String getDefaultFullPath() {
    return concatPaths(
        [YaSeApp.of(context)!.widget.YaSeAppPath, getDefaultFileName()]);
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

  String getDocumentName(int numTabs) {
    var filename = resolveFilename(numTabs);
    var docNames = _documents
        .map((doc) => doc.filename!.split(path.separator).last)
        .toList();
    for (var i = 0; i < docNames.length; i++) {
      if (!docNames.contains(resolveFilename(i + 1))) {
        return resolveFilename(i + 1);
      }
    }
    return resolveFilename(numTabs + 1);
  }

  void documentAdd(String? fullPath) {
    setState(() {
      final app = YaSeApp.of(context);
      // get next document adds 1 to tab count
      String filename = fullPath ?? getDocumentName(_numTabs);
      _numTabs++; // add a new tab, this line increments the number of tabs
      var editor = createPyEditor(getDefaultFullPath());
      if (fullPath != null) {
        var contents = read(fullPath);
        editor = createPyEditor(filename);
        editor.pyCodeControllerToken.getTextController().text = contents;
      }
      var file = File(filename);
      _tabs.add(getTabItem(
          context, file.path.split(path.separator).last, editor.hashCode,
          iconData: Icons.close, callback: documentClose) as Tab);
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
    var filename = editor.filename.split(path.separator).last;
    if (filename == resolveFilename(_tabController.index + 1) ||
        editor.filename == "") {
      Future.delayed(Duration.zero, () async {
        var result = await Navigator.pushNamed(context, "/file_save",
            arguments: <String, dynamic>{
              "targetFolder": YaSeApp.of(context)!.widget.YaSeAppPath,
              "title": "Save File As",
              "editor": editor,
              "callback": () => {}
            });
        if (result == true) {
          _documents[_tabController.index].filename = editor.filename;
          _tabs[_tabController.index] = getTabItem(context,
              editor.filename.split(path.separator).last, editor.hashCode,
              iconData: Icons.close, callback: documentClose) as Tab;
          saveFile(editor);
          setState(() {});
        }
      });
    } else {
      saveFile(editor);
    }
  }

  void saveFile(PyEditor editor) {
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
    //AppBar.preferredHeightFor(context, Size(double.infinity, 100));
    print("Tabs: $_tabs");
    print("Tab Content: $_tabContent");
    print("Tab Count: $_numTabs");
    print("document_manager, build");
    header = HeaderWithTabs(
        toolbarHeight: 100,
        title: "Ya Se",
        items: HeaderItems(),
        tabs: _tabs,
        tabController: _tabController,
        tabBar: createTabBar(context, _tabs, _tabController));

    var docManager = DefaultTabController(
      length: _numTabs,
      child: Scaffold(
        appBar: header,
        body: createTabView(
            List.generate(
              _numTabs,
              (index) => index < _tabContent.length
                  ? _tabContent[index]
                  : createPyEditor(getDefaultFullPath()),
            ),
            _tabController),
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
