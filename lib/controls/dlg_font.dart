import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import './../../utils/style_utils.dart';
import './../../utils/button_utils.dart';
import 'dart:developer';

Map<String, TextStyle?> getFonts(BuildContext context) {
  var result = Map<String, TextStyle?>();
  result['Headline1'] = Theme.of(context).textTheme.headline1;
  result['Headline2'] = Theme.of(context).textTheme.headline2;
  result['Headline3'] = Theme.of(context).textTheme.headline3;
  result['Headline4'] = Theme.of(context).textTheme.headline4;
  result['Headline5'] = Theme.of(context).textTheme.headline5;
  result['Headline6'] = Theme.of(context).textTheme.headline6;
  result['SubTitle1'] = Theme.of(context).textTheme.subtitle1;
  result['SubTitle2'] = Theme.of(context).textTheme.subtitle2;
  result['bodyText1'] = Theme.of(context).textTheme.bodyText1;
  result['bodyText2'] = Theme.of(context).textTheme.bodyText2;
  result['button'] = Theme.of(context).textTheme.button;
  result['caption'] = Theme.of(context).textTheme.caption;
  result['overline'] = Theme.of(context).textTheme.overline;
  return result;
}

Map<String, TextStyle?> getThemeDataFonts(ThemeData themeData) {
  var result = Map<String, TextStyle?>();
  result['Headline1'] = themeData.textTheme.headline1;
  result['Headline2'] = themeData.textTheme.headline2;
  result['Headline3'] = themeData.textTheme.headline3;
  result['Headline4'] = themeData.textTheme.headline4;
  result['Headline5'] = themeData.textTheme.headline5;
  result['Headline6'] = themeData.textTheme.headline6;
  result['SubTitle1'] = themeData.textTheme.subtitle1;
  result['SubTitle2'] = themeData.textTheme.subtitle2;
  result['bodyText1'] = themeData.textTheme.bodyText1;
  result['bodyText2'] = themeData.textTheme.bodyText2;
  result['button'] = themeData.textTheme.button;
  result['caption'] = themeData.textTheme.caption;
  result['overline'] = themeData.textTheme.overline;
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

    TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;

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
