import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class PythonConsole extends StatefulWidget {
  PythonConsole({Key? key, this.title, this.body}) : super(key: key);
  String? title;
  String? body;

  @override
  State<PythonConsole> createState() => _PythonConsoleState();
}

class _PythonConsoleState extends State<PythonConsole> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(args["title"]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            args["body"],
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
