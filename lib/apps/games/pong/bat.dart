import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PongBat extends StatelessWidget {
  double width;
  double height;
  PongBat(this.width, this.height, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(color: Colors.lightGreen),
    );
  }
}
