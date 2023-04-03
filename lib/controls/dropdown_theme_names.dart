import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import './../../utils/dropdown_utils.dart';
import './../../utils/style_utils.dart';
import 'dart:developer';

typedef OnColorChangeCallback = void Function(Color, int, String, BuildContext);

class DropdownItemThemeColorPanel extends StatefulWidget {
  double leftMargin = 10;
  String label = 'Color';
  double labelWidth = 120;
  double labelHeight = 35;
  double cardWidth = 60;
  double cardHeight = 35;
  double dropdownWidth = 150;
  double dropdownHeight = 35;
  String dropdownSelectItem = 'Color';
  Color backgroundColor = Colors.white;
  Color primaryColor = Colors.black;
  OnColorChangeCallback? callback;

  DropdownItemThemeColorPanel(
      {Key? key,
      this.label: 'Color',
      this.backgroundColor: Colors.white,
      this.primaryColor: Colors.black,
      this.leftMargin: 10,
      this.labelWidth: 150,
      this.labelHeight: 32,
      this.cardWidth: 60,
      this.cardHeight: 32,
      this.dropdownWidth: 120,
      this.dropdownHeight: 45,
      this.dropdownSelectItem: 'Color',
      OnColorChangeCallback? callback})
      : super(key: key);

  @override
  _DropdownItemThemeColorPanelState createState() =>
      _DropdownItemThemeColorPanelState();
}

class _DropdownItemThemeColorPanelState
    extends State<DropdownItemThemeColorPanel> {
  var colorsKeyedByColor = {};

  void onColorChange(Color value, int index, String label, BuildContext) {
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
        widget.dropdownSelectItem = colorsByColor.entries
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

  @override
  Widget build(BuildContext context) {
    Card card = Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: widget.backgroundColor, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
            width: widget.cardWidth,
            height: widget.cardHeight,
            color: widget.backgroundColor));
    widget.callback = onColorChange;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: widget.leftMargin),
          Container(
            child: Text(widget.label,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText2),
            width: widget.labelWidth,
            height: widget.labelHeight,
            padding: EdgeInsets.fromLTRB(0, 3, 0, 2),
          ),
          card,
          getCustomDropdownMenuForColor(widget.dropdownSelectItem,
              width: widget.dropdownWidth,
              height: widget.dropdownHeight,
              callback: widget.callback)
        ]);
  }
}
