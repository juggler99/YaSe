import 'package:flutter/material.dart';
import '../../utils/button_utils.dart';
import 'package:YaSe/yase/yase.dart';
import 'dart:developer';

class EditPanel extends StatefulWidget {
  double? height;
  String? title;
  String? presetText;
  FocusNode? focusNode;
  List<Widget>? buttons;
  TextEditingController textEditingController = TextEditingController();

  EditPanel({
    Key? key,
    this.height = 50,
    this.title,
    this.presetText,
    this.focusNode,
    this.buttons,
  }) : super(key: key);

  TextEditingController getController() {
    return textEditingController;
  }

  @override
  _EditPanelState createState() => _EditPanelState();
}

class _EditPanelState extends State<EditPanel> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.focusNode = FocusNode();
  }

  @override
  void dispose() {
    widget.textEditingController.dispose();
    widget.focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Panel build");
    TextStyle? textStyle =
        YaSeApp.of(context)!.widget.AppTheme.textTheme.headline6;
    widget.textEditingController.text = widget.presetText ?? "";
    var children = <Widget>[
      SizedBox(
          height: widget.height,
          child: Container(
              child: TextField(
                  style: textStyle,
                  controller: widget.textEditingController,
                  focusNode: widget.focusNode,
                  onChanged: (value) => widget.presetText = value,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 2),
                      border: OutlineInputBorder(),
                      labelText: widget.title)))),
    ];
    widget.buttons?.forEach((element) {
      children.add(element);
    });
    return Stack(children: children);
  }
}

EditPanel getEditPanel(
    BuildContext context,
    String presetText,
    String labelButton1,
    Function callback1,
    String labelButton2,
    Function callback2,
    {String label = "",
    FocusNode? focusNode = null,
    double height = 100,
    Color buttonColor = Colors.grey}) {
  var mediaSize = MediaQuery.of(context).size;
  double leftButton1 = mediaSize.width / 2 - 2 - 100;
  double leftButton2 = mediaSize.width / 2 + 2;

  var editPanel = EditPanel(
      height: height,
      title: label,
      presetText: presetText,
      focusNode: focusNode,
      buttons: [
        Positioned(
            top: 50,
            left: leftButton1,
            child: getElevatedButton(context, () => {callback1()},
                label: labelButton1)),
        Positioned(
            top: 50,
            left: leftButton2,
            child: getElevatedButton(context, () => {callback2()},
                label: labelButton2))
      ]);
  return editPanel;
}
