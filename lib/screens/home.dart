import 'package:YaSe/yase/yase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../controls/bloc_controls/screen_size_provider/screen_size_bloc.dart';
import '../data/course_data.dart';
import './../../../utils/drawer_utils.dart';
import './../../../utils/menu_utils.dart';
import 'package:html/dom.dart' as dom;

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
  }

  @override
  Widget build(BuildContext context) {
    final isCollapsed = false;
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
      appBar: AppBar(
          backgroundColor: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
          centerTitle: true,
          title: const Text('Ya Se!'),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            PopupMenuButton(
              itemBuilder: (BuildContext itemBuilder) => [
                getPopupMenuItemNav(
                    context, Icons.exit_to_app, 'Salida', 'loggedout'),
                /*
                getPopupMenuItemNav(
                    context, Icons.palette, 'Temas', 'theme_manager'),
                getPopupMenuItemNav(context, Icons.add_circle_outline,
                    'Calculadora', 'calculator'),
                getPopupMenuItemNav(context, Icons.add_circle_outline,
                    'Calculadora Bloc', 'bloc_calculator'),                
                getPopupMenuItemNav(
                    context, Icons.edit, 'Python', 'documentManager'),
                */
                getPopupMenuItemNav(context, Icons.account_circle_sharp,
                    'Mi Cuenta', 'profile'),
                getPopupMenuItemNav(
                    context, Icons.settings, 'Config', 'settings'),
                getPopupMenuItemNav(context, Icons.folder, 'Manejo de Archivos',
                    'file_manager'),
              ],
            )
          ]),
      drawer: Container(
          width: isCollapsed ? MediaQuery.of(context).size.width * 0.1 : null,
          child: Drawer(
              child: getListViewAsDrawer(context, 90, 'Ya Se!', [
            getListTile(context, Icon(Icons.book), 'Cursos', 'courses',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(context, Icon(Icons.edit), 'Python', 'documentManager',
                edgeItems: const [10, 0, 0, 0]),

            /*
            getListTile(context, Icon(Icons.account_circle_sharp), 'Me', 'me',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(
                context, Icon(Icons.library_books), 'Programas', 'programs',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(context, Icon(Icons.computer_outlined), 'PythonClient',
                'python_client',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(context, Icon(Icons.edit), 'Editor', 'editor',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(context, Icon(Icons.html), 'Browser', 'browser',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(context, Icon(Icons.edit), 'Settings', 'settings',
                edgeItems: const [10, 0, 0, 0]),
            */
          ]))),
      body: widget._listView,
    );
  }
}
