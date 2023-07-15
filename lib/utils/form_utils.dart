import 'package:flutter/material.dart';

Form createForm(
    BuildContext context, GlobalKey globalKey, List<Widget> children) {
  var rowItems = <Widget>[];
  children.forEach((element) => rowItems.add(Row(children: <Widget>[element])));

  return Form(
    key: globalKey,
    child: Column(children: rowItems),
  );
}
