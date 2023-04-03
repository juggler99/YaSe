import 'package:flutter/material.dart';
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
    Color color = Theme.of(context).backgroundColor;
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: color,
        centerTitle: true,
        title: const Text('Ya Se!'),
      ),
      body: ListView(
        children: [textSection, backToLoginScreenButton],
      ),
    );
  }
}
