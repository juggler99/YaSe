import 'package:flutter/material.dart';
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
        buildButtonColumn(Icons.call, 'CALL', Theme.of(context)),
        buildButtonColumn(Icons.near_me, 'ROUTE', Theme.of(context)),
        buildButtonColumn(Icons.share, 'SHARE', Theme.of(context)),
      ],
    );
    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text('No Access'),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
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
