import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

String getCurrentTime({String format = "Hms"}) {
  switch (format) {
    case "Hms":
      return DateFormat.Hms().format(DateTime.now());
  }
  return "";
}
