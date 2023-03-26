import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'document.dart';
import 'package:flutter_gen/utils/file_utils.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocBloc extends Bloc<DocBlocEvent, DocBlocState> {
  DocBloc() : super(DocBlocStateInitial()) {
    on<DocBlocOpenEvent>(_open);
    on<DocBlocCloseEvent>(_close);
    on<DocBlocSaveEvent>(_save);
    on<DocBlocCopyEvent>(_copy);
    on<DocBlocMoveEvent>(_move);
    on<DocBlocCreateEvent>(_create);
    on<DocBlocRenameEvent>(_rename);
    on<DocBlocDirtyEvent>(_dirty);
  }

  void _open(DocBlocOpenEvent event, Emitter<DocBlocState> emit) async {
    print("_open");
    String text = read(event.document.filename!);

    emit(DocBlocStateChange(
        document: event.document,
        isDirty: false,
        now: DateTime.now(),
        text: text));
  }

  void _close(DocBlocCloseEvent event, Emitter<DocBlocState> emit) async {
    print("_close");
    if (event.save) {
      writeAsync(event.document.filename!, event.text!);
    }

    emit(DocBlocStateChange(
        document: event.document,
        isDirty: false,
        now: DateTime.now(),
        text: event.text));
  }

  void _save(DocBlocSaveEvent event, Emitter<DocBlocState> emit) async {
    print("_save");
    write(event.document.filename!, event.text!);
    emit(DocBlocStateChange(
        document: event.document,
        isDirty: false,
        now: DateTime.now(),
        text: event.text));
  }

  void _create(DocBlocCreateEvent event, Emitter<DocBlocState> emit) async {
    print("_create");

    Document newDocument = Document(filename: event.filename);

    emit(DocBlocStateChange(
        document: newDocument, isDirty: false, now: DateTime.now(), text: ""));
  }

  void _move(DocBlocMoveEvent event, Emitter<DocBlocState> emit) {
    print("_move");
    Document newDocument = Document(filename: event.document.filename);
    emit(DocBlocStateChange(
        document: newDocument, isDirty: false, now: DateTime.now(), text: ""));
  }

  void _copy(DocBlocCopyEvent event, Emitter<DocBlocState> emit) async {
    print("_move");
    Document newDocument = Document(filename: event.document.filename);
    String? text = read(event.document.filename!);
    emit(DocBlocStateChange(
        document: newDocument,
        isDirty: false,
        now: DateTime.now(),
        text: text));
  }

  void _rename(DocBlocRenameEvent event, Emitter<DocBlocState> emit) async {
    print("_move");
    Document newDocument = Document(filename: event.document.filename);
    String? text = read(event.document.filename!);
    emit(DocBlocStateChange(
        document: newDocument,
        isDirty: false,
        now: DateTime.now(),
        text: text));
  }

  void _dirty(DocBlocDirtyEvent event, Emitter<DocBlocState> emit) async {
    print("_move");
    String? text = read(event.document.filename!);
    emit(DocBlocStateChange(
        document: event.document,
        isDirty: true,
        now: DateTime.now(),
        text: text));
  }
}
