import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import './../../../utils/color_utils.dart';

class EditorFooter extends StatelessWidget {
  const EditorFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: YaSeApp.of(context)!.widget.AppTheme.copyWith(
          colorScheme: getColorScheme(YaSeApp.of(context)!.widget.AppTheme)),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: YaSeApp.of(context)!.widget.AppTheme.primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {},
              child: Text('Button 1',
                  style: YaSeApp.of(context)!
                      .widget
                      .AppTheme
                      .textTheme
                      .bodyMedium),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Button 2',
                  style: YaSeApp.of(context)!
                      .widget
                      .AppTheme
                      .textTheme
                      .bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
