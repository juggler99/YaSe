import 'package:flutter/material.dart';
import './style_utils.dart';
import './button_utils.dart';
import 'dart:developer';

/// Returns a [Dialog] with the given [title], [message] and [buttons] to close the dialog
Future<void> PromptUser(BuildContext context, String title, String message,
    String textOptionTrue, String textOptionFalse) {
  ElevatedButton? buttonTrue = textOptionTrue.length > 0
      ? getElevatedButtonForClosingDialog<bool>(
          context, textOptionTrue, Colors.green, true)
      : null;
  ElevatedButton? buttonFalse = textOptionFalse.length > 0
      ? getElevatedButtonForClosingDialog<bool>(
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
                color: Theme.of(context).primaryColor,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              //),
              content:
                  Text(message, style: Theme.of(context).textTheme.subtitle2),
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
          title: Text(title, style: Theme.of(context).textTheme.subtitle1),
          content: Text(message, style: Theme.of(context).textTheme.subtitle2),
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
                      style: Theme.of(context).textTheme.subtitle1)),
              content: Container(
                  width: 300,
                  height: 120,
                  child: ListView(children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(2),
                        child: Text(
                          message,
                          style: Theme.of(context).textTheme.subtitle1,
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
