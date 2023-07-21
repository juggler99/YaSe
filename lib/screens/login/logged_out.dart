import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import '../../controls/header.dart';
import './../../../utils/style_utils.dart';

class LoggedOutScreen extends StatefulWidget {
  const LoggedOutScreen({Key? key}) : super(key: key);
  @override
  _LoggedOutScreenState createState() => _LoggedOutScreenState();
}

class _LoggedOutScreenState extends State<LoggedOutScreen> {
  @override
  Widget build(BuildContext context) {
    // Color color = Colors.blue;
    Color color = YaSeApp.of(context)!.widget.AppTheme.colorScheme.background;
    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Center(child: Text('You are now logged out')),
    );

    TextButton? backToLoginScreenButton = TextButton(
        child: Text('Login Screen'),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(getColorBlue)),
        onPressed: () {
          //Navigator.pop(context, true);
          Navigator.pushReplacementNamed(context, '/login');
        });

    return Scaffold(
      appBar: Header(title: 'Ya Se!', goBackArrow: false),
      body: ListView(
        children: [textSection, backToLoginScreenButton],
      ),
    );
  }
}
