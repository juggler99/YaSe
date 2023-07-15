import "file_utils.dart";
import 'package:yaml/yaml.dart' show loadYaml;

Future<Map<String, dynamic>> loadYamlAsset(String path) async {
  final yamlString = await readAsync(path);
  final yamlMap = loadYaml(yamlString);
  print("yamlMap.keys: ${yamlMap.keys}");
  var result = Map<String, dynamic>.from(yamlMap);
  print("result.keys: ${result.keys}");
  return result;
}
