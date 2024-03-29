import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import './../../../utils/style_utils.dart';
import './../../../utils/dropdownlist.dart';

class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({Key? key}) : super(key: key);
  @override
  _ProgramsScreenState createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
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
      child: Text('Programs'),
    );

    Widget menuSection = CustomDropdown<Color>(
        child: Text(
          'dropdown',
          style: TextStyle(fontSize: 40),
        ),
        onChange:
            (Color value, int index, String label, BuildContext context) =>
                print(value),
        dropdownButtonStyle: DropdownButtonStyle(
            width: 50,
            height: 40,
            elevation: 1,
            backgroundColor: Colors.white,
            primaryColor: Colors.black87,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        dropdownStyle: DropdownStyle(
          borderRadius: BorderRadius.circular(8),
          elevation: 6,
          padding: EdgeInsets.all(5),
        ),
        items: getDropdownItems(getPrimaryColorsAsListOfTuples()));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
        centerTitle: true,
        title: const Text('Programs'),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: [textSection, buttonSection, menuSection],
      ),
    );
  }
}
