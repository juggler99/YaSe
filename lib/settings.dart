import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import './../../utils/json_utils.dart';
import 'controls/header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var appConfigJsonStr =
        getPrettyJSONString(YaSeApp.of(context)!.widget.YaSeAppConfig);

    return Scaffold(
      appBar: Header(toolbarHeight: 40, title: "Settings"),
      body: Text(appConfigJsonStr),
    );
  }
}
