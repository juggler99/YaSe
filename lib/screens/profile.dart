import 'package:YaSe/utils/button_utils.dart';
import 'package:YaSe/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controls/header.dart';
import '../controls/header_with_tabs.dart';
import '../utils/tab_utils.dart';
import '../utils/textfield_utils.dart';
import './../yase/yase.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<_ProfileScreenState>();
  AppBar? appBar;
  late List<Tab> _tabs;
  late List<Widget> _tabContent;
  TabController? _tabController;
  double screenSize = 100;
  double screenRatio = 1;
  Color bgColor = Colors.white;
  DateTime selectedDate = DateTime.now();
  HeaderWithTabs? header;

  TextEditingController usernameController = TextEditingController();
  Map<String, Container>? textFieldsPerfil;
  Map<String, Container>? textFieldsPassword;
  Map<String, Container>? textFieldsCredito;
  Map<String, Container>? textFieldsPago;

  @override
  void initState() {
    double editorWidth = YaSeApp.of(context)!.widget.YaSeAppWidth - 10;
    textFieldsPerfil = {
      "nombre": getTextFieldContainer('Nombre', editorWidth, readOnly: true),
      "apellido":
          getTextFieldContainer('Apellido', editorWidth, readOnly: true),
      "fecha": getTextFieldContainer('Fecha de Nacimiento', editorWidth - 150,
          readOnly: true),
      "password":
          getTextFieldContainer('Password', editorWidth, readOnly: true),
      "creditos":
          getTextFieldContainer('Creditos', editorWidth, readOnly: true),
    };

    textFieldsPago = {
      "tarjeta": getTextFieldContainer('Tarjeta', editorWidth, readOnly: true),
      "expiracion":
          getTextFieldContainer('Expiracion', editorWidth, readOnly: true),
      "secno": getTextFieldContainer('Seguridad', editorWidth, readOnly: true),
    };

    _tabs = <Tab>[];
    _tabs.add(new Tab(
      text: 'Perfil',
    ));
    _tabs.add(new Tab(
      text: 'Formas de Pago',
    ));

    _tabContent = <Widget>[];
    _tabContent.add(createForm(context, GlobalKey<_ProfileScreenState>(),
        textFieldsPerfil!.entries.map((e) => e.value).toList()));

    _tabContent.add(createForm(context, GlobalKey<_ProfileScreenState>(),
        textFieldsPago!.entries.map((e) => e.value).toList()));

    _tabController = TabController(length: _tabs.length, vsync: this);
    print("profile, initstate");
    header = HeaderWithTabs(
        toolbarHeight: 100,
        title: "Perfil",
        items: <Widget>[
          getIconButton(context, Icons.edit, 'Edit', () {
            Navigator.pushNamed(context, '/profile_edit');
          }, 1)
        ],
        tabs: _tabs,
        tabController: _tabController,
        tabBar: createTabBar(context, _tabs, _tabController!));

    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate.subtract(Duration(days: 100 * 365)),
        lastDate: selectedDate);
    if (picked != null && picked != selectedDate) {
      setState(() {
        (textFieldsPerfil!["fecha"]!.child! as TextField).controller!.text =
            '${DateFormat.yMd('en_UK').format(picked)}';
      });
    }
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCollapsed = false;
    Color color = YaSeApp.of(context)!.widget.AppTheme.primaryColor;
    screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: header, body: createTabView(_tabContent, _tabController!));
  }
}
