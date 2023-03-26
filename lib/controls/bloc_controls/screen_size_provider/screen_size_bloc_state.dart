// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'screen_size_bloc.dart';

@immutable
class ScreenSizeBlocState extends Equatable {
  // The idea is to keep track of visibility of onscreen keyboard
  // tried a few methods, very convoluted and didnlt work
  // will try to identify a few key screens and update this object as a global
  // provider of sizes. On different devices, the screen size will be different
  // but these screens should be teh same when showing on-screen keyboard or not
  final Map<String, double> screenSizes = Map<String, double>();
  @override
  List<Object> get props => [screenSizes];
}

class ScreenSizeBlocStateInitial extends ScreenSizeBlocState {
  ScreenSizeBlocStateInitial() : super() {
    ;
  }

  @override
  List<Object> get props => [screenSizes];
}

class ScreenSizeBlocStateChange extends ScreenSizeBlocState {
  ScreenSizeBlocStateChange(String screenName, double visibleHeight) : super() {
    this.screenSizes[screenName] = visibleHeight;
  }

  @override
  List<Object> get props => [screenSizes];
}
