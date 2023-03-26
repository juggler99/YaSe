// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'document_bloc.dart';

@immutable
class DocBlocState extends Equatable {
  Document? document;
  bool dirty = false;
  @override
  List<Object> get props => [document!, dirty];

  // The idea is to keep track of visibility of onscreen keyboard
  // tried a few methods, very convoluted and didnlt work
  // will try to identify a few key screens and update this object as a global
  // provider of sizes. On different devices, the screen size will be different
  // but these screens should be teh same when showing on-screen keyboard or not
  var screenSizes = Map<String, int>();
}

class DocBlocStateInitial extends DocBlocState {
  Document? document;
  bool isDirty = false;
  DocBlocStateInitial() {}
  @override
  List<Object> get props => [document!, isDirty];
}

class DocBlocStateChange extends DocBlocState {
  Document? document;
  bool isDirty;
  String? text;
  DateTime now;
  Status? status;
  DocBlocStateChange(
      {required this.document,
      required this.now,
      this.text,
      this.status,
      this.isDirty = true});

  @override
  List<Object> get props => [document!, dirty, text!, now];
}
