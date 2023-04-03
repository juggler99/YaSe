import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import '../bloc_controls/theme_manager/theme_manager.dart';
import 'dlg_utils.dart';
import 'dart:developer';

/// Applies the newTextStyle to the targetCopyWith of the themeData
void applyThemeDataTextStyle(
    ThemeData themeData, String targetCopyWith, TextStyle newTextStyle) {
  debugger();
  if (targetCopyWith == 'Headline1')
    themeData.textTheme.headline1!.apply(
        fontSizeDelta:
            themeData.textTheme.headline1!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'Headline2')
    themeData.textTheme.headline2!.apply(
        fontSizeDelta:
            themeData.textTheme.headline2!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'Headline3')
    themeData.textTheme.headline3!.apply(
        fontSizeDelta:
            themeData.textTheme.headline3!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'Headline4')
    themeData.textTheme.headline4!.apply(
        fontSizeDelta:
            themeData.textTheme.headline4!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'Headline5')
    themeData.textTheme.headline5!.apply(
        fontSizeDelta:
            themeData.textTheme.headline5!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'Headline6')
    themeData.textTheme.headline6!.apply(
        fontSizeDelta:
            themeData.textTheme.headline6!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'SubTitle1')
    themeData.textTheme.subtitle1!.apply(
        fontSizeDelta:
            themeData.textTheme.subtitle1!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'SubTitle2')
    themeData.textTheme.subtitle2!.apply(
        fontSizeDelta:
            themeData.textTheme.subtitle2!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'bodyText1')
    themeData.textTheme.bodyText1!.apply(
        fontSizeDelta:
            themeData.textTheme.bodyText1!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'bodyText2')
    themeData.textTheme.bodyText2!.apply(
        fontSizeDelta:
            themeData.textTheme.bodyText2!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'button')
    themeData.textTheme.button!.apply(
        fontSizeDelta:
            themeData.textTheme.button!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'caption')
    themeData.textTheme.caption!.apply(
        fontSizeDelta:
            themeData.textTheme.caption!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'overline')
    themeData.textTheme.overline!.apply(
        fontSizeDelta:
            themeData.textTheme.overline!.fontSize! - newTextStyle.fontSize!);
}

/// returns a List<Color> with different style elements from context Theme
List<Color> getThemeSchemaColors(context) {
  return <Color>[
    Theme.of(context).splashColor,
    Theme.of(context).canvasColor,
    Theme.of(context).primaryColor,
    Theme.of(context).primaryColorDark,
    Theme.of(context).primaryColorLight,
    Theme.of(context).backgroundColor,
    Theme.of(context).colorScheme.onPrimary,
    Theme.of(context).colorScheme.secondary,
    Theme.of(context).colorScheme.onSecondary,
    Theme.of(context).colorScheme.onBackground,
    Theme.of(context).colorScheme.surface,
    Theme.of(context).colorScheme.onSurface,
    Theme.of(context).errorColor,
    Theme.of(context).colorScheme.onError,
    Theme.of(context).shadowColor
  ];
}

List<String> getThemeSchemaColorNames(BuildContext context) {
  return <String>[
    'Splash',
    'Canvas',
    'Primary',
    'Primary Dark',
    'Primary Light',
    'Background',
    'on Primary',
    'Secondary',
    'on Secondary',
    'on Background',
    'Surface',
    'on Surface',
    'Error',
    'on Error',
    'Shadow'
  ];
}

/// returns a List<Tuple2<String, Color>> with different style elements from context Theme
List<Tuple2<String, Color>> getThemeSchemaColorsCombo(BuildContext context) {
  List<Tuple2<String, Color>> results = [];
  var colorNames = getThemeSchemaColorNames(context);
  var colors = getThemeSchemaColors(context);
  colorNames.asMap().entries.forEach((e) =>
      results.add(Tuple2<String, Color>(e.value, colors.elementAt(e.key))));
  return results;
}

/// returns a copy of themeData with the corresponding argument for label passed
ThemeData getModfiedThemeData(
    ThemeData themeData, String itemName, Color? color) {
  if (itemName == 'Splash') return themeData.copyWith(splashColor: color);
  if (itemName == 'Canvas') return themeData.copyWith(canvasColor: color);
  if (itemName == 'Primary Dark')
    return themeData.copyWith(primaryColorDark: color);
  if (itemName == 'Primary Light')
    return themeData.copyWith(primaryColorLight: color);
  if (itemName == 'Background')
    return themeData.copyWith(backgroundColor: color);
  if (itemName == 'on Primary') {
    ColorScheme colorScheme = themeData.colorScheme.copyWith(onPrimary: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'Secondary')
    return themeData.copyWith(secondaryHeaderColor: color);
  if (itemName == 'on Secondary') {
    ColorScheme colorScheme =
        themeData.colorScheme.copyWith(onSecondary: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'on Background') {
    ColorScheme colorScheme =
        themeData.colorScheme.copyWith(onBackground: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'Surface') {
    ColorScheme colorScheme = themeData.colorScheme.copyWith(surface: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'on Surface') {
    ColorScheme colorScheme = themeData.colorScheme.copyWith(onSurface: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'Error') return themeData.copyWith(errorColor: color);
  if (itemName == 'on Error') {
    ColorScheme colorScheme = themeData.colorScheme.copyWith(onError: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'Shadow') return themeData.copyWith(shadowColor: color);
  return themeData;
}
