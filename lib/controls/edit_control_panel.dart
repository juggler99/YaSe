import 'package:flutter/material.dart';
import './../../utils/dropdownlist.dart';
import './../../utils/button_utils.dart';


class EditorControlPanel extends StatefulWidget {
  String title = 'title';
  CustomDropdown<ThemeData> dropdown = CustomDropdown<ThemeData>();
  bool iconNewEnabled = true;
  bool iconEditEnabled = true;
  bool iconDeleteEnabled = true;
  bool iconDiscardEnabled = true;

  EditorControlPanel(
      {Key? key,
      required this.dropdown,
      this.iconNewEnabled = true,
      this.iconEditEnabled = true,
      this.iconDeleteEnabled = true,
      this.iconDiscardEnabled = true})
      : super(key: key);

  @override
  _EditorControlPanelState createState() => _EditorControlPanelState();
}

class _EditorControlPanelState extends State<EditorControlPanel> {
  /// Create a new name and copy current theme
  void CreateTheme() {
    print('CreateTheme');
  }

  /// Save changes, notify if:
  /// - dirty or not
  /// - save as a new theme (prompt for name, warn if existing)
  void SaveTheme() {
    print('SaveTheme');
  }

  void DiscardThemeChanges() {
    print('DiscardThemeChanges');
  }

  /// Avoid deleting main themes: system, light, dark
  void DeleteTheme() {
    print('DeleteTheme');
  }

  @override
  Widget build(BuildContext context) {
    var themeDropdown = widget.dropdown;
    List<Widget> rowItems = [
      Expanded(
          flex: 6,
          child: SizedBox(width: 200, height: 50, child: themeDropdown))
    ];

    if (widget.iconNewEnabled == true)
      rowItems.add(getIconButton(
          context, Icons.add_circle_outline, 'Add a Theme', CreateTheme, 1));
    if (widget.iconEditEnabled == true)
      rowItems.add(getIconButton(context, Icons.done_outline,
          'Save current changes to Theme', SaveTheme, 1));
    if (widget.iconDeleteEnabled == true)
      rowItems.add(getIconButton(context, Icons.remove_circle_outline,
          'Delete current Theme', DeleteTheme, 1));
    if (widget.iconDiscardEnabled == true)
      rowItems.add(getIconButton(context, Icons.close_outlined,
          'Discard Theme changes', DiscardThemeChanges, 1));

    return SizedBox(
        width: 300,
        height: 50,
        child: Container(
            child: Row(
          children: rowItems,
        )));
  }
}
