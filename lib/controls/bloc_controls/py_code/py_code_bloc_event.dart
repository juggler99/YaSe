part of 'py_code_bloc.dart';

@immutable
abstract class PyCodeBlocEvent {
  const PyCodeBlocEvent();
}

class PyCodeBlocTextChangeEvent extends PyCodeBlocEvent {
  final String text;
  final int cursorPosition;
  final PyCodeControllerToken pyCodeControllerToken;
  const PyCodeBlocTextChangeEvent(
      this.pyCodeControllerToken, this.text, this.cursorPosition);
  @override
  List<Object> get props => [text, cursorPosition];
}

class PyCodeBlocControlTextChangeEvent extends PyCodeBlocEvent {
  final PyCodeField pyCodeField;
  final TextEditingController lineCountTextController;
  const PyCodeBlocControlTextChangeEvent(
      {required this.pyCodeField, required this.lineCountTextController})
      : assert(pyCodeField != null && lineCountTextController != null);
  @override
  List<Object> get props => [pyCodeField, lineCountTextController];
}
