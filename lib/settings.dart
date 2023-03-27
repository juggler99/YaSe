import 'package:flutter/material.dart';
import 'package:flutter_gen/utils/style_utils.dart';
import 'package:flutter_gen/utils/dropdownlist.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
        automaticallyImplyLeading: true,
      ),
      body: Text("Settings"),
    );
  }
}
