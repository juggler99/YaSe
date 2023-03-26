import 'package:flutter/material.dart';
import './overlay_loader.dart';

class OverlayView extends StatelessWidget {
  const OverlayView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //IMP , using ValueListenableBuilder for showing/removing overlay
    return ValueListenableBuilder<bool>(
      valueListenable: Loader.appLoader.loaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }
}
