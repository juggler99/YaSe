import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import 'package:tuple/tuple.dart';

typedef OnColorChangeCallback = void Function(Color value, int index);

class CustomDropdownState with ChangeNotifier {
  CustomDropdownState();

  int _index = -1;
  Color _value = Colors.white;
  String _label = '';

  String get getLabel => _label;
  Color get getColor => _value;
  int get getIndex => _index;

  void setValue(int index, Color value, String label) {
    _label = label;
    _value = value;
    _index = index;
    notifyListeners();
  }
}

class CustomDropdown<T> extends StatefulWidget {
  /// the child widget for the button, this will be ignored if text is supplied
  final Widget? child;

  /// onChange is called when the selected option is changed.;
  /// It will pass back the value and the index of the option.
  final void Function(T, int, String, BuildContext)? onChange;

  /// list of DropdownItems
  final List<DropdownItem<T>>? items;
  DropdownStyle dropdownStyle;

  /// dropdownButtonStyles passes styles to OutlineButton.styleFrom()
  DropdownButtonStyle dropdownButtonStyle;
  Color _bgColor = Colors.white;

  /// dropdown button icon defaults to caret
  final Icon? icon;
  final bool hideIcon;

  /// if true the dropdown icon will act as a leading icon, default to false
  final bool leadingIcon;
  CustomDropdown({
    Key? key,
    this.hideIcon = false,
    @required this.child,
    @required this.items,
    this.dropdownStyle = const DropdownStyle(),
    this.dropdownButtonStyle = const DropdownButtonStyle(),
    this.icon,
    this.leadingIcon = false,
    this.onChange,
  }) : super(key: key);

  _CustomDropdownState<T>? _state;
  @override
  _CustomDropdownState<T> createState() {
    _state = _CustomDropdownState<T>();
    return _state!;
  }

  final _customDropdownKey = GlobalKey<_CustomDropdownState<T>>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  AnimationController? _animationController;
  Animation<double>? _expandAnimation;
  Animation<double>? _rotateAnimation;
  Color? _bgColor;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _animationController as Animation<double>,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    //debugger();
    // var stateProvider = Provider.of<CustomDropdownState>(context);
    var style = widget.dropdownButtonStyle;
    // link the overlay to the button
    return CompositedTransformTarget(
      link: this._layerLink,
      child: Container(
        width: style.width,
        height: style.height,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: style.padding,
            //backgroundColor: Colors.white,
            backgroundColor: style.backgroundColor,
            elevation: style.elevation,
            primary: style.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: _toggleDropdown,
          child: Row(
            mainAxisAlignment:
                style.mainAxisAlignment ?? MainAxisAlignment.center,
            textDirection:
                widget.leadingIcon ? TextDirection.rtl : TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_currentIndex == -1) ...[
                widget.child!,
              ] else ...[
                widget.items![_currentIndex],
              ],
              if (!widget.hideIcon)
                RotationTransition(
                  turns: _rotateAnimation!,
                  child: widget.icon ?? Icon(Icons.arrow_drop_down),
                ),
            ],
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    // find the size and position of the current widget
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;
    print('offset: $offset size: $size topOffset: $topOffset');
    return OverlayEntry(
      // full screen GestureDetector to register when a
      // user has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        // full screen container to register taps anywhere and close drop down
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset > 300 ? topOffset - 300 : topOffset,
                width: widget.dropdownStyle.width ?? size.width,
                child: CompositedTransformFollower(
                  offset:
                      // handle position in here for menus where location is too
                      //low for a full menu
                      widget.dropdownStyle.offset ?? Offset(0, size.height - 5),
                  link: this._layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: widget.dropdownStyle.elevation ?? 0,
                    borderRadius:
                        widget.dropdownStyle.borderRadius ?? BorderRadius.zero,
                    color: widget.dropdownStyle.color,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation!,
                      child: ConstrainedBox(
                        constraints: widget.dropdownStyle.constraints ??
                            BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height -
                                  topOffset -
                                  15,
                            ),
                        child: ListView(
                          padding:
                              widget.dropdownStyle.padding ?? EdgeInsets.zero,
                          shrinkWrap: true,
                          children: widget.items!.asMap().entries.map((item) {
                            return InkWell(
                              onTap: () {
                                setState(() => _currentIndex = item.key);
                                String selectedText =
                                    widget.items![item.key].label!;
                                print(
                                    'offset: $offset size: $size topOffset: $topOffset selected: $selectedText');
                                widget.onChange!(item.value.value!, item.key,
                                    selectedText, context);
                                _toggleDropdown();
                              },
                              child: item.value,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController!.reverse();
      this._overlayEntry!.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context)!.insert(this._overlayEntry!);
      setState(() => _isOpen = true);
      _animationController!.forward();
    }
  }
}

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.
class DropdownItem<T> extends StatelessWidget {
  //const DropdownItem({ Key? key }) : super(key: key);
  final T? value;
  final Widget? child;
  final String? label;

  const DropdownItem({Key? key, this.value, this.child, this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child!;
  }
}

List<DropdownItem<T>> getDropdownItems<T>(List<Tuple2<String, T>> items) {
  List<DropdownItem<T>> results = [];
  for (var i in items) {
    results.add(DropdownItem<T>(
        value: i.item2,
        label: i.item1,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(child: Text(i.item1, style: TextStyle(fontSize: 18))),
        )));
  }
  return results;
}

class DropdownButtonStyle {
  final MainAxisAlignment? mainAxisAlignment;
  final ShapeBorder? shape;
  final double? elevation;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color? primaryColor;
  const DropdownButtonStyle({
    this.mainAxisAlignment,
    this.backgroundColor,
    this.primaryColor,
    this.constraints,
    this.height,
    this.width,
    this.elevation,
    this.padding,
    this.shape,
  });
}

class DropdownStyle {
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  /// position of the top left of the dropdown relative to the top left of the button
  final Offset? offset;

  ///button width must be set for this to take effect
  final double? width;

  const DropdownStyle({
    this.constraints,
    this.offset,
    this.width,
    this.elevation,
    this.color,
    this.padding,
    this.borderRadius,
  });
}
