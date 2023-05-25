import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import './../../utils/style_utils.dart';
import './../../utils/json_utils.dart';
import './../../utils/dropdownlist.dart';

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
      appBar: AppBar(
        backgroundColor: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
        centerTitle: true,
        title: const Text('Settings'),
        automaticallyImplyLeading: true,
      ),
      body: Text(appConfigJsonStr),
    );
  }
}
