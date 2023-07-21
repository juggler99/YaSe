import 'package:flutter/material.dart';
import '../controls/gen/python_console.dart';
import './../../../utils/os/file_open.dart' as file_open;
import './../../../utils/os/file_save.dart' as file_save;
import './../../../utils/os/file_manager.dart' as file_manager;
import 'package:flutter_localizations/flutter_localizations.dart';
import '../controls/gen/document_manager.dart';
import '../screens/editor/editor.dart';
import '../settings.dart';
import './../controls/color_picker.dart';
import './../screens/complex.dart';
import './../screens/home.dart';
import 'app_config.dart';
import './../screens/browser.dart';
import './../screens/me.dart';
import './../screens/courses.dart';
import './../screens/programs.dart';
import './../screens/theme_editor.dart';
import './../controls/bloc_controls/theme_manager/theme_manager.dart';
import './../screens/theme_manager_screen.dart';
import '../screens/login/login.dart';
import '../screens/login/forgot_password.dart';
import '../screens/login/register.dart';
import '../screens/login/logged_out.dart';
import '../screens/profile.dart';
import '../screens/profile_edit.dart';
import './../../../utils/file_utils.dart';
import './../../../utils/menu_utils.dart';
import './../controls/color_shade_picker.dart';
import '../apps/calculator/calculator.dart';
import './../screens/python_client.dart';
import './../controls/app_bars/app_bar_main.dart';
import 'dart:developer';

class YaSeApp extends StatefulWidget {
  YaSeApp({Key? key}) : super(key: key);
  ThemeManager? _themeManager = null;

  HomeScreen? _homeScreen;
  late String YaSeAppPath;
  late String YaSeAppBinPath;
  late double YaSeAppHeight;
  late double YaSeAppWidth;
  late ThemeData AppTheme;
  late Map<String, dynamic>? YaSeAppConfig;
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
    Future.delayed(Duration.zero, () async {
      // Call asynchronous method
      widget.YaSeAppPath =
          await getDefaultRootFolderAsString(appFolder: "YaSe");
      widget.YaSeAppBinPath =
          await getDefaultRootFolderAsString(appFolder: "YaSeBin");
    });
    widget.YaSeAppHeight = 0.0;
    widget.YaSeAppWidth = 0.0;
    widget.YaSeAppConfig = AppConfig.getConfig();
    print("YaSeApp Config: ${widget.YaSeAppConfig}");
    widget.setThemeManager(ThemeManager(widget, context, widget.YaSeAppConfig));
    var appThemeData = widget.getThemeManager().getThemeData();
    widget.AppTheme = appThemeData as ThemeData;
    print("Theme: primarycolor: ${widget.AppTheme.primaryColor}");
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
        //const Locale('en', 'US'),
        //const Locale('es', 'Sp'),
        // ... other locales the app supports
      ],
      locale: Locale('en'),
      debugShowCheckedModeBanner: false,
      title: 'YaSe',
      //theme: getThemeManager().getThemeData(key: "light"),
      theme: getThemeManager().getThemeData(key: "purple"),
      darkTheme: getThemeManager().getThemeData(key: "dark"),
      highContrastTheme: getThemeManager().getThemeData(key: "light"),
      themeMode: getThemeManager().getThemeMode(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const LoginScreen(),
        // When navigating to the "/second" route, build the widget.
        '/settings': (context) => const SettingsScreen(),
        '/me': (context) => const MeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/profile_edit': (context) => const ProfileEditScreen(),
        '/courses': (context) => const CoursesScreen(),
        '/programs': (context) => const ProgramsScreen(),
        '/complex': (context) => const ComplexScreen(),
        '/python_client': (context) => const PythonClientScreen(),
        '/browser': (context) => const BrowserScreen(),
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
        '/file_manager': (context) => file_manager.FileManagerDialog(),
        '/python_console': (context) => PythonConsole(),
      },
    );
  }
}
