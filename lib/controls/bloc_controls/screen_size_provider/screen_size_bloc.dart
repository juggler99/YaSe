import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'screen_size_bloc_event.dart';
part 'screen_size_bloc_state.dart';

class ScreenSizeBloc extends Bloc<ScreenSizeBlocEvent, ScreenSizeBlocState> {
  ScreenSizeBloc() : super(ScreenSizeBlocStateInitial()) {
    on<ScreenSizeBlocUpdateEvent>(updateMapForScreen);
    on<ScreenSizeBlocQueryEvent>(query);
  }

  void updateMapForScreen(
      ScreenSizeBlocUpdateEvent event, Emitter<ScreenSizeBlocState> emit) {
    emit(ScreenSizeBlocStateChange(event.screenName, event.visibleHeight));
  }

  void query(
      ScreenSizeBlocQueryEvent event, Emitter<ScreenSizeBlocState> emit) {
    emit(ScreenSizeBlocStateInitial());
  }
}
