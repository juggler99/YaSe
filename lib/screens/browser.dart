import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:YaSe/yase/yase.dart';
import 'package:supercharged/supercharged.dart';
import '../utils/time_utils.dart';
import './../../../utils/style_utils.dart';
import './../../../utils/dropdownlist.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:web_browser/web_browser.dart';
import 'dart:developer';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({Key? key}) : super(key: key);

  @override
  _BrowserScreenState createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  TextEditingController addressController = TextEditingController();
  final logger = Logger('PyEditorState');
  Browser? _browser = null;

  String htmlData = """<div>
  <h1>Demo Page</h1>
  <p>This is a fantastic product that you should buy!</p>
  <h3>Features</h3>
  <ul>
    <li>It actually works</li>
    <li>It exists</li>
    <li>It doesn't cost much!</li>
  </ul>
  <!--You can pretty much put any html in here!-->
</div>""";

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    //addressController.addListener(_onUrlChange);
    addressController.text = "pythonanywhere.com";
  }

  String getUri(String url) {
    print("getUri: $url");
    const String prefix = "https://";
    if (!url.startsWith(prefix)) {
      url = prefix + url;
    }
    print("getUri: $url");
    return url;
  }

  void _onUrlChange() {
    var keystrokes = addressController.text;
    print("_onUrlChange: $keystrokes");
    if (keystrokes.endsWith("\n")) {
      print("Yeah");
    }
  }

  void navigateToUrl(String url) {
    print("navigateToUrl: $url");
    _browser!.controller?.goTo(getUri(url));
  }

  @override
  Widget build(BuildContext context) {
    Widget textSection = Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: addressController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'URL',
        ),
        onChanged: (value) {
          navigateToUrl(value);
        },
      ),
    );

    _browser = Browser(
        initialUriString: getUri(addressController.text), topBar: textSection);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
        centerTitle: true,
        title: const Text('Browser'),
        automaticallyImplyLeading: true,
      ),
      body: _browser,
    );
  }
}
