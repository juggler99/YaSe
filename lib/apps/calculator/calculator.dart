import 'package:flutter/material.dart';
import 'calculator_result_display.dart';
import './../../utils/button_utils.dart';
import 'dart:developer';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  operatorPressed(String operator) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = 0;
      }
      this.operator = operator;
    });
  }

  numberPressed(String strNumber) {
    int number = int.parse(strNumber);
    print('numberPressed: $number');
    setState(() {
      if (result != null) {
        result = null;
        firstOperand = number;
        return;
      }
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }
      secondOperand = int.parse('$secondOperand$number');
    });
  }

  calculateResult() {
    if (operator == null || secondOperand == null) {
      return;
    }
    setState(() {
      switch (operator) {
        case '+':
          result = firstOperand! + secondOperand!;
          break;
        case '-':
          result = firstOperand! - secondOperand!;
          break;
        case '*':
          result = firstOperand! * secondOperand!;
          break;
        case '/':
          if (secondOperand == 0) {
            return;
          }
          result = firstOperand! ~/ secondOperand!;
          break;
      }
      firstOperand = result;
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  clear() {
    setState(() {
      result = null;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  List<List<String>> buttonLabels = [
    ['1', '2', '3', '*'],
    ['4', '5', '6', '/'],
    ['7', '8', '9', '+'],
    ['=', '0', 'C', '-'],
  ];
  List<String> operators = ['*', '/', '+', '-'];

  int? firstOperand;
  String? operator;
  int? secondOperand;
  int? result;

  String _getDisplayText() {
    if (result != null) {
      return '$result';
    }
    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }
    if (operator != null) {
      return '$firstOperand$operator';
    }
    if (firstOperand != null) {
      return '$firstOperand';
    }
    return '0';
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [
      CalculatorResultDisplay(
        text: _getDisplayText(),
      ),
    ];
    int rowIndex = 0;
    Row row = Row(
      children: [],
    );
    for (int i = 0; i < buttonLabels.length; i++) {
      var row = Row(children: []);
      for (int j = 0; j < buttonLabels[i].length; j++) {
        var func = () => operatorPressed(buttonLabels[i][j]);
        Color bgColor = Colors.grey;
        if (!operators.contains(buttonLabels[i][j])) {
          if (buttonLabels[i][j] == 'C') {
            func = () => clear();
            bgColor = Colors.grey;
          } else if (buttonLabels[i][j] == '=') {
            func = () => calculateResult();
            bgColor = Colors.orange;
          } else {
            func = () => numberPressed(buttonLabels[i][j]);
            bgColor = Colors.grey.shade200;
          }
        }
        var button = getTextButton(context, buttonLabels[i][j], func, 90,
            radius: 15, backgroundColor: bgColor);
        row.children.add(button);
      }
      rows.add(row);
    }
    return Container(color: Colors.white, child: Column(children: rows));
  }
}
