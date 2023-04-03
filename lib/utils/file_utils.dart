import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter_treeview/flutter_treeview.dart';
import 'dart:developer';

/// Returns a string after reading a file in async mode
Future<String> readAsync(String filename) async {
  return await File(filename).readAsString();
}

/// Returns a File after writing a file in async mode
Future<File> writeAsync(String filename, String content) async {
  return await File(filename).writeAsString(content);
}

/// Returns a string after reading a file in sync mode
String read(String filename) {
  return File(filename).readAsStringSync();
}

/// Writes a file in sync mode
void write(String filename, String content) {
  var file = File(filename);
  var parent = file.parent;
  if (!parent.existsSync()) {
    parent.createSync(recursive: true);
  }
  print("Write filename: $filename");
  File(filename).writeAsStringSync(content);
}

/// Returns a boolean if file exists
Future<bool> exists(String filename) async {
  var file = File(filename);
  return await file.exists();
}

///Returns a string representing default file location for an app
///varies according to device
///appFolder is used to append a custom path
Future<String> getDefaultRootFolderAsString({String appFolder = ""}) async {
  // only supporting iOs and Android
  var directory = await getApplicationDocumentsDirectory();
  if (Platform.isIOS) {
    directory = await getApplicationSupportDirectory();
  }
  if (appFolder.length > 0) {
    var newFFolder = directory.path + "/$appFolder";
    directory = Directory(newFFolder);
  }
  return directory.path;
}

///Returns a string representing default file location for an app from root App class
String getAppPath<T extends State<StatefulWidget>>(
    BuildContext context, ValueGetter<String> callback,
    {appFolder: ""}) {
  var appRootFolder = callback();
  if (appRootFolder.split(path.separator).last == appFolder) {
    return appRootFolder;
  }
  return concatPaths([appRootFolder, appFolder]);
}

///Returns a string representing full path for a filename
String getFullPath(BuildContext context, ValueGetter<String> callback,
    String filename, String appFolder) {
  var folder = getAppPath(context, callback, appFolder: appFolder);
  if (!filename.contains(folder!)) return concatPaths([folder, filename]);
  return filename;
}

///Creates a File
void createFile(BuildContext context, ValueGetter<String> callback,
    String filename, String appFolder, File? file,
    {bool saveIt = true}) {
  debugger();
  var fullFilename = getFullPath(context, callback, filename, appFolder);
  file = File(fullFilename);
  if (saveIt) file.create();
}

///Returns a string representing concatenated parts of a path
String concatPaths(List<String> items) {
  return path.joinAll(items);
}

///Returns a set of Nodes representing files under given [Directory]
List<Node<FileSystemEntity>> getChildrenPathElements(
    Node parentNode, Directory dir) {
  var items = dir.listSync(recursive: true);
  var children = <Node<FileSystemEntity>>[];
  for (FileSystemEntity item in items) {
    List<String> parts = item.path.split(path.separator);
    var node = Node<FileSystemEntity>(
        label: parts.last, key: item.path, icon: Icons.description, data: item);
    if (item is Directory) {
      node = Node<FileSystemEntity>(
          label: parts.last,
          key: item.path,
          icon: Icons.folder,
          data: item,
          expanded: true,
          children: getChildrenPathElements(node, item));
    }
    children.add(node);
  }
  return children;
}

///Returns a Tree of Nodes representing files under given App [Directory]
List<Node<FileSystemEntity>> listFiles(
    BuildContext context, String targetPath, String filter) {
  var dir = Directory(targetPath);
  List<FileSystemEntity> files = dir.listSync(recursive: true);

  print("Dir: ${dir.path}");
  var rootNode = Node<FileSystemEntity>(
      label: "root",
      key: dir.path,
      icon: Icons.folder,
      parent: true,
      data: dir,
      expanded: true);
  List<Node<FileSystemEntity>> childNodes =
      getChildrenPathElements(rootNode, dir);

  rootNode = Node<FileSystemEntity>(
      label: "root",
      key: dir.path,
      icon: Icons.folder,
      parent: true,
      data: dir,
      children: childNodes,
      expanded: true);
  return [rootNode];
}
