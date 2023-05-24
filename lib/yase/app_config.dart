import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfig {
  AppConfig._internal();

  static final _globConfig = "globConfig";

  static final _singleton = AppConfig._internal();

  factory AppConfig() {
    return _singleton;
  }
  Map<String, dynamic>? config;

  static Future<AppConfig> loadConfig({String filename = 'app_config'}) async {
    // load the json file
    final contents = await rootBundle.loadString(
      'assets/config/$filename.json',
    );

    // decode our json
    final json = jsonDecode(contents);

    // convert our JSON into an instance of our AppConfig class
    _singleton.config = json;
    return _singleton;
  }

  static Map<String, dynamic>? getConfig() => _singleton.config;
}
