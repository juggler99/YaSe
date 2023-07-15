import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import './../../utils/style_utils.dart';

typedef OnColorChangeCallback = void Function(Color value, int index);

class ColorShadePickerPanel extends StatefulWidget {
  Color color = Colors.transparent;
  OnColorChangeCallback? callback;
  VoidCallback? onTapCallback;

  ColorShadePickerPanel(
      {Key? key,
      color = Colors.transparent,
      OnColorChangeCallback? callback,
      VoidCallback? onTapCallback})
      : super(key: key) {
    this.color = color;
    this.callback = callback;
    this.onTapCallback = onTapCallback;
  }

  @override
  _ColorShadePickerPanelState createState() => _ColorShadePickerPanelState();
}

class _ColorShadePickerPanelState extends State<ColorShadePickerPanel> {
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
    String widgetColor = getColorName(widget.color);
    print('_ColorShadePickerPanelState - widgetColor: $widgetColor');
    var colors = getShadesForColorAsListOfTuples(widget.color);
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
            getColorShadePickerItem(context, color.item2, color.item1, this);
        row.children.add(container);
        count += 1;
      }
    }
    double leftMarging = 80;
    double topMarging = 160;
    double rightMarging = 80;
    double bottomMarging = 170;
    if (rows.length == 2) {
      topMarging += 70;
      bottomMarging += 70;
    }

    if (rows.length == 3) {
      topMarging += 40;
      bottomMarging += 30;
    }

    return Container(
        margin: EdgeInsets.fromLTRB(
            leftMarging, topMarging, rightMarging, bottomMarging),
        padding: EdgeInsets.all(20),
        color: YaSeApp.of(context)!.widget.AppTheme.canvasColor,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: rows));
  }
}

Widget getColorShadePickerItem(BuildContext context, Color color, String label,
    _ColorShadePickerPanelState state,
    {double width = 30, double height = 30}) {
  Color borderColor = getBorderColorBasedOnCanvasColor(context, color);
  return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: YaSeApp.of(context)!.widget.AppTheme.canvasColor,
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

Future<void> PickAColorShade(
    BuildContext context, ColorShadePickerPanel colorShadePicker) {
  print('PickAColorShade');
  return showDialog(
    barrierColor: Colors.blueGrey,
    context: context,
    builder: (BuildContext context) {
      return colorShadePicker;
    },
  ).whenComplete(() => Navigator.of(context).pop());
}
