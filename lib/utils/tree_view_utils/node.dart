import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

class CustomNode<T> extends Node<T> {
  /// The unique string that identifies this object.
  final String key;

  /// The string value that is displayed on the [TreeNode].
  final String label;

  /// An optional icon that is displayed on the [TreeNode].
  final IconData? icon;

  /// An optional color that will be applied to the icon for this node.
  final Color? iconColor;

  /// An optional color that will be applied to the icon when this node
  /// is selected.
  final Color? selectedIconColor;

  /// The open or closed state of the [TreeNode]. Applicable only if the
  /// node is a parent
  final bool expanded;

  /// Generic data model that can be assigned to the [TreeNode]. This makes
  /// it useful to assign and retrieve data associated with the [TreeNode]
  final T? data;

  /// The sub [Node]s of this object.
  late List<Node> children;

  /// Force the node to be a parent so that node can show expander without
  /// having children node.
  final bool parent;

  CustomNode({
    required this.key,
    required this.label,
    //this.children: [],
    this.expanded = false,
    this.parent = false,
    this.icon,
    this.iconColor,
    this.selectedIconColor,
    this.data,
  }) : super(key: key, label: label, icon: icon);
}
