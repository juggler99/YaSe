import 'package:tuple/tuple.dart';

class StringUtils {
  static bool isEmpty(List<String> items) {
    int len = 0;
    items.forEach((element) => len += element.length);
    return len == 0;
  }
}

/// Returns a List<String> with Non Significant Characters
List<String> NonSignificantChars = ['\n', ':', ' '];

/// Returns a Tuple2<String, int> with the word at the given position and starting position of such word
//[direction]:
// -1: backwards
//  0: both
//  1: forwards
Tuple2<String, int> getWordAtPosition(String txt, int pos,
    [int direction = -1, bool verbose = false]) {
  if (verbose) print('pos: $pos');
  var result = Tuple2<String, int>('', -1);
  if (pos > txt.length) {
    return result;
  }
  if (pos < 0) pos = txt.length;
  int factor = 1;
  if (pos >= txt.length) factor = 0;
  String before = txt.substring(0, pos);
  String after = txt.substring(pos + factor);
  if (verbose) print("before: $before");
  if (verbose) print("after: $after");
  if (pos < txt.length && !NonSignificantChars.contains(txt[pos]))
    direction = 0;
  var regex = RegExp('\\s+');

  switch (direction) {
    case -1:
      var curWord = before.split(regex).last;
      int pos = before.lastIndexOf(curWord);
      return Tuple2<String, int>(curWord, pos);
    case 1:
      var curWord = after.split(regex).first;
      int pos = after.indexOf(curWord);
      return Tuple2<String, int>(curWord, pos);
    case 0:
      var curWord = before.split(regex).last;
      int pos = before.lastIndexOf(curWord);
      if (verbose) print('pos: $pos');
      if (verbose) print('curWord: $curWord');
      var chr = txt[pos];
      if (verbose) print('txt[pos].lenght: $chr');
      var last = before.split(regex).last;
      if (verbose) print('last: $last');
      var first = after.split(regex).first;
      if (verbose) print('first: $first');
      curWord = before.split(regex).last + txt[pos] + after.split(regex).first;
      return Tuple2<String, int>(curWord, pos);
    default:
      return result;
  }
}

/// Returns a Tuple3<String, String, int> with the text before the current word, the text after the current word and the new cursor position
// inputs:
// text, text to process
// curWord, current word in text (partial word ok)
// replacementWord, resulting word from keyword or matching word from text
// curWordPosition, position of curWord in text, so we can calculate new cursor position
Tuple3<String, String, int> getTextBeforeAfterCurWord(
    String text, String curWord, String replacementWord, int curWordPosition) {
  var beforeCurWord = text.substring(0, curWordPosition);
  var afterCurWord = "";
  if (text.length > curWordPosition + curWord.length) {
    afterCurWord = text.substring(curWordPosition + curWord.length);
  }
  // new cursor position should be cursor position + length of replacement work
  int newCursorPosition = curWordPosition + replacementWord.length;
  return Tuple3<String, String, int>(
      beforeCurWord, afterCurWord, newCursorPosition);
}
