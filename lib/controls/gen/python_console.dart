import 'package:YaSe/yase/yase.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:developer';

class PythonConsole extends StatefulWidget {
  PythonConsole({Key? key, this.title, this.body}) : super(key: key);
  String? title;
  String? body;

  @override
  State<PythonConsole> createState() => _PythonConsoleState();
}

class _PythonConsoleState extends State<PythonConsole> {
  StreamController<String> _textStreamController = StreamController<String>();
  String? data;
  String? output;

  void loadText() {
    // Use the stream controller to emit the text data as it becomes available
    retrieveText().asStream().listen((data) {
      _textStreamController.add(data);
    });
  }

  Future<String> retrieveText() async {
    // Simulate retrieving the text data from a remote source
    await Future.delayed(Duration(seconds: 1));
    // Return some text data
    return data ?? "";
  }

  @override
  void initState() {
    super.initState();
    // Call loadText when the widget is initialized
    loadText();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    data = args["body"] as String;

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(args["title"]),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Container(
                    child: SingleChildScrollView(child: Text(args["body"])))),
          ],
        ));
  }
}
