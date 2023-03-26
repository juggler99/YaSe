import 'package:flutter/material.dart';
import './court.dart';
import './home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const Home(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/pong': (context) => const GameContainer(),
      },
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
    );
  }
}
