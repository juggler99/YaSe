import 'package:YaSe/controls/custom_fab_location.dart';
import 'package:YaSe/yase/yase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import '../../utils/button_utils.dart';

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
  var frmt = NumberFormat('#,##0.#####');

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

  double calcHeightScrollFactor(int lines) {
    var pageHeight =
        YaSeApp.of(context)!.widget.YaSeAppHeight - kToolbarHeight * 2;
    pageHeight *= 1 - 0.17;
    double factor = 1.0;
    if (lines > 0) {
      factor = pageHeight / lines;
    }
    return factor;
  }

  double calcScrollDelta(
      double prevPosition, double delta, int lines, double pageHeight) {
    return delta * lines / 20;
  }

  void moveFloater(SingleChildScrollView scroller, double offset, double delta,
      int lines, double pageHeight, CustomFabLoc customFabLocation) {
    var deltaY = calcScrollDelta(offset, delta, lines, pageHeight);
    scroller.controller!.jumpTo(offset + deltaY);
    var factor = ((offset + deltaY) / pageHeight) / 100;
    customFabLocation.SetHeightFactor(factor);
    print(
        "move floater customFabLocation: ${frmt.format(customFabLocation.heightFactor)} factor: ${frmt.format(factor)} deltaY: ${frmt.format(deltaY)} lines: ${frmt.format(lines)} offset: ${frmt.format(offset)} delta: ${frmt.format(delta)}");
  }

  void endDragFloater(SingleChildScrollView scroller, double offset,
      double pageHeight, CustomFabLoc customFabLocation) {
    var factor = (offset / pageHeight);
    customFabLocation.SetHeightFactor(factor);
    print(
        "end drag floater customFabLocation: ${frmt.format(customFabLocation.heightFactor)} factor: ${frmt.format(factor)} offset: ${frmt.format(offset)}");
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    double pageHeight = YaSeApp.of(context)!.widget.YaSeAppHeight;
    var body = args["body"];
    var scroller = SingleChildScrollView(
        child: Text(body), controller: ScrollController());
    var iconUp = Icon(Icons.arrow_drop_up, size: 25);
    var iconDown = Icon(Icons.arrow_drop_down, size: 25);
    var buttonUp = getElevatedButton(
        context,
        () => scroller.controller!
            .jumpTo(scroller.controller!.offset - pageHeight),
        icon: iconUp,
        diameter: 20);
    var buttonDown = getElevatedButton(
        context,
        () => scroller.controller!
            .jumpTo(scroller.controller!.offset + pageHeight),
        icon: iconUp,
        diameter: 20);
    var lines = body.split("\n").length;
    double heightScrollFactor = calcHeightScrollFactor(lines);
    var customLocation = CustomFabLoc();
    var dragButton = Draggable(
      feedback: FloatingActionButton(
          backgroundColor: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
          child: Icon(Icons.drag_indicator_sharp),
          onPressed: () {}),
      child: FloatingActionButton(
          backgroundColor: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
          child: Icon(Icons.drag_indicator_sharp),
          onPressed: () {}),
      childWhenDragging: Container(),
      onDragUpdate: (details) => moveFloater(
          scroller,
          scroller.controller!.offset,
          details.delta.dy,
          lines,
          pageHeight,
          customLocation),
      onDragEnd: (details) => endDragFloater(
          scroller, details.offset.dy, pageHeight, customLocation),
    );

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          backgroundColor: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
          title: Text(args["title"]),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Container(child: scroller)),
          ],
        ),
        floatingActionButton: dragButton,
        floatingActionButtonLocation: customLocation);
  }
}
