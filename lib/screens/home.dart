import 'package:YaSe/yase/yase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../controls/bloc_controls/screen_size_provider/screen_size_bloc.dart';
import '../controls/header.dart';
import '../data/01_intro.dart';
import './../../../utils/drawer_utils.dart';
import './../../../utils/menu_utils.dart';
import 'package:html/dom.dart' as dom;
import 'dart:developer';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
  ListView? _listView;

  void setBodyListView(ListView listView) {
    this._listView = listView;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  Header? header;
  Drawer? drawer;
  Container? containerDrawer;
  final isCollapsed = false;
  void menuAction(ListTile value) {
    String testText = value.title.toString();
    var _screenSizeProvider = ScreenSizeBloc();
    switch (testText) {
      case 'Logout':
        print('Hello');
        Navigator.pushNamed(context, '/login');
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    List<Widget> items = <Widget>[];
    items.add(IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {},
    ));
    items.add(PopupMenuButton(
        itemBuilder: (BuildContext itemBuilder) => [
              getPopupMenuItemNav(
                  context, Icons.exit_to_app, 'Salida', 'loggedout'),
              getPopupMenuItemNav(
                  context, Icons.account_circle_sharp, 'Mi Cuenta', 'profile'),
              getPopupMenuItemNav(
                  context, Icons.settings, 'Config', 'settings'),
              getPopupMenuItemNav(
                  context, Icons.folder, 'Manejo de Archivos', 'file_manager'),
            ]));
    print("home, initstate");
    header = Header(toolbarHeight: 40, title: "Ya Se", items: items);
    drawer = Drawer(
        child: getListViewAsDrawer(context, 40, 'Ya Se!', [
      getListTile(context, Icon(Icons.book), 'Cursos', 'courses',
          edgeItems: const [10, 0, 0, 0]),
      getListTile(context, Icon(Icons.edit), 'Python', 'documentManager',
          edgeItems: const [10, 0, 0, 0]),
    ]));

    containerDrawer = Container(
        width: isCollapsed ? MediaQuery.of(context).size.width * 0.1 : null,
        child: drawer);
  }

  @override
  Widget build(BuildContext context) {
    YaSeApp.of(context)?.widget.YaSeAppWidth =
        MediaQuery.of(context).size.width;
    YaSeApp.of(context)?.widget.YaSeAppHeight =
        MediaQuery.of(context).size.height;
    double visibleHeight = MediaQuery.of(context).size.height +
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    var screenSizeBlocReader = context.read<ScreenSizeBloc>().add(
        ScreenSizeBlocUpdateEvent(
            screenName: "home", visibleHeight: visibleHeight));
    print("autocomplete visibleHeight: $visibleHeight");
    String? htmlData;
    dom.Document? document;
    Html? html;

    html = Html(data: html_data);

    /*
    Future.delayed(Duration.zero, () async {
      debugger;
      // htmlData = await read('assets/html/course2.html');
      htmlData = html_data;
      document = htmlparser.parse(htmlData);
      html = Html(data: htmlData);
    });
*/

    Widget textSection =
        SingleChildScrollView(padding: EdgeInsets.all(32), child: html);

    widget._listView = ListView(
      children: [textSection],
    );

    return Scaffold(
      appBar: header,
      drawer: containerDrawer,
      body: widget._listView,
    );
  }
}
