import 'package:flutter/material.dart';
import './../controls/edit_control_panel.dart';
import './../controls/edit_control_panel_custom.dart';
import 'package:flutter_gen/utils/dropdown_utils.dart';
import 'package:flutter_gen/utils/theme_utils.dart';
import 'package:tuple/tuple.dart';
import './../controls/dropdown_item_theme_color_panel.dart';
import 'package:flutter_gen/utils/style_utils.dart';
import './../yase/yase.dart';
import 'dart:developer';

class MeScreen extends StatefulWidget {
  const MeScreen({Key? key}) : super(key: key);
  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> with TickerProviderStateMixin {
  AppBar? appBar;
  List<Tab> tabList = [
    Tab(
      text: 'text1',
    )
  ];
  TabController? _tabController;
  double screenSize = 100;
  double screenRatio = 1;
  Color bgColor = Colors.white;

  @override
  void initState() {
    tabList.add(new Tab(
      text: 'Overview',
    ));
    tabList.add(new Tab(
      text: 'Workouts',
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  void onChangeColor(
      Color value, int index, String label, BuildContext context) {
    debugger();
    print('onChangeColor $index');
    setState(() {
      //bgColor = value;
    });
  }

  void onChangeTheme(ThemeData value, int index, String label) {
    print('onChangeTheme $index');
    setState(() {
      //bgColor = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCollapsed = false;
    Color color = Theme.of(context).primaryColor;
    screenSize = MediaQuery.of(context).size.width;

    appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0.0,
      centerTitle: true,
      title: const Text('Ya Se!'),
      automaticallyImplyLeading: true,
    );

    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text('Me'),
    );

    List<Widget> resolvedTabList = tabList;
    DropdownItemThemeColorPanel dropdownMenu = DropdownItemThemeColorPanel();
    List<Tuple2<String, Color>> blackWhites =
        getBlackWhiteColorsAsListOfTuples();

    return Container(
      color: Colors.pink,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: appBar,
            body: Stack(
              children: <Widget>[
                new Positioned(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          child: CircleAvatar(
                            //backgroundImage: NetworkImage(
                            //    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.5EPhNqoFJ_I7tDwoVhC7hQHaE7%26pid%3DApi&f=1'),
                            backgroundColor: Colors.green,
                            radius: 20,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                '* * * * *',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.pink),
                              ),
                              new Text('CAPTAIN',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18.0)),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  width: screenSize,
                  top: 230,
                ),
                new Positioned(
                  width: screenSize,
                  top: 320,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColor),
                          child: new TabBar(
                              controller: _tabController,
                              indicatorColor: Colors.pink,
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: tabList),
                        ),
                        new Container(
                          height: 20.0,
                          child: new TabBarView(
                            controller: _tabController,
                            children: resolvedTabList,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 70,
            height: 50,
            left: 30,
            width: 350,
            child: SizedBox(
                width: 350,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Text(
                            'Theme',
                            style: TextStyle(
                                fontSize: 20, backgroundColor: bgColor),
                          )),
                      Expanded(
                          flex: 9,
                          child: getCustomDropdownMenuForColor('Color',
                              width: 400, callback: onChangeColor))
                    ])),
          ),
          Positioned(
              top: 120, height: 50, left: 30, width: 350, child: dropdownMenu),
        ],
      ),
    );
  }
}
