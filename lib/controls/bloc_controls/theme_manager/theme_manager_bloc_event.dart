import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'theme_manager.dart';

abstract class ThemeManagerEvent extends Equatable {
  const ThemeManagerEvent();
}

class RemoveTheme extends ThemeManagerEvent {
  final ThemeManager themeManager;
  final String themeName;
  const RemoveTheme({required this.themeManager, required this.themeName});
  @override
  List<Object> get props => [themeManager, themeName];
}

class AddTheme extends ThemeManagerEvent {
  final ThemeManager themeManager;
  final String themeName;
  final ThemeData themeData;
  final bool force;
  const AddTheme(
      {required this.themeManager,
      required this.themeName,
      required this.themeData,
      this.force = false});
  @override
  List<Object> get props => [themeManager, themeName, themeData];
}

class ChangeMode extends ThemeManagerEvent {
  final ThemeManager themeManager;
  final ThemeMode mode;
  const ChangeMode({required this.themeManager, required this.mode});
  @override
  List<Object> get props => [themeManager, mode];
}

class ModifySystemTheme extends ThemeManagerEvent {
  final ThemeManager themeManager;
  final ThemeData newThemeData;
  const ModifySystemTheme(
      {required this.themeManager, required this.newThemeData});
  @override
  List<Object> get props => [themeManager, newThemeData];
}

class ApplyTheme extends ThemeManagerEvent {
  final ThemeManager themeManager;
  final String themeName;
  final ThemeData themeData;
  const ApplyTheme(
      {required this.themeManager,
      required this.themeName,
      required this.themeData});
  @override
  List<Object> get props => [themeManager, themeName, themeData];
}

class SwapTheme extends ThemeManagerEvent {
  final ThemeManager themeManager;
  final String outgoingThemeName;
  final String incommingThemeName;
  const SwapTheme(
      {required this.themeManager,
      required this.outgoingThemeName,
      required this.incommingThemeName});
  @override
  List<Object> get props =>
      [themeManager, outgoingThemeName, incommingThemeName];
}

class GetThemeMode extends ThemeManagerEvent {
  final ThemeManager themeManager;
  const GetThemeMode({required this.themeManager});
  @override
  List<Object> get props => [themeManager];
}

class GetThemeData extends ThemeManagerEvent {
  final ThemeManager themeManager;
  final ThemeData themeName;
  const GetThemeData({required this.themeManager, required this.themeName});
  @override
  List<Object> get props => [themeManager, themeName];
}

class GetAvailableThemes extends ThemeManagerEvent {
  final ThemeManager themeManager;
  const GetAvailableThemes({required this.themeManager});
  @override
  List<Object> get props => [themeManager];
}

class CreateTheme extends ThemeManagerEvent {
  final ThemeManager themeManager;
  const CreateTheme({required this.themeManager});
  @override
  List<Object> get props => [themeManager];
}

class ValidateThemeName extends ThemeManagerEvent {
  final ThemeManager themeManager;
  final ThemeData themeName;
  const ValidateThemeName({required this.themeManager, required this.themeName});
  @override
  List<Object> get props => [themeManager, themeName];
}

class GetThemeDataItemsAsListOfTuples extends ThemeManagerEvent {
  final ThemeManager themeManager;
  const GetThemeDataItemsAsListOfTuples({required this.themeManager});
  @override
  List<Object> get props => [themeManager];
}
