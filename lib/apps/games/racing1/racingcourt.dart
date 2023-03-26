import 'package:flutter/material.dart';

class RacingCourt extends StatelessWidget {
  const RacingCourt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gameland'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/pong');
          },
          child: const Text('Pong'),
        ),
      ),
    );
  }
}
