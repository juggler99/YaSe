import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  double? height;
  List<Widget>? items;
  Footer({Key? key, List<Widget>? this.items, double this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(backgroundColor: Theme.of(context).primaryColor),
      child: Container(
        height: this.height,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: this.items!,
        ),
      ),
    );
  }
}
