import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import 'package:tuple/tuple.dart';
import './../../utils/button_utils.dart';

Map<String, TextStyle?> getFonts(BuildContext context) {
  var result = Map<String, TextStyle?>();
  result['Headline1'] =
      YaSeApp.of(context)!.widget.AppTheme.textTheme.displayLarge;
  result['Headline2'] =
      YaSeApp.of(context)!.widget.AppTheme.textTheme.displayMedium;
  result['Headline3'] =
      YaSeApp.of(context)!.widget.AppTheme.textTheme.displaySmall;
  result['Headline4'] =
      YaSeApp.of(context)!.widget.AppTheme.textTheme.headlineMedium;
  result['Headline5'] =
      YaSeApp.of(context)!.widget.AppTheme.textTheme.headlineSmall;
  result['Headline6'] =
      YaSeApp.of(context)!.widget.AppTheme.textTheme.titleLarge;
  result['SubTitle1'] =
      YaSeApp.of(context)!.widget.AppTheme.textTheme.titleMedium;
  result['SubTitle2'] =
      YaSeApp.of(context)!.widget.AppTheme.textTheme.titleSmall;
  result['bodyText1'] =
      YaSeApp.of(context)!.widget.AppTheme.textTheme.bodyLarge;
  result['bodyText2'] =
      YaSeApp.of(context)!.widget.AppTheme.textTheme.bodyMedium;
  result['button'] = YaSeApp.of(context)!.widget.AppTheme.textTheme.labelLarge;
  result['caption'] = YaSeApp.of(context)!.widget.AppTheme.textTheme.bodySmall;
  result['overline'] = YaSeApp.of(context)!.widget.AppTheme.textTheme.labelSmall;
  return result;
}

Map<String, TextStyle?> getThemeDataFonts(ThemeData themeData) {
  var result = Map<String, TextStyle?>();
  result['Headline1'] = themeData.textTheme.displayLarge;
  result['Headline2'] = themeData.textTheme.displayMedium;
  result['Headline3'] = themeData.textTheme.displaySmall;
  result['Headline4'] = themeData.textTheme.headlineMedium;
  result['Headline5'] = themeData.textTheme.headlineSmall;
  result['Headline6'] = themeData.textTheme.titleLarge;
  result['SubTitle1'] = themeData.textTheme.titleMedium;
  result['SubTitle2'] = themeData.textTheme.titleSmall;
  result['bodyText1'] = themeData.textTheme.bodyLarge;
  result['bodyText2'] = themeData.textTheme.bodyMedium;
  result['button'] = themeData.textTheme.labelLarge;
  result['caption'] = themeData.textTheme.bodySmall;
  result['overline'] = themeData.textTheme.labelSmall;
  return result;
}

class FontPanel extends StatelessWidget {
  TextEditingController sizeController = TextEditingController();
  String title = '';
  TextStyle? style = null;
  List<bool> fontModeList = [false, false, false];

  FontPanel(String title, TextStyle style) {
    this.title = title;
    this.style = style;
    sizeController.text = style.fontSize.toString();
    fontModeList[0] = style.fontWeight == FontWeight.bold ? true : false;
    fontModeList[1] = style.fontStyle == FontStyle.italic ? true : false;
    //fontModeList[2] = style.decoration == ui.underline ? true : false;
  }

  void MakeBold() {
    style = style!.copyWith(fontWeight: FontWeight.bold);
  }

  void MakeItalic() {
    style = style!.copyWith(fontStyle: FontStyle.italic);
  }

  void MakeUnderline() {
    //style = style!.copyWith(decoration: ui.underline);
  }

  @override
  Widget build(BuildContext context) {
    // Theme Editor Items
    List<Tuple3<String, String, VoidCallback>> iconItems = [
      Tuple3<String, String, VoidCallback>(
          'assets/icons/bold.png', 'Bold', MakeBold),
      Tuple3<String, String, VoidCallback>(
          'assets/icons/italics.png', 'Italic', MakeItalic),
      Tuple3<String, String, VoidCallback>(
          'assets/icons/underline.png', 'Underline', MakeUnderline),
    ];

    String textOptionTrue = 'OK';
    String textOptionFalse = 'Cancel';

    TextButton? buttonTrue = textOptionTrue.length > 0
        ? getTextButtonForClosingDialog<bool>(
            context, textOptionTrue, Colors.green, true)
        : null;
    TextButton? buttonFalse = textOptionFalse.length > 0
        ? getTextButtonForClosingDialog<bool>(
            context, textOptionFalse, Colors.red, false)
        : null;

    List<Widget> actionItems = [buttonFalse!, buttonTrue!];

    List<Widget> toggleButtonIcons = [
      Icon(Icons.format_bold, size: 40),
      Icon(Icons.format_italic, size: 40),
      Icon(Icons.format_underline, size: 40),
    ];

    TextStyle? titleStyle =
        YaSeApp.of(context)!.widget.AppTheme.textTheme.titleMedium;

    return StatefulBuilder(builder: (context, setState) {
      return Flex(direction: Axis.vertical, children: [
        Expanded(
          child: AlertDialog(
            title: Center(child: Text(title, style: titleStyle)),
            content: Container(
                width: 50,
                height: 240,
                child: ListView(children: <Widget>[
                  Container(
                      width: 50,
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: TextField(
                        onSubmitted: (value) {
                          setState(() {
                            this.style = this.style!.copyWith(
                                fontSize: double.parse(sizeController.text));
                          });
                        },
                        controller: sizeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          //labelText: 'User Name',
                        ),
                      )),
                  Center(
                      child: ToggleButtons(
                          children: toggleButtonIcons,
                          onPressed: (int index) {
                            setState(() {
                              fontModeList[index] = !fontModeList[index];
                              this.style = this.style!.copyWith(
                                  fontWeight: fontModeList[0] == true
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontStyle: fontModeList[1] == true
                                      ? FontStyle.italic
                                      : FontStyle.normal);
                              //,
                              //decoration: fontModeList[2] == true
                              //    ? ui.underline
                              //    : ui.none);
                            });
                          },
                          isSelected: fontModeList)),
                  Container(
                      child: SizedBox(
                          width: 80,
                          height: 150,
                          child:
                              Center(child: Text('Ab 12', style: this.style))))
                ])),
            actions: actionItems,
          ),
        )
      ]);
    });
  }
}

Future<TextStyle?> PromptFontEditDlg(
    BuildContext context, String title, TextStyle style) {
  var fontPanel = FontPanel(title, style);
  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return fontPanel;
      }).then((exit) {
    print('exit');
    String value = fontPanel.sizeController.text;
    print('Value Entered: $value');
    if (exit!) {
      // user pressed Yes button
      print('Value taken');
      style = fontPanel.style!.copyWith(
          fontSize: double.parse(value),
          fontWeight: fontPanel.style!.fontWeight,
          fontStyle: fontPanel.style!.fontStyle,
          decoration: fontPanel.style!.decoration);
      return style;
    } else {
      // user pressed No button
      print('Value ignored');
      return null;
    }
  });
}
