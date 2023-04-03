import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:starflut/starflut.dart';
import './../../../utils/dropdown_utils.dart';
import './../../../utils/style_utils.dart';
import './../../../utils/dropdownlist.dart';

class PythonClientScreen extends StatefulWidget {
  const PythonClientScreen({Key? key}) : super(key: key);
  @override
  _PythonClientScreenState createState() => _PythonClientScreenState();
}

class _PythonClientScreenState extends State<PythonClientScreen> {
  TextEditingController codeController = TextEditingController();
  final maxLines = 25;
  @override
  Widget build(BuildContext context) {
    Widget textSection = Container(
      width: 100,
      height: maxLines * 24,
      padding: EdgeInsets.fromLTRB(3, 2, 2, 2),
      child: TextField(
        controller: codeController,
        maxLines: maxLines,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: const Text('Python Client'),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: [textSection],
      ),
    );
  }
}
