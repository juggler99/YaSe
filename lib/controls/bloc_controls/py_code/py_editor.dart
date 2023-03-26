import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controls/bloc_controls/doc_provider/document.dart';
import 'package:flutter_application_1/controls/bloc_controls/doc_provider/document_bloc.dart';
import '../../../controls/bloc_controls/screen_size_provider/screen_size_bloc.dart';
import 'package:flutter_gen/utils/button_utils.dart';
import 'package:flutter_gen/utils/dlg_utils.dart';
import 'package:flutter_gen/utils/file_utils.dart';
import 'package:flutter_gen/controls/header.dart';
import './py_code_bloc.dart';
import './py_code_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controls/edit_control_panel.dart';
import '../../../controls/edit_control_panel_custom.dart';
import 'package:flutter_gen/utils/dropdown_utils.dart';
import 'package:flutter_gen/utils/theme_utils.dart';
import 'package:flutter_gen/utils/python_utils.dart';
import 'package:tuple/tuple.dart';
import '../../../controls/dropdown_item_theme_color_panel.dart';
import 'package:flutter_gen/utils/style_utils.dart';
import '../../../yase/yase.dart';
import './py_code_bloc.dart';
import 'package:flutter_gen/utils/tabbar_utils.dart';
import 'dart:developer';

class PyEditor extends StatefulWidget {
  String? filename;
  String contents = "";
  PyEditor({Key? key}) : super(key: key);
  @override
  _PyEditorState createState() => _PyEditorState();
}

class _PyEditorState extends State<PyEditor> with TickerProviderStateMixin {
  TabController? tabController;
  var _lineNumberTextController = TextEditingController(text: "1");
  var _blocProvider = PyCodeBloc();
  TextStyle _textStyle = TextStyle(
    backgroundColor: Colors.amber,
    color: Colors.grey,
    decorationThickness: 0.001,
  );
  var _screenSizeProvider = ScreenSizeBloc();
  PyCodeField? _pyCodeTextField;
  OverlayEntry? _overlayEntry;
  OverlayState? _overlayState;
  double screenSize = 100;
  double screenRatio = 1;
  Color bgColor = Colors.blue;
  Widget? _lineNumberContainer;
  Widget? _pyCodeFieldContainer;
  ButtonBar? _customButtonBar;

  @override
  void initState() {
    print("PyEditor initstate");
    super.initState();

    TextField LineNumberTextField = TextField(
      controller: _lineNumberTextController,
      maxLines: null,
      autofocus: false,
      autocorrect: false,
      readOnly: true,
      enableInteractiveSelection: false,
      scribbleEnabled: false,
      autofillHints: null,
      decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.amber,
          constraints: BoxConstraints(maxWidth: 20)),
    );

    double containerHeight = 800;

    _lineNumberContainer = Container(
        decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.blue, width: 1.5))),
        child: LineNumberTextField,
        width: 45,
        height: containerHeight);

    _pyCodeTextField = PyCodeField(
        lineCountTextController: _lineNumberTextController,
        updateLineTextController: updateLineNumberTextController);

    var PyCodeFieldWidget =
        CompositedTransformTarget(link: _layerLink, child: _pyCodeTextField);

    _pyCodeFieldContainer =
        Container(height: containerHeight, child: PyCodeFieldWidget);

    _customButtonBar = createTextButtonBarFromListOfText([
      '=>~\t',
      ':',
      '=',
      '!',
      '"',
      '\'',
      '{',
      '}',
      '[',
      ']',
      '(',
      ')',
      '<',
      '>'
    ], _pyCodeTextField!.getTextController());
  }

  void syncLines() {}

  final LayerLink _layerLink = LayerLink();

  @override
  void dispose() {
    if (_overlayEntry != null) {
      _overlayEntry!.dispose();
    }
    super.dispose();
  }

  void onChangeColor(
      Color value, int index, String label, BuildContext context) {
    debugger();
    print('onChangeColor $index');
    setState(() {
      //bgColor = value;
    });
  }

  void onChangeTheme(ThemeData value, int index, String label) {
    print('onChangeTheme $index');
    setState(() {
      //bgColor = value;
    });
  }

  void updateLineNumberTextController() {
    print('updateLineNumberTextController');
    var read = context.read<PyCodeBloc>();
    read.add(PyCodeBlocTextChangeEvent(
        codeTextController: _pyCodeTextField!.getTextController(),
        lineCountTextController: _lineNumberTextController));
  }

  @override
  Widget build(BuildContext context) {
    print("PyEditor build");
    return BlocConsumer<PyCodeBloc, PyCodeBlocState>(
        bloc: BlocProvider.of<PyCodeBloc>(context),
        listener: (context, PyCodeBlocState state) {
          if (state.dirty) {
            print('listener dirty: $state.dirty');
            var evt = PyCodeBlocTextChangeEvent(
                codeTextController: _pyCodeTextField!.getTextController(),
                lineCountTextController: _lineNumberTextController);
            BlocProvider.of<PyCodeBloc>(context).add(evt);
          }
        },
        builder: (context, PyCodeBlocState state) {
          final isCollapsed = false;
          Color color = Theme.of(context).primaryColor;
          screenSize = MediaQuery.of(context).size.width;

          Row row = Row(
            children: [],
          );

          row.children.add(_lineNumberContainer!);
          row.children.add(_pyCodeFieldContainer!);

          return Container(
            color: Theme.of(context).primaryColor,
            child: Stack(
              children: <Widget>[
                Scaffold(
                  resizeToAvoidBottomInset: true,
                  extendBody: true,
                  body: SingleChildScrollView(child: Stack(children: [row])),
                  //bottomNavigationBar: _customButtonBar,
                  bottomSheet: _customButtonBar,
                ),
              ],
            ),
          );
        });
  }
}
