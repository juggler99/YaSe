import 'package:flutter/material.dart';
import './../../../utils/dropdown_utils.dart';
import './../../../utils/style_utils.dart';
import './../../../utils/dropdownlist.dart';

class ComplexScreen extends StatefulWidget {
  const ComplexScreen({Key? key}) : super(key: key);
  @override
  _ComplexScreenState createState() => _ComplexScreenState();
}

class _ComplexScreenState extends State<ComplexScreen> {
  bool _bigger = true;
  @override
  Stack _panel = new Stack(
    children: <Widget>[
      // Max Size
      Container(color: Colors.green),
      Container(color: Colors.blue, height: 300.0, width: 300.0),
      Container(color: Colors.pink, height: 150.0, width: 150.0)
    ],
  );

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedContainer(
          width: _bigger ? 100 : 500,
          child: Image.asset('assets/icons/star.png'),
          duration: Duration(seconds: 1),
        ),
        ElevatedButton(
          onPressed: () => setState(() {
            _bigger = !_bigger;
          }),
          child: Icon(Icons.star),
        ),
      ],
    );
  }
}
