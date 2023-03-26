import 'package:flutter/material.dart';
import 'package:flutter_application_1/controls/bloc_controls/py_code/py_code_field.dart';
import '../../controls/bloc_controls/py_code/py_code_field.dart';
import 'package:flutter_gen/controls/header.dart';
import 'package:flutter_gen/utils/button_utils.dart';
import 'editor_footer.dart';
import 'editor_header.dart';

class Editor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Editor build");
    List<Widget> headerItems = [];
    headerItems.add(getIconButton(context, Icons.add, 'Add', () {}, 1));

    return Scaffold(
      //appBar: EditorHeader(),
      appBar: Header(title: "Hello", items: headerItems),
      body: Center(
          //child: Text('Edit me'),
          child: PyCodeField()),
      bottomNavigationBar: EditorFooter(),
    );
  }
}
