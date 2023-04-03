import 'package:flutter/material.dart';
import '/yase/yase.dart';
import 'dart:io';
import './../../../utils/file_utils.dart';

class Document extends StatefulWidget {
  String? filename;
  String? contents;

  Document({Key? key, this.filename, this.contents}) : super(key: key);

  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  late final File _file;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var targetFolder = getAppPath(
        context, () => YaSeApp.of(context)!.widget.YaSeAppPath,
        appFolder: "yase");
    var targetFilename = widget.filename ?? "untitled";
    var targetPath = "$targetFolder/$targetFilename";
    _file = File(targetPath);
  }

  @override
  Widget build(BuildContext context) {
    // Use the _file variable here to display or edit the file contents
    return Container();
  }
}

Document createDocument(
    BuildContext context, String filename, String appFolder, String content) {
  String fullFilePath = getFullPath(context,
      () => YaSeApp.of(context)!.widget.YaSeAppPath, filename, appFolder);
  return Document(filename: fullFilePath, contents: content);
}

enum Status {
  UNKNOWN,
  OK,
  ERROR,
}
