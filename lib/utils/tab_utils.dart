import 'package:flutter/material.dart';

import '../yase/yase.dart';

var widthCharacterFactor = 8.0;
var widthWordPadding = 20.0;
typedef VoidCallbackWithIntArg = void Function(int);

VoidCallbackWithIntArg? getDefaultFunction() {
  return (int tabIndex) {
    print('${tabIndex}');
  };
}

Widget getTabItem(BuildContext context, String label, int tabIndex,
    {IconData iconData = Icons.adb,
    Function? callback = null,
    double iconSize = 24.0,
    Color iconColor = Colors.black}) {
  final labelWidth = getLabelWidth(label);
  var iconColor = YaSeApp.of(context)!.widget.AppTheme.colorScheme.onSurface;
  if (callback == null) {
    callback = (int tabIndex) {
      print('${tabIndex}');
    };
  }
  var children = <Widget>[
    Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        label,
      ),
    )
  ];
  if (iconData != Icons.adb) {
    children.add(Padding(
      padding: const EdgeInsets.only(left: 1),
      child: InkWell(
          onTap: () => callback!(tabIndex),
          child: Icon(
            iconData,
            color: iconColor,
            size: iconSize,
          )),
    ));
  }

  return Tab(
      child: Container(
    constraints: BoxConstraints(
      maxWidth: 500, // Set the maximum width of the row
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      //color: isSelected ? Colors.blue : Colors.white,
    ),
    child: Center(
      child: SizedBox(
        height: 50,
        width: labelWidth,
        child: Row(
          children: children,
        ),
      ),
    ),
  ));
}

double getLabelWidth(String label) {
  var newLen = (label.length * widthCharacterFactor) + widthWordPadding;
  print(
      "getLabelWidth: $label length: ${label.length} newlen: $newLen widthCharacterFactor: $widthCharacterFactor  widthWordPadding: $widthWordPadding");
  return newLen;
}

double getTabLabelWidth(Tab tab) {
  if (tab.text != null) {
    return getLabelWidth(tab.text!);
  }
  if (tab.child is Container) {
    final container = tab.child as Container;
    if (container.child is SizedBox) {
      final sizedBox = container.child as SizedBox;
      return sizedBox.width!;
    } else if (container.child is Center) {
      final center = container.child as Center;
      if (center.child is SizedBox) {
        final child = center.child as SizedBox;
        return child.width!;
      }
    }
  }
  // return a default value
  return 80.0;
}

Align createTabBar(
    BuildContext context, List<Tab> tabs, TabController tabController) {
  var colorbg =
      YaSeApp.of(context)!.widget.AppTheme.colorScheme.surface.withOpacity(0.3);
  Color? colorTab =
      YaSeApp.of(context)!.widget.AppTheme.colorScheme.error.withOpacity(0.5);
  Color? colorTabBackground = colorbg;
  Color? colorTabSelected = YaSeApp.of(context)!
      .widget
      .AppTheme
      .colorScheme
      .background
      .withOpacity(1);
  Color? borderColor = YaSeApp.of(context)!
      .widget
      .AppTheme
      .colorScheme
      .background
      .withOpacity(1);
  print(
      "colorTab: ${colorTab.alpha} colorTabBackground: ${colorTabBackground.alpha} colorTabSelected: ${colorTabSelected.alpha}");
  colorTab = colorTab;
  colorTabBackground = colorTabBackground;
  colorTabSelected = colorTabSelected;
  BorderSide borderSide = BorderSide(color: borderColor);
  BorderSide borderSide0 = BorderSide(color: borderColor, width: 0.0);
  double radius = 10;
  Border border = Border(
      top: borderSide, left: borderSide, right: borderSide, bottom: borderSide);
  return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          width: YaSeApp.of(context)?.widget.YaSeAppWidth,
          padding: EdgeInsets.all(0.0),
          color: colorTabBackground, // set the color in between the tabs
          child: TabBar(
            indicatorPadding: EdgeInsets.symmetric(horizontal: 0.0),
            padding: EdgeInsets.all(0.0),
            isScrollable: true,
            tabs: tabs.map((tab) {
              final labelWidth = getTabLabelWidth(tab);
              return Container(
                height: 28,
                width: labelWidth,
                decoration: BoxDecoration(
                    border: border,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(radius))),
                child: Center(child: tab),
              );
            }).toList(),
            controller: tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
              color: colorTabSelected, // set the color of the indicator
            ),
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.zero,
            onTap: (index) {
              print("on Tap: $index");
            },
          )));
}

TabBarView createTabView(List<Widget> children, TabController tabController) {
  print("createTabView");
  return TabBarView(
    children: children,
    controller: tabController,
  );
}
