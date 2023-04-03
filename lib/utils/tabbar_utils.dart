import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

/// Returns a [TabBar] with the given widgets [items]
TabBar createTabBarFromListOfTuples(List<Tuple3<String, Icon?, Widget>> items) {
  var tabs = <Tab>[];
  Tab tab;
  for (int i = 0; i < items.length; i++) {
    if (items[i].item2 != null) {
      tab = Tab(text: items[i].item1, icon: items[i].item2);
    } else {
      tab = Tab(text: items[i].item1);
    }
    tabs.add(tab);
  }
  return TabBar(tabs: tabs);
}

/// Returns a [TabBar] with the given string [items]
TabBar createTabBarFromListOfText(List<String> items) {
  var tabs = <Tab>[];
  Tab? tab;
  for (int i = 0; i < items.length; i++) {
    tab = Tab(text: items[i]);
    tabs.add(tab);
  }
  return TabBar(tabs: tabs);
}
