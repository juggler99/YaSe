import 'package:flutter/material.dart';
import 'dart:developer';

import 'style_utils.dart';

Color getColorByString(String strColor) {
  print('getColorByString: $strColor');
  if (strColor == null) return Colors.white;
  if (strColor.isEmpty) return Colors.white;
  if (strColor.contains("Colors.")) {
    strColor = strColor.replaceAll("Colors.", "");
  }
  Color color = Colors.white;
  int shadeIndex = strColor.indexOf('[');
  int shade = -1;
  if (shadeIndex >= 0) {
    shade = int.parse(strColor.substring(shadeIndex + 1, strColor.length - 1));
    strColor = strColor.substring(0, shadeIndex);
  }
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
  print("color[$strColor]: $color, Shade: $shade");
  if (shadeIndex > -1) {
    var selectedColorShades = getShadesForColorAsListOfTuples(color);
    return selectedColorShades[shade].item2;
  }
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
