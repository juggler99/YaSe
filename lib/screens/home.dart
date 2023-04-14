import 'package:YaSe/yase/yase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controls/bloc_controls/screen_size_provider/screen_size_bloc.dart';
import './../../../utils/drawer_utils.dart';
import './../../../utils/style_utils.dart';
import './../../../utils/menu_utils.dart';
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
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildButtonColumn(Icons.call, 'CALL', Theme.of(context)),
        buildButtonColumn(Icons.near_me, 'ROUTE', Theme.of(context)),
        buildButtonColumn(Icons.share, 'SHARE', Theme.of(context)),
      ],
    );

    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    widget._listView = ListView(
      children: [
        ElevatedButton(
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/pong');
          },
          child: const Text('Pong'),
        ),
        buttonSection,
        textSection
      ],
    );

    return Scaffold(
      appBar: AppBar(
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
                    context, Icons.account_box_sharp, 'Logout', 'loggedout'),
                getPopupMenuItemNav(
                    context, Icons.palette, 'Theme Manager', 'theme_manager'),
                getPopupMenuItemNav(context, Icons.add_circle_outline,
                    'Calculator', 'calculator'),
                getPopupMenuItemNav(context, Icons.add_circle_outline,
                    'Bloc Calculator', 'bloc_calculator'),
                getPopupMenuItemNav(
                    context, Icons.edit, 'Python Editor', 'documentManager'),
              ],
            )
          ]),
      drawer: Container(
          width: isCollapsed ? MediaQuery.of(context).size.width * 0.1 : null,
          child: Drawer(
              child: getListViewAsDrawer(context, 90, 'Ya Se!', [
            getListTile(context, Icon(Icons.account_circle_sharp), 'Me', 'me',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(context, Icon(Icons.book), 'Courses', 'courses',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(
                context, Icon(Icons.library_books), 'Programs', 'programs',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(
                context, Icon(Icons.computer_outlined), 'Complex', 'complex',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(context, Icon(Icons.computer_outlined), 'PythonClient',
                'python_client',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(context, Icon(Icons.edit), 'Editor', 'editor',
                edgeItems: const [10, 0, 0, 0]),
            getListTile(context, Icon(Icons.edit), 'Settings', 'settings',
                edgeItems: const [10, 0, 0, 0]),
          ]))),
      body: widget._listView,
    );
  }
}
