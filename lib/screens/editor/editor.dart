import 'package:flutter/material.dart';
import './../../../controls/header.dart';
import './../../../utils/button_utils.dart';
import 'editor_footer.dart';

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
        child: Text('Edit me'),
      ),
      bottomNavigationBar: EditorFooter(),
    );
  }
}
