part of 'screen_size_bloc.dart';

@immutable
abstract class ScreenSizeBlocEvent {
  const ScreenSizeBlocEvent();
}

class ScreenSizeBlocUpdateEvent extends ScreenSizeBlocEvent {
  final String screenName;
  final double visibleHeight;
  const ScreenSizeBlocUpdateEvent(
      {required this.screenName, required this.visibleHeight})
      : assert(screenName != null && visibleHeight != null);
  @override
  List<Object> get props => [screenName, visibleHeight];
}

class ScreenSizeBlocQueryEvent extends ScreenSizeBlocEvent {
  final String screenName;
  const ScreenSizeBlocQueryEvent({required this.screenName})
      : assert(screenName != null);
  @override
  List<Object> get props => [screenName];
}
