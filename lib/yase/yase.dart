import 'dart:collection';

import 'package:flutter/material.dart';
import '../controls/gen/python_console.dart';
import './../../../utils/os/file_open.dart' as file_open;
import './../../../utils/os/file_save.dart' as file_save;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../controls/bloc_controls/py_code/py_editor.dart';
import '../controls/gen/document_manager.dart';
import '../screens/editor/editor.dart';
import '../settings.dart';
import './../controls/color_picker.dart';
import './../screens/complex.dart';
import './../screens/home.dart';
import 'main.dart';
import './../screens/account_screen.dart';
import './../screens/home.dart';
import './../screens/me.dart';
import './../screens/courses.dart';
import './../screens/programs.dart';
import './../screens/theme_editor.dart';
import './../controls/bloc_controls/theme_manager/theme_manager.dart';
import './../screens/theme_manager_screen.dart';
import '../screens/login/login.dart';
import '../screens/login/forgot_password.dart';
import '../screens/login/no_access.dart';
import '../screens/login/register.dart';
import '../screens/login/logged_out.dart';
import './../../../utils/file_utils.dart';
import './../../../utils/style_utils.dart';
import './../../../utils/theme_utils.dart';
import './../../../utils/menu_utils.dart';
import './../controls/color_shade_picker.dart';
import '../apps/calculator/calculator.dart';
import './../screens/python_client.dart';
import './../controls/app_bars/app_bar_main.dart';
import './../../../utils/yaml_utils.dart';
import 'dart:developer';

class YaSeApp extends StatefulWidget {
  YaSeApp({Key? key}) : super(key: key);
  ThemeManager? _themeManager = null;
  HomeScreen? _homeScreen;
  late String YaSeAppPath;
  late double YaSeAppHeight;
  late double YaSeAppWidth;
  Map<String, dynamic>? routes;

  ThemeManager getThemeManager() => _themeManager!;
  void setThemeManager(ThemeManager value) => _themeManager = value;

  @override
  _YaSeAppState createState() => _YaSeAppState();

  AppBarMain? _appBarMain;
  List<PopupMenuItem<ListTile>>? _appBarNavMenutItems;

  static _YaSeAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_YaSeAppState>();
}

class _YaSeAppState extends State<YaSeApp> {
  ThemeManager getThemeManager() => widget._themeManager!;

  @override
  void initState() {
    print("YaseApp initState");
    widget.setThemeManager(ThemeManager(widget, context));
    super.initState();
    widget._appBarNavMenutItems = [
      getPopupMenuItemNav(
          context, Icons.account_box_sharp, 'Logout', 'loggedout'),
      getPopupMenuItemNav(
          context, Icons.palette, 'Theme Manager', 'theme_manager'),
      getPopupMenuItemNav(
          context, Icons.add_circle_outline, 'Calculator', 'calculator'),
      getPopupMenuItemNav(context, Icons.add_circle_outline, 'Bloc Calculator',
          'bloc_calculator'),
      getPopupMenuItemNav(context, Icons.edit, 'Editor', 'py_editor')
    ];

    Future.delayed(Duration.zero, () async {
      // Call your asynchronous method here
      widget.YaSeAppPath =
          await getDefaultRootFolderAsString(appFolder: "YaSe");
    });

    widget.YaSeAppHeight = 0.0;
    widget.YaSeAppWidth = 0.0;

/*
    Future.delayed(Duration(seconds: 3), () async {
      debugger;
      widget.routes = await loadYamlAsset(
          concatPaths([widget.YaSeAppPath, "assets/routes/routes.yaml"]));
    });
*/

    widget._appBarMain =
        AppBarMain(title: "YaSe", navMenuItems: widget._appBarNavMenutItems);
  }

  @override
  Widget build(BuildContext context) {
    print("YaseApp build");
    var hash = context.hashCode;
    print('build context: $hash');

    widget._homeScreen = HomeScreen();

    print("routes: ${widget.routes}");

    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'UK'), // English
        // ... other locales the app supports
      ],
      debugShowCheckedModeBanner: false,
      title: 'YaSe',
      theme: getThemeManager().getThemeData("system"),
      darkTheme: getThemeManager().getThemeData("dark"),
      highContrastTheme: getThemeManager().getThemeData("light"),
      themeMode: getThemeManager().getThemeMode(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const LoginScreen(),
        // When navigating to the "/second" route, build the widget.
        '/settings': (context) => const SettingsScreen(),
        '/me': (context) => const MeScreen(),
        '/courses': (context) => const CoursesScreen(),
        '/programs': (context) => const ProgramsScreen(),
        '/complex': (context) => const ComplexScreen(),
        '/python_client': (context) => const PythonClientScreen(),
        '/forgotPassword': (context) => const ForgotPasswordScreen(),
        '/home': (context) => widget._homeScreen!,
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/loggedout': (context) => const LoggedOutScreen(),
        '/theme_manager': (context) => const ThemeManagerScreen(),
        '/theme_editor': (context) => const ThemeEditorScreen(),
        '/color_picker': (context) => ColorPickerPanel(),
        '/colorShade_picker': (context) => ColorShadePickerPanel(),
        '/calculator': (context) => Calculator(),
        '/editor': (context) => Editor(),
        '/documentManager': (context) => DocumentManager(),
        '/file_open': (context) => file_open.FileOpenDialog(),
        '/file_save': (context) => file_save.FileSaveDialog(),
        '/python_console': (context) => PythonConsole(),
      },
    );
  }
}
