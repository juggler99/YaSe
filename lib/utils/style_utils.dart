import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'dart:developer';

Color getColorBlue(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.blue;
}

Color getColorRed(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.red;
  }
  return Colors.red;
}

/// Returns a [ButtonStyle] for a TextButton with the given [Theme]
ButtonStyle generateTextButtonStyle(ThemeData theme) {
  return ButtonStyle(
      alignment: Alignment.center,
      foregroundColor:
          MaterialStateProperty.resolveWith((states) => theme.primaryColor),
      overlayColor:
          MaterialStateProperty.resolveWith((states) => theme.primaryColor),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.transparent),
      shadowColor:
          MaterialStateProperty.resolveWith((states) => theme.shadowColor),
      textStyle: MaterialStateProperty.resolveWith(
          (states) => theme.textTheme.subtitle1));
}

/// Returns a [ButtonStyle] with the given [Theme]
ButtonStyle generateButtonStyle(ThemeData theme) {
  return ButtonStyle(
      alignment: Alignment.center,
      foregroundColor:
          MaterialStateProperty.resolveWith((states) => theme.primaryColor),
      overlayColor:
          MaterialStateProperty.resolveWith((states) => theme.primaryColor),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => theme.backgroundColor),
      shadowColor:
          MaterialStateProperty.resolveWith((states) => theme.shadowColor));
}

/// Return a compsoite button coprised of a [Column] conyaineing an [Icon], a [Container] and a label
Column buildButtonColumn(IconData icon, String label, ThemeData themeData) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: themeData.backgroundColor),
      Container(
        // margin: const EdgeInsets.only(top: 8),
        child: Text(label, style: themeData.textTheme.bodyText1),
      ),
    ],
  );
}

/// Returns an [Icon] that can be collapsed
Widget buildCollapsibleIcon(bool isCollapsed) {
  final double size = 52;
  final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
  return Material(
    // color: Colors.transparent,
    child: InkWell(
        child: Container(
      width: size,
      height: size,
      child: Icon(icon),
    )),
  );
}

/// Returns inverse Color of given [Color]
Color getBorderColorBasedOnCanvasColor(
    BuildContext context, Color targetColor) {
  Color inverseColor = Colors.blueGrey;
  if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
    inverseColor = Colors.white;
    if (targetColor == Colors.black ||
        targetColor.red == 0 &&
            targetColor.blue == 0 &&
            targetColor.green == 0) {
      return inverseColor;
    }
  } else {
    if (targetColor == Colors.white ||
        targetColor.red == 255 &&
            targetColor.blue == 255 &&
            targetColor.green == 255) {
      return inverseColor;
    }
  }
  return targetColor;
}

/// Returns a [List] of [Tuple2] containing the name of primary [Color]
List<String> primaryColorNames = [
  'red',
  'pink',
  'purple',
  'deepPurple',
  'indigo',
  'blue',
  'lightBlue',
  'cyan',
  'teal',
  'green',
  'lightGreen',
  'lime',
  'yellow',
  'amber',
  'orange',
  'deepOrange',
  'brown',
  'blueGrey'
];

/// Returns the name of given primary [Color]
String getPrimaryColorName(Color color) {
  for (int i = 0; i < Colors.primaries.length; i++) {
    Color testColor = Colors.primaries[i];
    if (testColor.red == color.red &&
        testColor.green == color.green &&
        testColor.blue == color.blue) {
      return primaryColorNames[i];
    }
  }
  return color.toString();
}

/// Returns the name of given [Color]
String getColorName(Color color) {
  String colorName = getPrimaryColorName(color);
  if (colorName.indexOf('0xff') > -1) {
    var colors = getAllColorsAsListOfTuples();
    for (int i = 0; i < colors.length; i++) {
      Color testColor = colors[i].item2;
      if (testColor.red == color.red &&
          testColor.green == color.green &&
          testColor.blue == color.blue) {
        return colors[i].item1;
      }
    }
  }
  return colorName;
}

/// Returns a [List] of [String] containing the name of shades based on primary [Color]
List<int> getShadeNames() {
  List<int> result = [50];
  int n = 0;
  for (int i = 1; i < 10; i++) {
    n = i * 100;
    result.add(n);
  }
  return result;
}

/// Returns a [List] of [String] containing the name colors that iclude their shades
List<String> getExpandedColorNames() {
  List<String> expandedColorNames = [];
  primaryColorNames.forEach((element) {
    for (var shade in getShadeNames()) {
      expandedColorNames.add(element + '$shade');
    }
  });
  return expandedColorNames;
}

/// Returns a [List] of [Tuple2] containing the Primary and Black and White colors
List<Tuple2<String, Color>> getFullColorsAsListOfTuples() {
  var results =
      getPrimaryColorsAsListOfTuples() + getBlackWhiteColorsAsListOfTuples();
  return results;
}

/// Returns a [List] of [Tuple2] containing Primary colors
List<Tuple2<String, Color>> getPrimaryColorsAsListOfTuples() {
  List<Tuple2<String, Color>> results = [];
  primaryColorNames.forEach((element) {
    results.add(Tuple2<String, Color>(
        element, Colors.primaries[primaryColorNames.indexOf(element)]));
  });
  return results;
}

/// Returns a [List] of [Tuple2] containing Black and White colors
List<Tuple2<String, Color>> getPrimaryColorsPlusBlackAndWhiteAsListOfTuples() {
  List<Tuple2<String, Color>> results = [];
  primaryColorNames.forEach((element) {
    results.add(Tuple2<String, Color>(
        element, Colors.primaries[primaryColorNames.indexOf(element)]));
  });
  results.add(Tuple2<String, Color>('black', Colors.black));
  results.add(Tuple2<String, Color>('white', Colors.white));
  return results;
}

/// Returns a [List] of [Tuple2] containing All Colors
List<Tuple2<String, Color>> getAllColorsAsListOfTuples() {
  List<Tuple2<String, Color>> results = [];
  primaryColorNames.forEach((element) {
    MaterialColor colorPrimary =
        Colors.primaries[primaryColorNames.indexOf(element)];
    results.add(Tuple2<String, Color>(element, colorPrimary));
    getShadeNames().forEach((e) {
      var color = colorPrimary[e];
      results.add(Tuple2<String, Color>(element + '$e', color!));
    });
  });
  return results;
}

/// Returns a [List] of [Tuple2] given the target color
List<Tuple2<String, Color>> getShadesForColorAsListOfTuples(Color targetColor) {
  var bwColor = blackWhiteBaseColors.firstWhere(
      (colorToCheck) => colorToCheck == targetColor,
      orElse: () => Colors.transparent);
  if (bwColor == Colors.transparent) {
    return getShadesForAnyColorAsListOfTuples(targetColor);
  } else {
    return getBlackWhiteShadesForColorAsListOfTuples(targetColor);
  }
}

/// Returns a [List] of [Tuple2] given the target color
List<Tuple2<String, Color>> getShadesForAnyColorAsListOfTuples(
    Color targetColor) {
  MaterialColor targetMaterialColor = Colors.red;
  if (targetColor is! MaterialColor) {
    for (int i = 0; i < Colors.primaries.length; i++) {
      if (Colors.primaries[i].red == targetColor.red &&
          Colors.primaries[i].blue == targetColor.blue &&
          Colors.primaries[i].green == targetColor.green)
        targetMaterialColor = Colors.primaries[i];
      break;
    }
  } else {
    targetMaterialColor = targetColor;
  }
  List<Tuple2<String, Color>> results = [];
  getShadeNames().forEach((e) {
    var color = targetMaterialColor[e];
    results.add(Tuple2<String, Color>(color.toString() + '$e', color!));
  });
  return results;
}

/// Returns a [List] of [Tuple2] that represent Shades of colors
List<Tuple2<String, Color>> getShadeColorsAsListOfTuples() {
  List<Tuple2<String, Color>> results = [];
  primaryColorNames.forEach((element) {
    MaterialColor colorPrimary =
        Colors.primaries[primaryColorNames.indexOf(element)];
    getShadeNames().forEach((e) {
      var color = colorPrimary[e];
      results.add(Tuple2<String, Color>(element + '$e', color!));
    });
  });
  return results;
}

/// Returns a [List] of [Tuple2] that represent Black and White Shades
List<Color> blackWhiteShades = [
  Colors.white,
  Colors.white10,
  Colors.white12,
  Colors.white24,
  Colors.white30,
  Colors.white38,
  Colors.white54,
  Colors.white60,
  Colors.white70,
  Colors.black,
  Colors.black12,
  Colors.black26,
  Colors.black38,
  Colors.black45,
  Colors.black54,
  Colors.black87
];

List<Color> blackWhiteBaseColors = [Colors.black, Colors.white];
List<String> blackWhiteBaseColorNames = ['black', 'white'];
Map<String, List<int>> blackWhiteShadesMap = {
  'white': [10, 12, 24, 30, 38, 54, 60, 70],
  'black': [12, 26, 38, 45, 54, 87]
};
Map<String, List<int>> blackWhiteShadesIndices = {
  'white': [0, 1, 2, 3, 4, 5, 6, 7, 8],
  'black': [9, 10, 11, 12, 13, 14, 15]
};

String getBlackWhiteNameForColor(Color targetColor) {
  int idx = blackWhiteBaseColors.indexOf(targetColor);
  if (idx < 0) return '';
  return blackWhiteBaseColorNames[idx];
}

List<String> getBlackWhiteNames() {
  List<String> blackAndWhite = [];
  blackWhiteShadesMap.entries.forEach((element) {
    var newKey = element.key;
    blackAndWhite.add('$newKey');
    element.value.asMap().entries.forEach((e) {
      var newValue = e.value;
      var newEntry = newKey + '$newValue';
      blackAndWhite.add(newEntry);
    });
  });
  return blackAndWhite;
}

/// Returns a [List] of [Tuple2] that represent Black and White Shades
List<Tuple2<String, Color>> getBlackWhiteShadesForColorAsListOfTuples(
    Color targetColor) {
  String colorName = getBlackWhiteNameForColor(targetColor);
  if (colorName.length == 0) return [];
  List<Tuple2<String, Color>> results = [];
  var blackWhiteNames = getBlackWhiteNames();
  blackWhiteShadesIndices[colorName]!.forEach((element) {
    if (blackWhiteNames[element] != colorName) {
      results.add(Tuple2<String, Color>(
          blackWhiteNames[element], blackWhiteShades[element]));
    }
  });
  return results;
}

/// Returns a [List] of [Tuple2] that represent Black and White Colors
List<Tuple2<String, Color>> getBlackWhiteColorsAsListOfTuples() {
  List<Tuple2<String, Color>> results = [];
  var blackWhiteNames = getBlackWhiteNames();
  blackWhiteNames.forEach((element) {
    results.add(Tuple2<String, Color>(
        element, blackWhiteShades[blackWhiteNames.indexOf(element)]));
  });
  return results;
}

/// Returns a Map<Color, String> that represent Primary Colors
Map<Color, String> getPrimaryColorsAsMapKeyedByColor() {
  Map<Color, String> results = {};
  var colors = getPrimaryColorsAsListOfTuples();
  colors.forEach((e) {
    results[e.item2] = e.item1;
  });
  return results;
}
