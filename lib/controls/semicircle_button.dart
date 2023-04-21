import 'package:flutter/material.dart';
import 'dart:math' as math;

class SemiCircle extends StatelessWidget {
  final double diameter;
  final Color color;
  final bool inverted;
  final Icon icon;
  final String label;

  const SemiCircle({
    Key? key,
    this.diameter = 200,
    this.color = Colors.blue,
    this.inverted = false,
    this.icon = const Icon(Icons.add),
    this.label = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SemiCirclePainter(),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class SemiCirclePainter extends CustomPainter {
  final Color color;
  final bool inverted;

  const SemiCirclePainter({this.color = Colors.blue, this.inverted = false});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = this.color;
    int factor = this.inverted ? -1 : 1;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height * factor / 2, size.width / 2),
        height: size.height * factor,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(SemiCirclePainter oldDelegate) => false;
}
