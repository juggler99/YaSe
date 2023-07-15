import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import './../../../utils/color_utils.dart';

class Footer extends StatelessWidget {
  double? height;
  List<Widget>? items;
  Footer({Key? key, List<Widget>? this.items, double this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: YaSeApp.of(context)!.widget.AppTheme.copyWith(
          colorScheme: getColorScheme(YaSeApp.of(context)!.widget.AppTheme)),
      child: Container(
        height: this.height,
        decoration: BoxDecoration(
            color: YaSeApp.of(context)!.widget.AppTheme.primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: this.items!,
        ),
      ),
    );
  }
}
