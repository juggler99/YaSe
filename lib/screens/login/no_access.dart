import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import './../../../utils/style_utils.dart';

class NoAccessScreen extends StatefulWidget {
  const NoAccessScreen({Key? key}) : super(key: key);
  @override
  _NoAccessScreenState createState() => _NoAccessScreenState();
}

class _NoAccessScreenState extends State<NoAccessScreen> {
  @override
  Widget build(BuildContext context) {
    final isCollapsed = false;
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildButtonColumn(
            Icons.call, 'CALL', YaSeApp.of(context)!.widget.AppTheme),
        buildButtonColumn(
            Icons.near_me, 'ROUTE', YaSeApp.of(context)!.widget.AppTheme),
        buildButtonColumn(
            Icons.share, 'SHARE', YaSeApp.of(context)!.widget.AppTheme),
      ],
    );
    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text('No Access'),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: YaSeApp.of(context)!.widget.AppTheme.backgroundColor,
        centerTitle: true,
        title: const Text('No Access'),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: [textSection, buttonSection],
      ),
    );
  }
}
