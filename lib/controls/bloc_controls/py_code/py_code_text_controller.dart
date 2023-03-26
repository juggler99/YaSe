import 'package:flutter/material.dart';
import 'package:flutter_gen/utils/python_utils.dart';
import 'package:flutter_gen/utils/edit_utils.dart';

class PyCodeTextController extends TextEditingController {
  final Map<String, TextStyle> mapping;
  final Pattern pattern;

  PyCodeTextController(this.mapping)
      : pattern =
            RegExp(mapping.keys.map((key) => RegExp.escape(key)).join('|'));
  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    late TextSpan textSpan;
    List<InlineSpan> children = [];
    // splitMapJoin is a bit tricky here but i found it very handy for populating children list
    text.splitMapJoin(
      pattern,
      onMatch: (Match match) {
        textSpan =
            TextSpan(text: match[0], style: style!.merge(mapping[match[0]]));
        children.add(textSpan);
        return match.toString();
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return text;
      },
    );
    return TextSpan(style: style, children: children);
  }
}

Map<String, TextStyle> getTextStyleMapFromList(
    List<String> items, TextStyle style) {
  late Map<String, TextStyle> result = Map<String, TextStyle>();
  for (var item in items) {
    result[item] = style;
  }
  return result;
}
