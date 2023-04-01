import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './../../bloc_controls/screen_size_provider/screen_size_bloc.dart';
import './py_code_bloc.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_gen/utils/python_utils.dart';
import 'package:flutter_gen/utils/string_utils.dart';
import 'py_code_text_controller.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class PyCodeField extends StatefulWidget {
  TextEditingController? lineCountTextController;
  TextEditingController _textController = PyCodeTextController(
      getTextStyleMapFromList(getKeywords(), TextStyle(color: Colors.green)));
  Function? updateLineTextController;
  void Function(String) contentUpdaterFunc;

  PyCodeField(
      {Key? key,
      TextEditingController? this.lineCountTextController,
      Function? this.updateLineTextController,
      required this.contentUpdaterFunc})
      : super(key: key);

  @override
  _PyCodeFieldState createState() => _PyCodeFieldState();

  TextEditingController getTextController() => _textController;
}

class _PyCodeFieldState extends State<PyCodeField> {
  final focusNode = FocusNode();
  final layerLink = LayerLink();
  double visibleheight = 0;

  OverlayEntry? _entry;
  List<Widget> _items = [];

  TextStyle _textStyle = TextStyle(
    //backgroundColor: Colors.amber,
    color: Colors.grey,
    decorationThickness: 0.001,
  );

  @override
  void initState() {
    super.initState();
    //widget._textController =
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => displayOverlay(_items, widget._textController, _textStyle));
    focusNode.addListener(() {});
    widget._textController.addListener(getAutocomplete);
    widget._textController.addListener(updateLineNumberTextController);
  }

  @override
  void dispose() {
    widget.getTextController().dispose();
    super.dispose();
  }

  void addTextControllerCustomListener(customListener) {
    widget._textController.addListener(() {
      customListener(widget._textController);
    });
  }

  var regex = RegExp('[^a-zA-Z0-9]');

  void updateLineNumberTextController() {
    print('pycodefieldtext updateLineNumberTextController');
    if (widget.updateLineTextController != null)
      widget.updateLineTextController!();
  }

  void getAutocomplete([bool verbose = true]) {
    if (verbose) print("getAutocomplete");
    double visibleHeight = MediaQuery.of(context).size.height +
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    var screenSizeBlocReader = context.read<ScreenSizeBloc>().add(
        ScreenSizeBlocUpdateEvent(
            screenName: "pyCodeEditor", visibleHeight: visibleHeight));
    print("autocomplete visibleHeight: $visibleheight");

    List<String> words = widget._textController.text
        .replaceAll(regex, ' ')
        .split(regex)
        .toSet()
        .toList();
    int cursorPosition = widget._textController.selection.baseOffset;
    Tuple2<String, int> curWordTuple =
        getWordAtPosition(widget._textController.text, cursorPosition);
    // current Word
    var curWord = curWordTuple.item1;
    // position of current word in controller text
    var curWordPosition = curWordTuple.item2;
    if (verbose) print('curr Word: $curWordTuple');
    if (verbose) print('words: $words');
    if (curWord == " " || curWord == "") {
      closeOverlay(widget._textController, cursorPosition);
      print('return 1 currPosition: $cursorPosition');
      return;
    }
    List<String> keywords = getMatchingKeywords(curWord);
    words.removeWhere((item) => keywords.indexOf(item) > -1);

    if (verbose) print('words: $words');

    // case: single keyword match
    if (keywords.length == 1) {
      if (keywords[0] == curWord) {
        // last word already matches single keyword
        // hide overlay, nothing more to do
        if (verbose) print('last word already in');
        closeOverlay(widget._textController, cursorPosition);
        print('return 2 currPosition: $cursorPosition');
        return;
      }
      //type ahead does not work for a single characer because the user will
      //never be abe to type a different word as the algo would not let them
    }
    // case when 1st matching keyword already matches last word
    // nothing to do, hide overlay
    if (keywords.length > 0 && keywords[0] == curWord) {
      if (verbose) print('word already in');
      closeOverlay(widget._textController, cursorPosition);
      print('return 3 currPosition: $cursorPosition');
      return;
    }

    if (verbose) print("words after removing curWord: $words");
    var allWords = keywords + words;
    if (verbose) print("allWords before: $allWords");
    allWords.removeWhere((word) =>
        word.length < curWord.length ||
        word.substring(0, curWord.length) != curWord ||
        word == curWord);
    if (verbose) print("allWords after: $allWords");
    if (allWords.isEmpty || curWord.isEmpty) {
      closeOverlay(widget._textController, cursorPosition);
      print('return 4 currPosition: $cursorPosition');
      return;
    }

    List<ListTile> items = [];
    items.addAll(allWords
        .where((keyword) => keyword.isNotEmpty)
        .map((keyword) => ListTile(
              title: Text(keyword),
              onTap: () {
                var txt = widget._textController.text;
                print("text beforfe: $txt");
                var result = getTextBeforeAfterCurWord(
                    widget._textController.text,
                    curWord,
                    keyword,
                    curWordPosition);
                widget._textController.text =
                    result.item1 + keyword + result.item2;
                print("reslt: $result");
                closeOverlay(widget._textController, result.item3);
              },
            )));
    if (items.isNotEmpty) {
      items.sort((a, b) => a.title.toString().compareTo(b.title.toString()));
      displayOverlay(items, widget._textController, _textStyle);
    }
  }

  void closeOverlay(TextEditingController controller, int cursorPosition) {
    hideOverlay();
    if (cursorPosition < 0) cursorPosition = controller.text.length;
    controller.selection =
        TextSelection.fromPosition(TextPosition(offset: cursorPosition));
  }

  @override
  Widget build(BuildContext context) {
    visibleheight = MediaQuery.of(context).size.height +
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    print("visibleHeight: $visibleheight");

    return CompositedTransformTarget(
        link: layerLink,
        child: TextField(
          focusNode: focusNode,
          controller: widget._textController,
          maxLines: null,
          autofocus: true,
          enableSuggestions: false,
          style: _textStyle,
          cursorColor: Colors.red,
          autocorrect: false,
          enableInteractiveSelection: true,
          onChanged: (String value) async {
            var evt = PyCodeBlocTextChangeEvent(
                codeTextController: widget.getTextController(),
                lineCountTextController: widget.lineCountTextController!,
                contentUpdaterFunc: widget.contentUpdaterFunc);
            BlocProvider.of<PyCodeBloc>(context).add(evt);
            getAutocomplete();
          },
          decoration: InputDecoration(
              fillColor: Colors.red,
              border: InputBorder.none,
              constraints: BoxConstraints(maxWidth: 200)),
          onSubmitted: (value) {
            print('onSubmited: $value');
          },
        ));
  }

  void displayOverlay(List<Widget> items, TextEditingController controller,
      TextStyle _textStyle) {
    if (items.isEmpty) return;
    hideOverlay();
    final _overlay = Overlay.of(context);
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox!.size;
    var cursorPosition = widget._textController.selection.baseOffset;
    var lines = widget._textController.text
        .substring(0, cursorPosition)
        .split('\n')
        .length;
    print("cursorPosition: $cursorPosition, lines: $lines");
    double? fontSize = _textStyle.fontSize;
    if (fontSize == null) fontSize = 22.0;
    if (items.length > 0) {
      var calcHeight = (items.length) * (fontSize + 36.0);
      print('height: $calcHeight');
      var calcOffset = (lines + 1) * fontSize;
      print('calcOffset: $calcOffset');
      var visibleHeight = MediaQuery.of(context).size.height;
      print('visibleHeight: $visibleHeight');
      //var calcBottom = MediaQuery.of(context).viewInsets.bottom;
      var calcBottom = 0.0;
      print('calcBottom: $calcBottom');
      var total = calcHeight + calcOffset;
      print('total: $total');
      this._entry = OverlayEntry(
        builder: (context) => Positioned(
          bottom: calcBottom,
          height: calcHeight,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            child: createOverlay(items),
            offset: Offset(100, 0),
          ),
          width: size.width,
        ),
      );

      _overlay!.insert(this._entry!);
    } else {
      hideOverlay();
    }
  }

  void hideOverlay() {
    this._entry?.remove();
    this._entry = null;
  }

  Widget createOverlay(List<Widget> items) =>
      Material(elevation: 8, child: Column(children: items));
}
