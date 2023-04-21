import 'package:flutter/material.dart';
import 'dart:developer';

class CustomFabLoc extends FloatingActionButtonLocation {
  double widthFactor = 0.85;
  double heightFactor = 0.15;
  double heightMax = 0.95;
  double heightMin = 0.15;

  CustomFabLoc(
      {double this.widthFactor = 0.85, double this.heightFactor = 0.15});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
      scaffoldGeometry.scaffoldSize.width * getWidthFactor(),

      ///customize here
      (scaffoldGeometry.scaffoldSize.height - kToolbarHeight) *
          getHeightFactor(),
    );
  }

  double getWidthFactor() => widthFactor;
  void SetWidthFactor(double factor) => widthFactor += factor;

  double getHeightFactor() => heightFactor;
  void SetHeightFactor(double factor) {
    print("heightFactor: $heightFactor factor: $factor");
    if (factor > heightMax) {
      heightFactor = heightMax;
    } else if (factor < heightMin) {
      heightFactor = heightMin;
    } else {
      heightFactor = factor;
    }
    print("heightFactor: $heightFactor");
  }
}
