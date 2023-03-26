import 'package:flutter/material.dart';
import 'bat.dart';
import 'ball.dart';

class GameContainer extends StatefulWidget {
  const GameContainer({Key? key}) : super(key: key);

  @override
  _GameContainerState createState() => _GameContainerState();
}

class _GameContainerState extends State with SingleTickerProviderStateMixin {
  late double width;
  late double height;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;
  late Animation<double> animation;
  late AnimationController controller;
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  double ballSize = 30;
  double increment = 5;

  int score = 0;

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller = AnimationController(
      duration: const Duration(minutes: 10000),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      safeSetState(() {
        (hDir == Direction.right) ? posX += increment : posX -= increment;
        (vDir == Direction.down) ? posY += increment : posY -= increment;
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int selectedValue = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Pong")),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
                child: Text(
              "${score.toString()} Points",
              style: const TextStyle(fontSize: 20),
            )),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          height = constraints.maxHeight;
          width = constraints.maxWidth;
          batWidth = width / 5;
          batHeight = height / 20;
          return Container(
            decoration: const BoxDecoration(
                gradient: RadialGradient(colors: [
                  Colors.green,
                  Colors.black87 /* const Color(0xFF02BB9F)*/
                ]),
                borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10),
                    bottomEnd: Radius.circular(10))),
            child: Stack(
              children: [
                Positioned(
                  child: Pongball(ballSize, ballSize),
                  top: posY,
                  left: posX,
                ),
                Positioned(
                    child: GestureDetector(
                        onHorizontalDragUpdate: (DragUpdateDetails update) =>
                            moveBat(update),
                        child: PongBat(batWidth, batHeight)),
                    bottom: 0,
                    left: batPosition)
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void moveBat(DragUpdateDetails update) {
    safeSetState(() {
      batPosition += update.delta.dx;
    });
  }

  void checkBorders() {
    double diameter = 30;

    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
    }
    if (posX >= width - diameter && hDir == Direction.right) {
      hDir = Direction.left;
    }
    if (posY >= height - diameter - batHeight && vDir == Direction.down) {
      //check if the bat is here, otherwise loose
      if (posX >= (batPosition - diameter) &&
          posX <= (batPosition + batWidth + diameter)) {
        vDir = Direction.up;
        safeSetState(() {
          score++;
        });
      } else {
        controller.stop();
        showMessage(context);
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
    }
  }

  void safeSetState(Function function) {
    if (mounted && controller.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  void showMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over'),
            content: const Text('Would you like to play again?'),
            actions: [
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  setState(() {
                    posX = 0;
                    posY = 0;
                    score = 0;
                  });
                  Navigator.of(context).pop();
                  controller.repeat();
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // dispose();
                },
              )
            ],
          );
        });
  }
}

enum Direction { up, down, left, right }
