import 'package:intl/intl.dart';

String getCurrentTime({String format = "Hms"}) {
  switch (format) {
    case "Hms":
      return DateFormat.Hms().format(DateTime.now());
  }
  return "";
}
