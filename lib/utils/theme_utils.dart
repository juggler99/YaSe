import 'dart:async';
import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import 'package:tuple/tuple.dart';
import 'dlg_utils.dart';
import './../../../utils/color_utils.dart';
import 'dart:developer';

/// Applies the newTextStyle to the targetCopyWith of the themeData
void applyThemeDataTextStyle(
    ThemeData themeData, String targetCopyWith, TextStyle newTextStyle) {
  debugger();
  if (targetCopyWith == 'Headline1')
    themeData.textTheme.displayLarge!.apply(
        fontSizeDelta: themeData.textTheme.displayLarge!.fontSize! -
            newTextStyle.fontSize!);
  else if (targetCopyWith == 'Headline2')
    themeData.textTheme.displayMedium!.apply(
        fontSizeDelta: themeData.textTheme.displayMedium!.fontSize! -
            newTextStyle.fontSize!);
  else if (targetCopyWith == 'Headline3')
    themeData.textTheme.displaySmall!.apply(
        fontSizeDelta: themeData.textTheme.displaySmall!.fontSize! -
            newTextStyle.fontSize!);
  else if (targetCopyWith == 'Headline4')
    themeData.textTheme.headlineMedium!.apply(
        fontSizeDelta: themeData.textTheme.headlineMedium!.fontSize! -
            newTextStyle.fontSize!);
  else if (targetCopyWith == 'Headline5')
    themeData.textTheme.headlineSmall!.apply(
        fontSizeDelta: themeData.textTheme.headlineSmall!.fontSize! -
            newTextStyle.fontSize!);
  else if (targetCopyWith == 'Headline6')
    themeData.textTheme.titleLarge!.apply(
        fontSizeDelta:
            themeData.textTheme.titleLarge!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'SubTitle1')
    themeData.textTheme.titleMedium!.apply(
        fontSizeDelta: themeData.textTheme.titleMedium!.fontSize! -
            newTextStyle.fontSize!);
  else if (targetCopyWith == 'SubTitle2')
    themeData.textTheme.titleSmall!.apply(
        fontSizeDelta:
            themeData.textTheme.titleSmall!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'bodyText1')
    themeData.textTheme.bodyLarge!.apply(
        fontSizeDelta:
            themeData.textTheme.bodyLarge!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'bodyText2')
    themeData.textTheme.bodyMedium!.apply(
        fontSizeDelta:
            themeData.textTheme.bodyMedium!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'button')
    themeData.textTheme.labelLarge!.apply(
        fontSizeDelta:
            themeData.textTheme.labelLarge!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'caption')
    themeData.textTheme.bodySmall!.apply(
        fontSizeDelta:
            themeData.textTheme.bodySmall!.fontSize! - newTextStyle.fontSize!);
  else if (targetCopyWith == 'overline')
    themeData.textTheme.labelSmall!.apply(
        fontSizeDelta:
            themeData.textTheme.labelSmall!.fontSize! - newTextStyle.fontSize!);
}

/// returns a List<Color> with different style elements from context Theme
List<Color> getThemeSchemaColors(context) {
  return <Color>[
    YaSeApp.of(context)!.widget.AppTheme.splashColor,
    YaSeApp.of(context)!.widget.AppTheme.canvasColor,
    YaSeApp.of(context)!.widget.AppTheme.primaryColor,
    YaSeApp.of(context)!.widget.AppTheme.primaryColorDark,
    YaSeApp.of(context)!.widget.AppTheme.primaryColorLight,
    YaSeApp.of(context)!.widget.AppTheme.colorScheme.background,
    YaSeApp.of(context)!.widget.AppTheme.colorScheme.onPrimary,
    YaSeApp.of(context)!.widget.AppTheme.colorScheme.secondary,
    YaSeApp.of(context)!.widget.AppTheme.colorScheme.onSecondary,
    YaSeApp.of(context)!.widget.AppTheme.colorScheme.onBackground,
    YaSeApp.of(context)!.widget.AppTheme.colorScheme.surface,
    YaSeApp.of(context)!.widget.AppTheme.colorScheme.onSurface,
    YaSeApp.of(context)!.widget.AppTheme.colorScheme.error,
    YaSeApp.of(context)!.widget.AppTheme.colorScheme.onError,
    YaSeApp.of(context)!.widget.AppTheme.shadowColor
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
  if (itemName == 'splashColor') return themeData.copyWith(splashColor: color);
  if (itemName == 'canvasColor') return themeData.copyWith(canvasColor: color);
  if (itemName == 'primaryColor')
    return themeData.copyWith(primaryColor: color);
  if (itemName == 'primaryColorDark')
    return themeData.copyWith(primaryColorDark: color);
  if (itemName == 'primaryColorLight')
    return themeData.copyWith(primaryColorLight: color);
  if (itemName == 'backgroundColor')
    return themeData.copyWith(colorScheme: getColorScheme(themeData));
  if (itemName == 'onPrimary') {
    ColorScheme colorScheme = themeData.colorScheme.copyWith(onPrimary: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'secondaryHeaderColor')
    return themeData.copyWith(secondaryHeaderColor: color);
  if (itemName == 'onSecondary') {
    ColorScheme colorScheme =
        themeData.colorScheme.copyWith(onSecondary: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'onBackground') {
    ColorScheme colorScheme =
        themeData.colorScheme.copyWith(onBackground: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'surface') {
    ColorScheme colorScheme = themeData.colorScheme.copyWith(surface: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'onSurface') {
    ColorScheme colorScheme = themeData.colorScheme.copyWith(onSurface: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'errorColor')
    return themeData.copyWith(colorScheme: getColorScheme(themeData));
  if (itemName == 'onError') {
    ColorScheme colorScheme = themeData.colorScheme.copyWith(onError: color);
    return themeData.copyWith(colorScheme: colorScheme);
  }
  if (itemName == 'shadowColor') return themeData.copyWith(shadowColor: color);
  return themeData;
}
