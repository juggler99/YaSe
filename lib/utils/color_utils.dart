import 'package:flutter/material.dart';

Color getColorByString(String strColor) {
  if (strColor == null) return Colors.white;
  if (strColor.isEmpty) return Colors.white;
  if (strColor.contains("Colors.")) {
    strColor = strColor.replaceAll("Colors.", "");
  }
  Color color = Colors.white;
  switch (strColor) {
    case "red":
      color = Colors.red;
      break;
    case "green":
      color = Colors.green;
      break;
    case "blue":
      color = Colors.blue;
      break;
    case "yellow":
      color = Colors.yellow;
      break;
    case "orange":
      color = Colors.orange;
      break;
    case "pink":
      color = Colors.pink;
      break;
    case "purple":
      color = Colors.purple;
      break;
    case "brown":
      color = Colors.brown;
      break;
    case "grey":
      color = Colors.grey;
      break;
    case "black":
      color = Colors.black;
      break;
    case "white":
      color = Colors.white;
      break;
    default:
      color = Colors.white;
  }
  print("color[$strColor]: $color");
  return color;
}

ColorScheme getColorScheme(ThemeData appTheme) {
  return ColorScheme(
      brightness: appTheme.brightness,
      primary: appTheme.primaryColor,
      onPrimary: appTheme.primaryColor,
      secondary: appTheme.secondaryHeaderColor,
      onSecondary: appTheme.secondaryHeaderColor,
      error: appTheme.colorScheme.error,
      onError: appTheme.colorScheme.error,
      background: appTheme.colorScheme.background,
      onBackground: appTheme.colorScheme.onBackground,
      surface: appTheme.colorScheme.surface,
      onSurface: appTheme.colorScheme.onSurface);
}
