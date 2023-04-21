import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'style_utils.dart';

/// Returns a [TextButton] with the given [label] and [color] and [value]
TextButton getTextButtonForClosingDialog<T>(
    BuildContext context, String label, Color? color, T value,
    {void Function()? callback = null}) {
  ThemeData localTheme = Theme.of(context).copyWith(primaryColor: color);
  TextStyle textStyle = localTheme.textTheme.subtitle1!.apply(color: color);
  return TextButton(
      child: Text(
        label,
        style: textStyle,
      ),
      style: ButtonStyle(foregroundColor: MaterialStateProperty.all(color)),
      onPressed: () {
        if (callback != null) {
          callback();
        }
        Navigator.pop(context, value);
      });
}

/// Returns a [ElevatedButton] with the given [label] and [color] and [value]
ElevatedButton getElevatedButtonForClosingDialog<T>(
    BuildContext context, String label, Color? color, T value,
    {void Function()? callback = null}) {
  ThemeData localTheme = Theme.of(context).copyWith(primaryColor: color);
  TextStyle textStyle = localTheme.textTheme.subtitle1!.apply(color: color);
  return ElevatedButton(
      child: Text(label, style: textStyle),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(color),
          backgroundColor: MaterialStateProperty.all(
              //Theme.of(context).buttonTheme.colorScheme!.outline)),
              Colors.grey[350])),
      onPressed: () {
        if (callback != null) {
          callback();
        }
        Navigator.pop(context, value);
      });
}

/// Returns a [IconButton] as Navigator using label as the given [NacTarget]
/// providing an optional back arrow to navigate back and
/// also an option to pop the Previous element in navigation route
IconButton getNavIconButton(
    BuildContext context, IconData iconData, String NavTarget,
    {bool allowBack = true,
    bool popPrev = true,
    List<double> edgeItems = const [0, 0, 0, 0]}) {
  if (!NavTarget.startsWith('/')) {
    NavTarget = '/' + NavTarget;
  }
  return IconButton(
    icon: const Icon(Icons.edit),
    onPressed: () {
      if (popPrev) {
        Navigator.pop(context);
      }
      if (allowBack) {
        Navigator.pushNamed(context, NavTarget);
      } else {
        Navigator.pushReplacementNamed(context, NavTarget);
      }
    },
  );
}

/// Returns a [IconButton] with a tool tip and a callback to execute
Widget getIconButton(BuildContext context, IconData iconData, String tooltip,
    VoidCallback callback, int flex,
    {double iconSize = 24.0}) {
  var edges = EdgeInsets.all(8.0);
  if (iconSize != 24.0) {
    edges = EdgeInsets.all(0.0);
  }
  print("iconSize: $iconSize, edges: $edges");
  return Material(
      color: Theme.of(context).primaryColor,
      child: Tooltip(
          message: tooltip,
          child: IconButton(
            icon: Icon(iconData),
            iconSize: iconSize,
            onPressed: callback,
            color: Colors.black,
            padding: edges,
          )));
}

/// Returns a [IconButton] with a tool tip and a callback to execute usig an asset (path)
Widget getIconButtonFromAsset(
    String path, String tooltip, VoidCallback callback, int flex) {
  return Material(
      child: Tooltip(
          message: tooltip,
          child: IconButton(
            icon: Image.asset(path),
            onPressed: callback,
          )));
}

/// Returns a [TextButton] with the given [label] and [color] and callback to execute
TextButton getTextButtonWithValue<T>(BuildContext context, String label,
    Color? color, TextStyle style, T value, VoidCallback onPressed) {
  TextStyle textStyle = style.apply(color: color);
  return TextButton(
      child: Text(
        label,
        style: textStyle,
      ),
      style: ButtonStyle(foregroundColor: MaterialStateProperty.all(color)),
      onPressed: onPressed);
}

/// Returns a [TextButton] with the given [label] and [width] and callback to execute
Widget getTextButton(
    BuildContext context, String label, VoidCallback onTap, double width,
    {double height = -1,
    double radius = -1,
    Color backgroundColor = Colors.white,
    Color labelColor = Colors.black}) {
  return Padding(
      padding: EdgeInsets.all(6),
      child: SizedBox(
          width: width,
          height: height > -1 ? height : width,
          child: Material(
              child: InkWell(
                  onTap: onTap,
                  child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: backgroundColor,
                                offset: Offset(1, 1),
                                blurRadius: 2),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              radius > -1 ? width / 2 : radius)),
                          color: backgroundColor),
                      child: Center(
                        child: Text(label, style: TextStyle(color: labelColor)),
                      ) // Label text and other stuff here
                      )))));
}

/// Returns a [ButtonBar] containing text buttons, based on gievn list of items
ButtonBar createTextButtonBarFromListOfText(
    List<String> items, TextEditingController targetController) {
  var buttons = <SizedBox>[];
  SizedBox? button;
  for (int i = 0; i < items.length; i++) {
    var values = items[i].split("~");
    String keyLabel = values[0];
    String keyValue = values.length > 1 ? values[1] : values[0];
    button = SizedBox(
        width: 28,
        height: 24,
        child: TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey.shade300),
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
              fixedSize: MaterialStateProperty.all<Size>(Size(32, 36))),
          child: Text(keyLabel),
          onPressed: () => _onButtonPressed(keyValue, targetController),
          autofocus: false,
        ));
    buttons.add(button);
  }
  return ButtonBar(
      children: buttons,
      mainAxisSize: MainAxisSize.min,
      alignment: MainAxisAlignment.start,
      buttonPadding: EdgeInsets.zero);
}

/// Button event that returns a [String]
void _onButtonPressed(String character, TextEditingController _controller) {
  String currentText = _controller.text;
  TextSelection currentSelection = _controller.selection;
  int cursorPos = currentSelection.baseOffset;
  String newText = currentText.substring(0, cursorPos) +
      character +
      currentText.substring(cursorPos);
  _controller.text = newText;
  _controller.selection = TextSelection.collapsed(offset: cursorPos + 1);
}

ElevatedButton getElevatedButton(BuildContext context, VoidCallback onPressed,
    {String? label,
    Icon? icon,
    double diameter = 0,
    Color? color,
    bool inverted = false}) {
  ThemeData localTheme = Theme.of(context).copyWith(primaryColor: color);
  TextStyle textStyle = localTheme.textTheme.subtitle1!.apply(color: color);
  var childWidget = null;
  if (label != null) {
    childWidget = Text(label, style: textStyle);
  } else if (icon != null) {
    childWidget = icon;
  }
  var borderRadius = null;
  if (diameter > 0) {
    if (inverted == true) {
      borderRadius = BorderRadius.only(
          topLeft: Radius.circular(diameter),
          topRight: Radius.circular(diameter));
    } else {
      borderRadius = BorderRadius.only(
          bottomLeft: Radius.circular(diameter),
          bottomRight: Radius.circular(diameter));
    }
    borderRadius = BorderRadius.circular(diameter);
  } else {
    borderRadius = BorderRadius.circular(diameter);
  }
  return ElevatedButton(
      child: childWidget,
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: borderRadius,
                  side: BorderSide(color: Colors.red))),
          foregroundColor: MaterialStateProperty.all(color),
          backgroundColor: MaterialStateProperty.all(
              //Theme.of(context).buttonTheme.colorScheme!.outline)),
              Colors.grey[350])),
      onPressed: () {
        onPressed();
      });
}
