import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import './../../utils/dropdown_utils.dart';
import './../../utils/style_utils.dart';
import 'dart:developer';

//import 'color_shade_picker.dart';

typedef OnColorChangeCallback = void Function(Color value, int index);

class ColorPickerPanel extends StatefulWidget {
  Color color = Colors.transparent;
  OnColorChangeCallback? callback;
  VoidCallback? onTapCallback;

  ColorPickerPanel(
      {Key? key, OnColorChangeCallback? callback, VoidCallback? onTapCallback})
      : super(key: key);

  @override
  _ColorPickerPanelState createState() => _ColorPickerPanelState();
}

class _ColorPickerPanelState extends State<ColorPickerPanel> {
  var colorsKeyedByColor = {};
  Color selectedColor = Colors.transparent;

  void onColorChange(Color color) {
    setState(() {
      widget.color = color;
      Navigator.of(context).pop();
      Navigator.pushNamed(context, '/colorShade_picker');
    });
  }

  @override
  Widget build(BuildContext context) {
    var colors = getPrimaryColorsPlusBlackAndWhiteAsListOfTuples();
    List<Widget> rows = [];
    int numRows = (colors.length ~/ 3);
    if (colors.length % 3 > 0) {
      numRows += 1;
    }
    for (var i = 0; i < numRows; i++) {
      Row row = Row(children: []);
      rows.add(row);
    }
    int count = 0;
    for (var i = 0; i < numRows; i++) {
      for (var j = 0; j < 3; j++) {
        if (count == colors.length) {
          break;
        }
        var color = colors[count];
        Row row = rows[i] as Row;
        var container =
            getColorPickerItem(context, color.item2, color.item1, this);
        row.children.add(container);
        count += 1;
      }
    }
    return Container(
        margin: EdgeInsets.fromLTRB(80, 60, 80, 60),
        padding: EdgeInsets.all(20),
        color: Theme.of(context).canvasColor,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: rows));
  }
}

Widget getColorPickerItem(BuildContext context, Color color, String label,
    _ColorPickerPanelState state,
    {double width = 30, double height = 30}) {
  Color borderColor = getBorderColorBasedOnCanvasColor(context, color);

  return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: Theme.of(context).canvasColor,
      child: SizedBox(
          width: width + 20,
          height: height + 20,
          child: Material(
              child: InkWell(
            onTap: () => state.onColorChange(color),
            child: Container(
              width: width,
              height: height,
              decoration: new BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                    color: borderColor, width: 1.0, style: BorderStyle.solid),
              ),
            ),
          ))));
}

Future<void> PickAColor(BuildContext context, ColorPickerPanel colorPicker) {
  print('PickAColor');
  return showDialog(
    barrierColor: Colors.blueGrey,
    context: context,
    builder: (BuildContext context) {
      return colorPicker;
    },
  ).whenComplete(() => Navigator.of(context).pop());
}
