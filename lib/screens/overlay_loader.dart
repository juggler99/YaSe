import 'package:flutter/material.dart';

class Loader {
  //  singleton
  static final Loader appLoader = Loader();
  ValueNotifier<bool> loaderShowingNotifier = ValueNotifier(false);
  ValueNotifier<String> loaderTextNotifier = ValueNotifier('error message');

  // using to show from anywhere
  void showLoader() {
    loaderShowingNotifier.value = true;
  }

  // using to hide from anywhere
  void hideLoader() {
    loaderShowingNotifier.value = false;
  }

  //using to change error message from anywhere
  void setText({String errorMessage = ''}) {
    loaderTextNotifier.value = errorMessage;
  }

//<-- DIY
  void setImage() {
    // same as that of setText //
  }
}
