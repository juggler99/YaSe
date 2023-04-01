part of 'py_code_bloc.dart';

@immutable
abstract class PyCodeBlocEvent {
  const PyCodeBlocEvent();
}

class PyCodeBlocTextChangeEvent extends PyCodeBlocEvent {
  final TextEditingController codeTextController;
  final TextEditingController lineCountTextController;
  final void Function(String) contentUpdaterFunc;
  const PyCodeBlocTextChangeEvent(
      {required this.codeTextController,
      required this.lineCountTextController,
      required this.contentUpdaterFunc})
      : assert(codeTextController != null && lineCountTextController != null);
  @override
  List<Object> get props => [codeTextController, lineCountTextController];
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
