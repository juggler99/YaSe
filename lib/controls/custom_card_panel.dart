import 'package:flutter/material.dart';
import 'color_shade_picker.dart';
import './../../utils/style_utils.dart';
import 'color_picker.dart';
import './../controls/bloc_controls/theme_manager/theme_manager.dart';
import './../yase/yase.dart';
import './../../utils/theme_utils.dart';
import 'dart:developer';

typedef OnColorChangeCallback = void Function(Color value, int index);
typedef OnTapCallback = void Function(BuildContext context, String label,
    String message, String textOptionTrue, String textOptionFalse);

class CustomCardPanel extends StatefulWidget {
  double leftMargin = 10;
  String label = 'Color';
  double panelWidth = 150;
  double panelHeight = 35;
  double cardWidth = 60;
  double cardHeight = 35;
  Color backgroundColor = Colors.white;
  Color primaryColor = Colors.black;
  String backgroundColorName = 'white';
  String primaryColorName = 'black';
  OnColorChangeCallback? callback;
  OnTapCallback? onTapCallback;
  String message = '';
  String optionTrue = 'OK';
  String opriotnFalse = 'Cancel';

  CustomCardPanel(
      {Key? key,
      this.label = 'Color',
      this.backgroundColor = Colors.white,
      this.primaryColor = Colors.black,
      this.leftMargin = 10,
      this.panelWidth = 150,
      this.panelHeight = 32,
      this.cardWidth = 60,
      this.cardHeight = 32,
      this.backgroundColorName = 'white',
      this.primaryColorName = 'black',
      this.message = '',
      this.optionTrue = 'OK',
      this.opriotnFalse = 'Cancel',
      OnColorChangeCallback? callback,
      OnTapCallback? onTapCallback})
      : super(key: key);

  @override
  _CustomCardPanelState createState() => _CustomCardPanelState();
}

class _CustomCardPanelState extends State<CustomCardPanel> {
  var colorsKeyedByColor = {};

  void onPickColor() {
    var colorPicker = ColorPickerPanel();
    PickAColor(context, colorPicker).then((exit) {
      if (colorPicker.color == Colors.transparent) return;
      var colorShadePicker = ColorShadePickerPanel(color: colorPicker.color);
      PickAColorShade(context, colorShadePicker).then((exit) {
        if (colorShadePicker.color == Colors.transparent) {
          widget.backgroundColor = colorPicker.color;
          print('onPickColor from colorPicker: $widget.backgroundColor');
        }
        setState(() {
          widget.backgroundColor = colorShadePicker.color;
          var colorName = getPrimaryColorName(widget.backgroundColor);
          var label = widget.label;
          ThemeManager _themeManager =
              YaSeApp.of(context)!.widget.getThemeManager();
          ThemeData? currentThemeData =
              _themeManager.getThemeData(key: 'system');
          ThemeData? modifiedThemeData = getModfiedThemeData(
              currentThemeData!, widget.label, colorShadePicker.color);
          _themeManager.modifySystemTheme(context,
              newThemeData: modifiedThemeData);
          print('onPickColor from colorShadePicker: $label - $colorName');
        });
      });
    });
  }

  void onColorChange(Color value, int index) {
    print('onColorChange: $value index: $index');
    setState(() {
      widget.backgroundColor = value;
    });
  }

  @override
  void initState() {
    try {
      var colorsByColor = getPrimaryColorsAsMapKeyedByColor();
      if (colorsByColor.containsKey(widget.backgroundColor)) {
        widget.backgroundColorName = colorsByColor.entries
            .firstWhere((entry) => entry.key == widget.backgroundColor)
            .value;
      }
    } catch (exception) {
      debugger();
      print('initState: $exception');
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTap() {}

  @override
  Widget build(BuildContext context) {
    widget.callback = onColorChange;
    Color borderColor =
        getBorderColorBasedOnCanvasColor(context, widget.backgroundColor);
    return Padding(
        padding: EdgeInsets.fromLTRB(3, 10, 3, 3),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(widget.label,
                    textAlign: TextAlign.left,
                    style: YaSeApp.of(context)!
                        .widget
                        .AppTheme
                        .textTheme
                        .bodyMedium),
                width: widget.panelWidth,
                height: widget.panelHeight,
                padding: EdgeInsets.fromLTRB(0, 3, 0, 2),
              ),
              InkWell(
                onTap: onPickColor,
                child: Container(
                  width: widget.cardWidth,
                  height: widget.cardHeight,
                  decoration: new BoxDecoration(
                    color: widget.backgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: borderColor,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                ),
              )
            ]));
  }
}
