import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import './button_utils.dart';

/// Returns a [Dialog] with the given [title], [message] and [buttons] to close the dialog
Future<void> PromptUser(BuildContext context, String title, String message,
    String textOptionTrue, String textOptionFalse,
    {void Function()? onTrue = null, void Function()? onFalse = null}) {
  ElevatedButton? buttonTrue = textOptionTrue.length > 0
      ? getElevatedButtonForClosingDialog<bool>(
          context, textOptionTrue, Colors.green, true,
          callback: onTrue)
      : null;
  ElevatedButton? buttonFalse = textOptionFalse.length > 0
      ? getElevatedButtonForClosingDialog<bool>(
          context, textOptionFalse, Colors.red, false,
          callback: onFalse)
      : null;

  List<Widget> actionItems = [];

  List<Widget>? getActionItems() {
    if (textOptionFalse.length > 0) {
      actionItems.add(buttonFalse!);
    }
    if (textOptionTrue.length > 0) {
      actionItems.add(buttonTrue!);
    }
    return actionItems;
  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              titlePadding:
                  EdgeInsets.only(left: 1, top: 1, right: 1, bottom: 1),
              title:
                  //Expanded(child:
                  Container(
                //padding:
                //    EdgeInsets.only(left: 1, top: 1, right: 1, bottom: 1),
                height: 40,
                alignment: Alignment.center,
                color: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
                child: Text(
                  title,
                  style:
                      YaSeApp.of(context)!.widget.AppTheme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              //),
              content: Text(message,
                  style:
                      YaSeApp.of(context)!.widget.AppTheme.textTheme.titleSmall),
              actions: getActionItems(),
            ),
          ]);
    },
  );
}

/// Returns a [Dialog] with the given [title], [message] and [buttons] to close the dialog, returns a boolean
Future<bool?> PromptUserBool(BuildContext context, String title, String message,
    String textOptionTrue, String textOptionFalse) {
  TextButton? buttonTrue = textOptionTrue.length > 0
      ? getTextButtonForClosingDialog<bool>(
          context, textOptionTrue, Colors.green, true)
      : null;
  TextButton? buttonFalse = textOptionFalse.length > 0
      ? getTextButtonForClosingDialog<bool>(
          context, textOptionFalse, Colors.red, false)
      : null;

  List<Widget> actionItems = [];

  List<Widget>? getActionItems() {
    if (textOptionFalse.length > 0) {
      actionItems.add(buttonFalse!);
    }
    if (textOptionTrue.length > 0) {
      actionItems.add(buttonTrue!);
    }
    return actionItems;
  }

  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return Expanded(
        child: AlertDialog(
          title: Text(title,
              style: YaSeApp.of(context)!.widget.AppTheme.textTheme.titleMedium),
          content: Text(message,
              style: YaSeApp.of(context)!.widget.AppTheme.textTheme.titleSmall),
          actions: getActionItems(),
        ),
      );
    },
  ).then((exit) {
    //print('exit');
    if (exit == null) return;
    if (exit) {
      // user pressed Yes button
      print(title + ' exit true');
    } else {
      // user pressed No button
      print(title + ' exit false');
    }
    return null;
  });
}

/// Returns a [Dialog] with the given [title], [message] and [buttons] to close the dialog,
/// allows the user to edit a string
Future<String?> PromptUserInputSingleEdit(BuildContext context, String title,
    String message, String textOptionTrue, String textOptionFalse) {
  TextEditingController valueController = TextEditingController();

  TextButton? buttonTrue = textOptionTrue.length > 0
      ? getTextButtonForClosingDialog<bool>(
          context, textOptionTrue, Colors.green, true)
      : null;
  TextButton? buttonFalse = textOptionFalse.length > 0
      ? getTextButtonForClosingDialog<bool>(
          context, textOptionFalse, Colors.red, false)
      : null;

  List<Widget> actionItems = [];

  List<Widget>? getActionItems() {
    if (textOptionFalse.length > 0) {
      actionItems.add(buttonFalse!);
    }
    if (textOptionTrue.length > 0) {
      actionItems.add(buttonTrue!);
    }
    return actionItems;
  }

  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Flex(direction: Axis.vertical, children: [
          Expanded(
            child: AlertDialog(
              title: Center(
                  child: Text(title,
                      style: YaSeApp.of(context)!
                          .widget
                          .AppTheme
                          .textTheme
                          .titleMedium)),
              content: Container(
                  width: 300,
                  height: 120,
                  child: ListView(children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(2),
                        child: Text(
                          message,
                          style: YaSeApp.of(context)!
                              .widget
                              .AppTheme
                              .textTheme
                              .titleMedium,
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: TextField(
                        controller: valueController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          //labelText: 'User Name',
                        ),
                      ),
                    ),
                  ])),
              actions: getActionItems(),
            ),
          )
        ]);
      }).then((exit) {
    print('exit');
    String value = valueController.text;
    print('Value Entered: $value');
    if (exit!) {
      // user pressed Yes button
      print('Value taken');
      return valueController.text;
    } else {
      // user pressed No button
      print('Value ignored');
      return '';
    }
  });
}
