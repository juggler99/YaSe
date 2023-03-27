import 'package:flutter/material.dart';
import './../controls/bloc_controls/theme_manager/theme_manager_bloc_event.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_gen/utils/dlg_utils.dart';
import 'package:tuple/tuple.dart';
import './../controls/color_shade_picker.dart';
import './../controls/custom_card_panel.dart';
import 'package:flutter_gen/utils/dropdown_utils.dart';
import './../controls/edit_control_panel_custom.dart';
import 'package:flutter_gen/utils/theme_utils.dart';
import 'package:flutter_gen/utils/button_utils.dart';
import 'package:flutter_gen/utils/style_utils.dart';
import './../controls/color_picker.dart';
import './../controls/dlg_font.dart';
import './../controls/bloc_controls/theme_manager/theme_manager.dart';
import './../yase/yase.dart';
import './../controls/bloc_controls/theme_manager/theme_manager_bloc_provider.dart';
import 'dart:developer';

typedef OnColorChangeCallback = void Function(Color value, int index);

class ThemeEditorScreen extends StatefulWidget {
  const ThemeEditorScreen({Key? key}) : super(key: key);

  @override
  _ThemeEditorScreenState createState() => _ThemeEditorScreenState();
}

class _ThemeEditorScreenState extends State<ThemeEditorScreen> {
  ThemeManager? _themeManager;

  void _onThemeDropdownChange(String? _selectedTheme) {
    setState(() {
      _themeManager!.changeTheme(context, 'system', _selectedTheme!);
    });
  }

  void _onColorCardColorChange(
    Color value,
    int index,
  ) {
    debugger();
    print('_onColorCardColorChange');
  }

  void onChangeTheme(ThemeData value, int index) {
    print('onChangeTheme $index');
    setState(() {
      //bgColor = value;
    });
  }

  void CreateTheme() {
    print('CreateTheme');
    _themeManager!.CreateTheme(context);
  }

  void SaveTheme() {
    print('SaveTheme');
  }

  void DiscardThemeChanges() {
    print('DiscardThemeChanges');
  }

  /// Avoid deleting main themes: system, light, dark
  void DeleteTheme() {
    print('DeleteTheme');
  }

  void invokeFontDlg(
      BuildContext context, String title, TextStyle style) async {
    var currentThemeData = _themeManager!.getThemeData('system');
    var fontMap = getThemeDataFonts(currentThemeData!);
    print('title: $title');
    var modifiedStyle = await PromptFontEditDlg(context, title, style);
    if (modifiedStyle == null) return;
    fontMap[title] = modifiedStyle;
    print('style returned: $title:  $modifiedStyle');
    this.setState(() {
      print('setting state invokeFontDlg: $title');
      TextStyle textStyle = fontMap[title]!;
      //applyThemeDataTextStyle(this, title, textStyle);
      if (title == 'Headline1')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(headline1: fontMap[title]!));
      else if (title == 'Headline2')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(headline2: fontMap[title]!));
      else if (title == 'Headline3')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(headline3: fontMap[title]!));
      else if (title == 'Headline4')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(headline4: fontMap[title]!));
      else if (title == 'Headline5')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(headline5: fontMap[title]!));
      else if (title == 'Headline6')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(headline6: fontMap[title]!));
      else if (title == 'SubTitle1')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(subtitle1: fontMap[title]!));
      else if (title == 'SubTitle2')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(subtitle2: fontMap[title]!));
      else if (title == 'bodyText1')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(bodyText1: fontMap[title]!));
      else if (title == 'bodyText2')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(bodyText2: fontMap[title]!));
      else if (title == 'button')
        currentThemeData = currentThemeData!.copyWith(
            textTheme:
                currentThemeData!.textTheme.copyWith(button: fontMap[title]!));
      else if (title == 'caption')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(headline2: fontMap[title]!));
      else if (title == 'overline')
        currentThemeData = currentThemeData!.copyWith(
            textTheme: currentThemeData!.textTheme
                .copyWith(overline: fontMap[title]!));
      _themeManager!.modifySystemTheme(context, newThemeData: currentThemeData);
      print('refresh style : $textStyle');
    }
        /*
    var read = context.read<BlocThemeManagerProvider>();
    read.add(ModifySystemTheme(
        themeManager: _themeManager!, newThemeData: currentThemeData));
*/
        );
  }

  @override
  Widget build(BuildContext context) {
    _themeManager = YaSeApp.of(context)!.widget.getThemeManager();
    double cardWidth = 150;
    double cardHeight = 38;
    double panelWidth = 250;
    double panelHeight = 45;

    Color selectedColor = Colors.transparent;

    // Theme Editor Items
    List<Tuple3<String, String, VoidCallback>> iconItems = [
      Tuple3<String, String, VoidCallback>(
          'assets/icons/xplus.png', 'Create a Theme', CreateTheme),
      Tuple3<String, String, VoidCallback>(
          'assets/icons/minus.png', 'Delete a Theme', DeleteTheme),
      Tuple3<String, String, VoidCallback>(
          'assets/icons/check.png', 'Save a Theme', SaveTheme),
      Tuple3<String, String, VoidCallback>(
          'assets/icons/x.png', 'Discard changes', DiscardThemeChanges),
    ];
    var themeDataItems =
        _themeManager!.getThemeDataItemsAsListOfTuples(context);
    EditorControlPanelCustom editControlPanelCustom = EditorControlPanelCustom(
        dropdown: getCustomDropdownMenuForThemeNames<ThemeManager>(
            context,
            () => YaSeApp.of(context)!.widget.getThemeManager(),
            themeDataItems,
            "Select Theme",
            _themeManager!.onChangeTheme,
            width: 300,
            height: 50),
        iconItems: iconItems,
        themeManager: _themeManager);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Theme Editor'),
              automaticallyImplyLeading: true,
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Theme', icon: Icon(Icons.edit)),
                  Tab(text: 'Colors', icon: Icon(Icons.palette_rounded)),
                  Tab(text: 'Fonts', icon: Icon(Icons.font_download_rounded)),
                ],
              ),
            ),
            body: TabBarView(children: [
              editControlPanelCustom,
              getColorItemsView(
                  context, panelWidth, panelHeight, cardWidth, cardHeight,
                  callback: _onColorCardColorChange),
              getFontItems(this, context)
            ])));
  }
}

List<String> textStyleItems = [
  'Headline1',
  'Headline2',
  'Headline3',
  'Headline4',
  'Headline5',
  'Headline6',
  'SubTitle1',
  'SubTitle2',
  'bodyText1',
  'bodyText2',
  'button',
  'caption',
  'overline'
];

SingleChildScrollView getFontItems(
    _ThemeEditorScreenState state, BuildContext context) {
  print('getFontItems');
  var fontMap = getThemeDataFonts(state._themeManager!.getThemeData('system')!);
  List<Widget> items = [];
  for (int i = 0; i < textStyleItems.length; i++) {
    var size = fontMap[textStyleItems[i]]!.fontSize;
    var name = textStyleItems[i];
    print('getFontItems $name : $size');
    items.add(getTextButtonWithValue<TextStyle>(
        context,
        textStyleItems[i],
        Theme.of(context).primaryColor,
        fontMap[textStyleItems[i]]!,
        fontMap[textStyleItems[i]]!, () async {
      state.invokeFontDlg(
          context, textStyleItems[i], fontMap[textStyleItems[i]]!);
    }));
  }
  return SingleChildScrollView(child: Column(children: items));
}

SingleChildScrollView getColorItemsView(BuildContext context, double panelWidth,
    double panelHeight, double cardWidth, double cardHeight,
    {OnColorChangeCallback? callback}) {
  List<Widget> widgets = [];
  getThemeSchemaColorsCombo(context).forEach((e) => widgets.add(
      getCustomCardPanelItem(context, e.item1, e.item2, panelWidth, panelHeight,
          cardHeight, callback)));
  return SingleChildScrollView(child: Column(children: widgets));
}

CustomCardPanel getCustomCardPanelItem(
    BuildContext context,
    String label,
    Color backgroundColor,
    double panelWidth,
    double panelHeight,
    double cardHeight,
    OnColorChangeCallback? callback) {
  return CustomCardPanel(
      label: label,
      panelWidth: panelWidth,
      panelHeight: panelHeight,
      cardHeight: cardHeight,
      backgroundColor: backgroundColor,
      callback: callback);
}
