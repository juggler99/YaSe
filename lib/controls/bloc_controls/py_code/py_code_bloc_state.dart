// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'py_code_bloc.dart';

@immutable
class PyCodeBlocState extends Equatable {
  TextEditingController? codeTextController;
  TextEditingController? lineCountTextController;
  bool dirty = false;
  @override
  List<Object> get props => [dirty];

  // The idea is to keep track of visibility of onscreen keyboard
  // tried a few methods, very convoluted and didnlt work
  // will try to identify a few key screens and update this object as a global
  // provider of sizes. On different devices, the screen size will be different
  // but these screens should be teh same when showing on-screen keyboard or not
  var screenSizes = Map<String, int>();
}

class PyCodeBlocStateInitial extends PyCodeBlocState {
  TextEditingController? codeTextController;
  TextEditingController? lineCountTextController;
  bool dirty = false;
  PyCodeBlocStateInitial() {
    codeTextController = TextEditingController(text: 'Hello');
    lineCountTextController = TextEditingController(text: '1');
  }
  @override
  List<Object> get props =>
      [codeTextController!, lineCountTextController!, dirty];
}

class PyCodeBlocStateChange extends PyCodeBlocState {
  TextEditingController? codeTextController;
  TextEditingController? lineCountTextController;
  bool dirty = false;
  PyCodeBlocStateChange(
      {this.codeTextController,
      this.lineCountTextController,
      this.dirty: true});

  @override
  List<Object> get props => [dirty];
}
