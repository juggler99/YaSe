import 'package:flutter/material.dart';
import 'py_code_text_controller.dart';
import 'package:flutter_gen/utils/python_utils.dart';

class PyCodeControllerToken {
  PyCodeControllerToken() {
    print("PyCodeControllerToken TextController: ${_textController.hashCode}");
    print(
        "PyCodeControllerToken _lineCountTextController: ${_lineCountTextController.hashCode}");
  }

  TextEditingController _lineCountTextController =
      TextEditingController(text: "1");
  TextEditingController _textController = PyCodeTextController(
      getTextStyleMapFromList(getKeywords(), TextStyle(color: Colors.green)));

  void contentUpdaterFunc(String text) {
    print('pycodefieldtext contentUpdaterFunc');
  }

  TextEditingController getTextController() => _textController;
  TextEditingController getLineCountTextController() =>
      _lineCountTextController;

  void dispose() {
    print(
        "disposing PyCodeControllerToken TextController: ${_textController.hashCode}");
    print(
        "disposing PyCodeControllerToken _lineCountTextController: ${_lineCountTextController.hashCode}");
    _textController.dispose();
    _lineCountTextController.dispose();
  }
}
