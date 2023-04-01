import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import './py_code_field.dart';
import 'dart:developer';

part 'py_code_bloc_event.dart';
part 'py_code_bloc_state.dart';

class PyCodeBloc extends Bloc<PyCodeBlocEvent, PyCodeBlocState> {
  PyCodeBloc() : super(PyCodeBlocStateInitial()) {
    on<PyCodeBlocTextChangeEvent>(_addLine);
  }

  void _addLine(
      PyCodeBlocTextChangeEvent event, Emitter<PyCodeBlocState> emit) {
    event.contentUpdaterFunc(event.codeTextController.text);
    var codeLines = event.codeTextController.text.split('\n');
    var numLines = event.lineCountTextController.text.split('\n');
    var CodeLinesLen = codeLines.length;
    var numLinesLen = numLines.length;
    if (numLines.length < codeLines.length) {
      print(
          "_addLine: codeLines: $codeLines - $CodeLinesLen numLines: $numLines numLines.len: $numLinesLen");

      for (int i = numLines.length; i < codeLines.length; i++) {
        var newLine = i + 1;
        print("newLine: $newLine");
        event.lineCountTextController.text += '\n$newLine';
      }
    }
    emit(PyCodeBlocStateChange(dirty: false));
  }
}
