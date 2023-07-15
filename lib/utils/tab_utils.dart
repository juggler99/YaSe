import 'package:flutter/material.dart';

import '../yase/yase.dart';

var widthCharacterFactor = 8.0;
var widthWordPadding = 20.0;

Widget getTabItem(
    String label, IconData iconData, Function callback, int tabIndex) {
  final labelWidth = getLabelWidth(label);
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
        height: 40,
        width: labelWidth,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                label,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1),
              child: InkWell(
                  onTap: () => callback(tabIndex),
                  child: Icon(
                    iconData,
                    color: const Color(0xffef5145),
                    size: 24,
                  )),
            ),
          ],
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
  Color? colorTab =
      YaSeApp.of(context)!.widget.AppTheme.primaryColor.withOpacity(0.3);
  Color? colorTabBackground =
      YaSeApp.of(context)!.widget.AppTheme.primaryColor.withOpacity(0.1);
  Color? colorTabSelected =
      YaSeApp.of(context)!.widget.AppTheme.primaryColor.withOpacity(0.5);
  print(
      "colorTab: ${colorTab.alpha} colorTabBackground: ${colorTabBackground.alpha} colorTabSelected: ${colorTabSelected.alpha}");
  colorTab = colorTab;
  colorTabBackground = colorTabBackground;
  colorTabSelected = colorTabSelected;
  BorderSide borderSide = BorderSide(color: colorTabSelected);
  BorderSide borderSide0 = BorderSide(color: colorTabSelected, width: 0.0);
  Border border = Border(
      top: borderSide, left: borderSide, right: borderSide, bottom: borderSide);
  return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          width: YaSeApp.of(context)?.widget.YaSeAppWidth,
          padding: EdgeInsets.all(0.0),
          color: colorTabBackground, // set the color in between the tabs
          child: TabBar(
            indicatorPadding: EdgeInsets.symmetric(horizontal: -8.0),
            padding: EdgeInsets.all(0.0),
            isScrollable: true,
            tabs: tabs.map((tab) {
              final labelWidth = getTabLabelWidth(tab);
              return Container(
                height: 32,
                width: labelWidth,
                decoration: BoxDecoration(
                    border: border,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8))),
                child: Center(child: tab),
              );
            }).toList(),
            controller: tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
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
