import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import '../controls/header.dart';
import './../../../utils/style_utils.dart';
import './../../../utils/dropdownlist.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  Widget build(BuildContext context) {
    final isCollapsed = false;
    // Color color = Colors.blue;
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
      child: Text('Courses'),
    );

    Widget menuSection = CustomDropdown<int>(
      child: Text(
        'dropdown',
        style: TextStyle(fontSize: 40),
      ),
      onChange: (int value, int index, String label, BuildContext context) =>
          print(value),
      dropdownButtonStyle: DropdownButtonStyle(
          width: 50,
          height: 40,
          elevation: 1,
          backgroundColor: Colors.white,
          primaryColor: Colors.black87,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      dropdownStyle: DropdownStyle(
        borderRadius: BorderRadius.circular(8),
        elevation: 6,
        padding: EdgeInsets.all(5),
      ),
      items: [
        'item 1',
        'item 2',
        'item 3',
        'item 4',
        'item 5',
      ]
          .asMap()
          .entries
          .map(
            (item) => DropdownItem<int>(
              value: item.key + 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item.value, style: TextStyle(fontSize: 20)),
              ),
            ),
          )
          .toList(),
    );

    var _listView = ListView(
      children: [textSection, buttonSection, menuSection],
    );
    return Scaffold(
      appBar: Header(title: 'Courses'),
      body: _listView,
    );
  }
}
