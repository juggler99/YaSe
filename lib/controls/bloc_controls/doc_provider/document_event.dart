part of 'document_bloc.dart';

@immutable
abstract class DocBlocEvent {
  const DocBlocEvent();
}

class DocBlocDirtyEvent extends DocBlocEvent {
  final Document document;
  bool isDirty;
  DocBlocDirtyEvent({required this.document, this.isDirty = true});
  @override
  List<Object> get props => [isDirty];
}

class DocBlocOpenEvent extends DocBlocEvent {
  final Document document;
  int mode;
  DocBlocOpenEvent({required this.document, this.mode = 0});
  @override
  List<Object> get props => [document, mode];
}

class DocBlocCloseEvent extends DocBlocEvent {
  final Document document;
  bool save;
  String? text;
  DocBlocCloseEvent({required this.document, this.text, this.save = false});

  @override
  List<Object> get props => [document, save];
}

class DocBlocSaveEvent extends DocBlocEvent {
  final Document document;
  String? text;
  DocBlocSaveEvent({required this.document, this.text});
  @override
  List<Object> get props => [document, text!];
}

class DocBlocCreateEvent extends DocBlocEvent {
  final Document document;
  String filename;
  DocBlocCreateEvent({required this.document, required this.filename});
  @override
  List<Object> get props => [document, filename];
}

class DocBlocRenameEvent extends DocBlocEvent {
  final Document document;
  String newFilename;
  DocBlocRenameEvent({required this.document, required this.newFilename});
  @override
  List<Object> get props => [document, newFilename];
}

class DocBlocCopyEvent extends DocBlocEvent {
  final Document document;
  String newFilename;
  DocBlocCopyEvent({required this.document, required this.newFilename});
  @override
  List<Object> get props => [document, newFilename];
}

class DocBlocMoveEvent extends DocBlocEvent {
  final Document document;
  String newFilename;
  DocBlocMoveEvent({required this.document, required this.newFilename});
  @override
  List<Object> get props => [document, newFilename];
}
