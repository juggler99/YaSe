import 'package:flutter/material.dart';
import './../../../utils/button_utils.dart';
import './../../../utils/collection_utils.dart';
import './../../../utils/color_utils.dart';
import './../../../utils/style_utils.dart';
import './../yase/yase.dart';

class ThemeManagerScreen extends StatefulWidget {
  const ThemeManagerScreen({Key? key}) : super(key: key);
  @override
  _ThemeManagerScreenState createState() => _ThemeManagerScreenState();
}

class _ThemeManagerScreenState extends State<ThemeManagerScreen> {
  var _themeManager;
  ThemeMode? selectedThemeMode;
  String? selectedThemeModeStr;
  List<String> _themeItems = ['system', 'light', 'dark'];

  @override
  Widget build(BuildContext context) {
    _themeManager = YaSeApp.of(context)!.widget.getThemeManager();
    Color color = YaSeApp.of(context)!.widget.AppTheme.colorScheme.background;
    Widget buttonSection = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SingleChildScrollView(
            child: Column(children: [
          TextButton(
              child: Text('Add Theme'),
              onPressed: () {
                setState(() {
                  _themeManager!.addTheme(
                      context,
                      'floater',
                      ThemeData(
                          primaryColor: Colors.blue,
                          colorScheme: getColorScheme(
                              YaSeApp.of(context)!.widget.AppTheme)));
                });
              }),
          TextButton(
              child: Text('Change Theme'),
              onPressed: () {
                setState(() {
                  _themeManager!.changeTheme(context, 'system', 'floater');
                });
              }),
          TextButton(
              child: Text('Restore Theme'),
              onPressed: () {
                setState(() {
                  _themeManager!.changeTheme(context, 'system', 'YaSeTheme');
                });
              }),
          TextButton(
              child: Text('Click me'),
              onPressed: () {
                print('Click me');
              }),
          Icon(Icons.font_download_rounded)
        ])),
        TextButton(
          child: Center(
            child: Text('Click Me'),
            //style: YaSeApp.of(context)!.widget.AppTheme.textTheme.subtitle1)
          ),
          style: generateTextButtonStyle(YaSeApp.of(context)!.widget.AppTheme),
          onPressed: () {},
        ),
        ElevatedButton(
          child: Center(
              child: Text('Click Me',
                  style: YaSeApp.of(context)!
                      .widget
                      .AppTheme
                      .textTheme
                      .titleMedium)),
          style: generateButtonStyle(YaSeApp.of(context)!.widget.AppTheme),
          onPressed: () {},
        ),
        Container(
          height: 50,
          width: 50,
        ),
      ],
    );

    List<DropdownMenuItem<String>>? menuItems = [
      for (final themeMode in _themeItems) makeDropdownMenuItem(themeMode)
    ];

    selectedThemeMode = _themeManager.getThemeMode();
    int idx = ThemeMode.values.indexOf(selectedThemeMode!);
    selectedThemeModeStr = _themeItems[idx];
    print(
        'selectedThemeMode: $selectedThemeMode idx: $idx  selectedThemeModeStr: $selectedThemeModeStr');

    void changedDropDownItem(String? _selectedThemeMode) {
      print(
          "Selected ThemeMode $selectedThemeMode, we are going to refresh the UI");
      setState(() {
        selectedThemeModeStr = _selectedThemeMode;
        int idx = _themeItems.indexOf(_selectedThemeMode.toString());
        selectedThemeMode = ThemeMode.values[idx];
        _themeManager.changeThemeMode(context, selectedThemeMode!);
        print(
            "selectedThemeMode: $selectedThemeMode idx: $idx  selectedThemeModeStr: $selectedThemeModeStr");
      });
    }

    Container dropdownContainer = Container(
        width: 100,
        decoration: BoxDecoration(
            color: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedThemeModeStr,
            items: menuItems,
            onChanged: changedDropDownItem,
            alignment: AlignmentDirectional.center,
            style: TextStyle(
                backgroundColor:
                    YaSeApp.of(context)!.widget.AppTheme.primaryColor,
                fontSize: 20),
            underline: Container(),
          ),
        ));

    return Scaffold(
      appBar: AppBar(
          backgroundColor: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
          centerTitle: true,
          title: const Text('Theme Manager'),
          automaticallyImplyLeading: true,
          actions: [
            getNavIconButton(context, Icons.edit, 'theme_editor',
                popPrev: false)
          ]),
      body: ListView(
        children: [buttonSection, dropdownContainer],
      ),
    );
  }
}
