import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Pongball extends StatelessWidget {
  double width;
  double height;
  Pongball(this.width, this.height, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.yellow,
        shape: BoxShape.circle,
      ),
    );
  }
}
