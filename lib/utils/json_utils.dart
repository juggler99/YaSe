import 'dart:convert';

String getPrettyJSONString(jsonObject) {
  var encoder = new JsonEncoder.withIndent("     ");
  return encoder.convert(jsonObject);
}

Map parseJson(String input) {
  const JsonDecoder decoder = JsonDecoder();
  return decoder.convert(input);
}
