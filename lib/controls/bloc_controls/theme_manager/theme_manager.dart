import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import '../../../utils/theme_utils.dart';
import '../../../yase/app_config.dart';
import './../../../utils/dlg_utils.dart';
import './../../../utils/color_utils.dart' as cu;
import './../../../yase/yase.dart';
import 'dart:developer';

class ThemeManager with ChangeNotifier {
  Widget? _app;
  State? _appState;
  BuildContext? _context;
  String _currentThemeName = "purple";
  ThemeData? _currentTheme;
  ThemeMode _themeMode = ThemeMode.system;
  Stream<ThemeData> get theme => _themeController.stream;
  Map<String, dynamic>? _appConfig;

  Map<String, ThemeData> _availableThemes = {
    'YaSeTheme': YaSeTheme,
    'YaSeThemeDark': YaSeThemeDarkDefault,
    'YaSeThemeLight': YaSeThemeLight,
    'system': YaSeThemeDarkDefault,
    'dark': YaSeThemeDarkDefault,
    'light': YaSeThemeLight
  };

  ThemeManager(
      Widget app, BuildContext? context, Map<String, dynamic>? appConfig) {
    _app = app;
    _context = context;
    _currentTheme = _availableThemes[_currentThemeName];
    _appConfig = appConfig;
    if (_appConfig != null && _appConfig!.containsKey("themesAvailable")) {
      var themesAvailable = _appConfig!["themesAvailable"];
      if (themesAvailable.containsKey("default")) {
        {
          //if (_availableThemes != null) {
          //  _currentTheme = _availableThemes[themesAvailable["default"]];
          //} else {
          _currentTheme = createThemeFromConfig(
              context!, themesAvailable["default"], _appConfig!);

          //}
        }
      }
    }
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
      {ThemeData? newThemeData = null}) {
    _availableThemes['system'] = newThemeData!;
    notifyListeners();
  }

  Tuple2<bool, String> applyTheme(String newThemeName,
      {ThemeData? newThemeData = null}) {
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

  ThemeData? getThemeData({String key = ''}) {
    if (_availableThemes.containsKey(key)) {
      var theme = _availableThemes[key];
      if (_appConfig!.containsKey(key)) {}
      return theme;
    }
    return _currentTheme;
  }

  void setThemeDataName(String key) {
    _currentThemeName = key;
  }

  Map<String, ThemeData> getAvailableThemes() {
    var _filteredMap = {..._availableThemes};
    _filteredMap.remove('prevSystem');
    _filteredMap.remove('light');
    return _filteredMap;
  }

  ThemeData createThemeFromConfig(
      BuildContext context, String themeName, Map<String, dynamic> appConfig) {
    var themeData = ThemeData();
    if (!appConfig.containsKey("themeData")) {
      return themeData;
    }
    var themeDataDict = appConfig["themeData"];
    if (themeDataDict.containsKey(themeName)) {
      var themeDict = themeDataDict[themeName] as Map<String, dynamic>;
      themeDict.forEach((key, value) {
        themeData =
            getModfiedThemeData(themeData, key, cu.getColorByString(value));
      });
    }
    return themeData;
  }

  void CreateThemeFromUi(BuildContext context) async {
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
    brightness: Brightness.dark,
    // toolbars, tab bars, app bars
    primaryColor: Colors.lightGreen[800],

    // Define the default font family.
    fontFamily: 'Arial',
    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: generalTextTheme,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightGreen)
        .copyWith(background: Colors.orange, brightness: Brightness.dark));

ThemeData YaSeTheme = ThemeData(
    splashColor: Colors.orange,
    primaryColor: Colors.orangeAccent[800],
    brightness: Brightness.light,
    fontFamily: 'Arial',
    textTheme: generalTextTheme,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
        .copyWith(background: Colors.orange));

ThemeData getTheme(BuildContext context, String themeDataName) {
  switch (themeDataName) {
    case 'YaSeTheme':
      return YaSeTheme;
    case 'YaSeThemeLight':
      return YaSeThemeLight;
    case 'YaSeThemeDark':
      var appConfig = AppConfig.getConfig();
      var themeData = YaSeThemeDarkDefault;
      if (appConfig!.containsKey(themeDataName)) {
        var themeDataDict = appConfig[themeDataName];
        themeData = ThemeData(
            splashColor: cu.getColorByString('splashColor'),
            primaryColor: cu.getColorByString('primaryColor'),
            brightness: Brightness.light,
            fontFamily: 'Arial',
            textTheme: generalTextTheme,
            colorScheme:
                cu.getColorScheme(YaSeApp.of(context)!.widget.AppTheme));
      }
      return themeData;
    default:
      return YaSeTheme;
  }
}

ThemeData YaSeThemeDarkDefault = ThemeData(
    // Define the default brightness and colors.
    splashColor: Colors.green,
    primaryColorLight: Colors.green,
    primaryColorDark: Colors.blue,
    brightness: Brightness.dark,
    primaryColor: Colors.yellow[800],

    // Define the default font family.
    fontFamily: 'Arial',

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: generalTextTheme,
    tabBarTheme: genericTabBarTheme,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
        .copyWith(background: Colors.red, brightness: Brightness.dark));

TextTheme generalTextTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  displayMedium: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
  displaySmall: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
  headlineMedium: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
  headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
  titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
  titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
  titleSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
  bodyLarge: TextStyle(fontSize: 26.0, fontWeight: FontWeight.normal),
  bodyMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
);

TabBarTheme genericTabBarTheme = TabBarTheme(
  labelColor: Colors.white,
  unselectedLabelColor: Colors.grey,
  labelStyle: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
  unselectedLabelStyle: TextStyle(fontSize: 32),
);
