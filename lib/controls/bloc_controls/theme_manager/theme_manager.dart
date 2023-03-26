import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_gen/utils/dlg_utils.dart';
import './../../../yase/yase.dart';
import 'dart:developer';

class ThemeManager with ChangeNotifier {
  Widget? _app;
  State? _appState;
  BuildContext? _context;
  String _currentTheme = "system";
  ThemeMode _themeMode = ThemeMode.system;
  Stream<ThemeData> get theme => _themeController.stream;

  Map<String, ThemeData> _availableThemes = {
    'YaSeTheme': YaSeTheme,
    'YaSeThemeDark': YaSeThemeDark,
    'YaSeThemeLight': YaSeThemeLight,
    'system': YaSeTheme,
    'dark': YaSeThemeDark,
    'light': YaSeThemeLight
  };

  ThemeManager(Widget app, BuildContext? context) {
    _app = app;
    _context = context;
  }

  StreamController<ThemeData> _themeController = StreamController<ThemeData>();

  Map<String, ThemeData> getThemeDataItems(BuildContext context) {
    return _availableThemes;
  }

  void changeThemeMode(BuildContext context, ThemeMode themeMode) {
    YaSeApp.of(context)!.setState(() {
      print("changeThemeMode: $themeMode");
      _themeMode = themeMode;
    });
    notifyListeners();
  }

  Tuple2<bool, String> removeTheme(String themeName) {
    bool result = false;
    String error = '';
    if (_availableThemes.containsKey(themeName)) {
      _availableThemes.remove(themeName);
      result = true;
    } else {
      result = true;
      error = 'Theme not found: $themeName';
    }
    notifyListeners(); // Notify all it's listeners about update. If you comment this line then you will see that new added items will not be reflected in the list.
    return Tuple2<bool, String>(result, error);
  }

  Tuple2<bool, String> addTheme(
      BuildContext context, String name, ThemeData themeData,
      {bool force = false}) {
    bool result = false;
    String error = '';
    debugger();
    if (!_availableThemes.containsKey(name)) {
      _availableThemes[name] = themeData;
      result = true;
    } else {
      if (force) {
        _availableThemes[name] = themeData;
        result = true;
      } else {
        result = false;
        error = 'Theme already exists';
      }
    }
    notifyListeners(); // Notify all it's listeners about update. If you comment this line then you will see that new added items will not be reflected in the list.
    return Tuple2<bool, String>(result, error);
  }

  void modifySystemTheme(BuildContext context,
      {ThemeData? newThemeData: null}) {
    _availableThemes['system'] = newThemeData!;
    notifyListeners();
  }

  Tuple2<bool, String> applyTheme(String newThemeName,
      {ThemeData? newThemeData: null}) {
    _availableThemes['prevSystem'] = _availableThemes['system']!;
    if (_availableThemes.containsKey(newThemeName)) {
      _availableThemes['system'] = _availableThemes[newThemeName]!;
    } else {
      _availableThemes[newThemeName] = newThemeData!;
      _availableThemes['system'] = newThemeData;
    }
    notifyListeners();
    return Tuple2<bool, String>(true, '');
  }

  void onChangeTheme(
      ThemeData value, int index, String selectedText, BuildContext context) {
    print('onChangeTheme $index $selectedText');
    var hash = _context.hashCode;
    print('_context: $hash');
    YaSeApp.of(context)!.setState(() {
      applyTheme(selectedText, newThemeData: value);
    });
  }

  Tuple2<bool, String> changeTheme(BuildContext context,
      String outgoingThemeName, String incommingThemeName) {
    Tuple2<bool, String> result = validateThemeName(
        _availableThemes, outgoingThemeName, '$outgoingThemeName not found');
    if (!result.item1) return result;
    result = validateThemeName(_availableThemes, incommingThemeName,
        '$incommingThemeName already exists');
    if (result.item1) return result;
    // Get the theme to apply
    YaSeApp.of(context)!.setState(() {
      applyTheme(incommingThemeName);
    });
    return Tuple2<bool, String>(true, '');
  }

  ThemeMode getThemeMode() {
    return _themeMode;
  }

  State getAppState() {
    debugger();
    if (_appState == null) {
      //_appState = (_app as StatefulElement).state;
      _appState = YaSeApp.of(_context!);
    }
    return _appState!;
  }

  ThemeData? getThemeData(String key) {
    if (_availableThemes.containsKey(key)) {
      return _availableThemes[key];
    }
    return null;
  }

  Map<String, ThemeData> getAvailableThemes() {
    var _filteredMap = {..._availableThemes};
    _filteredMap.remove('prevSystem');
    _filteredMap.remove('light');
    return _filteredMap;
  }

  void CreateTheme(BuildContext context) async {
    print('CreateTheme');
    String? themeName = await PromptUserInputSingleEdit(
        this._context!, 'Create Theme', 'New Theme Name', 'OK', 'Cancel');
    if (themeName!.length == 0) {
      return;
    }
    print('CreateTheme: $themeName');
    if (_availableThemes.containsKey(themeName)) {
      PromptUserBool(this._context!, 'Create Theme',
          'Theme name $themeName already exists', 'OK', '');
    } else {
      addTheme(context, themeName, Theme.of(this._context!).copyWith());
      YaSeApp.of(context)!.setState(() {
        changeTheme(context, 'system', themeName);
      });
    }
  }

  Tuple2<bool, String> validateThemeName(
      Map<String, ThemeData> availableThemes, String key, String label) {
    if (!availableThemes.containsKey(key)) {
      return Tuple2<bool, String>(false, label);
    } else {
      return Tuple2<bool, String>(true, '');
    }
  }

  List<Tuple2<String, ThemeData>> getThemeDataItemsAsListOfTuples(
      BuildContext context) {
    List<Tuple2<String, ThemeData>> themeNames = [];
    _availableThemes.entries.toList().forEach((element) {
      themeNames.add(Tuple2<String, ThemeData>(element.key, element.value));
    });
    return themeNames;
  }
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
    fontFamily: 'Arial',
    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: generalTextTheme);

ThemeData YaSeTheme = ThemeData(
    splashColor: Colors.orange,
    primarySwatch: Colors.orange,
    primaryColor: Colors.orangeAccent[800],
    backgroundColor: Colors.orange,
    brightness: Brightness.light,
    fontFamily: 'Arial',
    textTheme: generalTextTheme);

ThemeData YaSeThemeDark = ThemeData(
    // Define the default brightness and colors.
    splashColor: Colors.blueGrey,
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[800],
    backgroundColor: Colors.purple,

    // Define the default font family.
    fontFamily: 'Arial',

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: generalTextTheme,
    tabBarTheme: genericTabBarTheme);

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
  bodyText2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
);

TabBarTheme genericTabBarTheme = TabBarTheme(
  labelColor: Colors.white,
  unselectedLabelColor: Colors.grey,
  labelStyle: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
  unselectedLabelStyle: TextStyle(fontSize: 32),
);
