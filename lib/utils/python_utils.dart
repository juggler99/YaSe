import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'dart:developer';

/// Returns a List<String> with Python keywords
List<String> keywords = [
  'and',
  'as',
  'assert',
  'break',
  'class',
  'continue',
  'def',
  'del',
  'elif',
  'else',
  'except',
  'finally',
  'for',
  'from',
  'global',
  'if',
  'import',
  'in',
  'is',
  'lambda',
  'None',
  'nonlocal',
  'not',
  'open',
  'or',
  'pass',
  'raise',
  'return',
  'try',
  'while',
  'with',
  'yield',
  'FALSE',
  'TRUE',
];

/// Returns a List<String> of python keywords that require a colon after them
List<String> colonKeywords = ['for', 'while', 'def', 'class', 'with'];

/// Returns a List<String> of python keywords
List<String> getKeywords() {
  //print(keywords);
  return keywords;
}

/// Returns a List<String> of matching python keywords to given pattern
List<String> getMatchingKeywords(String pattern) {
  try {
    if (pattern.length < 1) {
      return [];
    }
    List<String> result = [];
    for (var keyword in getKeywords()) {
      if (keyword.length >= pattern.length) {
        if (keyword.substring(0, pattern.length) == pattern) {
          result.add(keyword);
          // print('getMatchingKeywords add keyword: $keyword');
        }
      }
    }
    return result;
  } catch (exception) {
    print('getMatchingKeywords Exception: $exception');
    return [];
  }
}
