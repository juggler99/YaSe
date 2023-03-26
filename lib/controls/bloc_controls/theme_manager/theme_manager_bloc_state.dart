import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import './theme_manager.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

abstract class ThemeManagerState extends Equatable {
  final ThemeManager themeManager;
  final String themeName;
  final ThemeData themeData;
  final ThemeMode themeMode;
  final bool result;
  final String error;
  final List<Tuple2<String, ThemeData>> themeNames;
  ThemeManagerState(
      {required this.themeManager,
      required this.themeName,
      required this.themeData,
      required this.themeMode,
      required this.result,
      required this.error,
      required this.themeNames})
      : assert(themeManager != null &&
            themeName != null &&
            themeData != null &&
            themeMode != null);

  final Map<String, ThemeData> availableThemes = {
    'YaSeTheme': YaSeTheme,
    'YaSeThemeDark': YaSeThemeDark,
    'YaSeThemeLight': YaSeThemeLight,
    'system': YaSeTheme,
    'dark': YaSeThemeDark,
    'light': YaSeThemeLight
  };

  @override
  List<Object> get props => [
        themeManager,
        themeName,
        themeData,
        themeMode,
        result,
        error,
        availableThemes
      ];
}

class ThemeManagerInitial extends ThemeManagerState {
  ThemeManagerInitial()
      : super(
            themeManager: ThemeManager(Text(''), null),
            themeName: 'system',
            themeData: ThemeData(),
            themeMode: ThemeMode.system,
            result: true,
            error: '',
            themeNames: []);
}

class ThemeChanged extends ThemeManagerState {
  ThemeChanged(
      {required themeManager,
      required themeName,
      required themeData,
      required themeMode,
      required result,
      required error,
      required themeNames})
      : assert(themeName != null && themeData != null && themeMode != null),
        super(
            themeManager: themeManager,
            themeName: themeName,
            themeData: themeData,
            themeMode: themeMode,
            result: result,
            error: error,
            themeNames: themeNames);
  @override
  List<Object> get props =>
      [themeManager, themeName, themeData, themeMode, themeNames];
}

ThemeData YaSeThemeLight = ThemeData(
    splashColor: Colors.lightGreen,
    // Define the default brightness and colors.
    primarySwatch: Colors.lightGreen,
    brightness: Brightness.dark,
    // toolbars, tab bars, app bars
    primaryColor: Colors.lightGreen[800],
    backgroundColor: Colors.orange,

    // Define the default font family.
    fontFamily: 'Georgia',
    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: generalTextTheme);

ThemeData YaSeTheme = ThemeData(
    splashColor: Colors.orange,
    primarySwatch: Colors.orange,
    primaryColor: Colors.orangeAccent[800],
    backgroundColor: Colors.orange,
    brightness: Brightness.light,
    fontFamily: 'Times',
    textTheme: generalTextTheme);

ThemeData YaSeThemeDark = ThemeData(
    // Define the default brightness and colors.
    splashColor: Colors.blueGrey,
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[800],
    backgroundColor: Colors.purple,

    // Define the default font family.
    fontFamily: 'Courier',

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: generalTextTheme);

TextTheme generalTextTheme = TextTheme(
  headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
  headline3: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
  headline4: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
  headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
  headline6: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
  subtitle1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
  subtitle2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
  bodyText1: TextStyle(fontSize: 26.0, fontWeight: FontWeight.normal),
  bodyText2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.normal),
);
