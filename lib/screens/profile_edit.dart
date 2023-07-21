import 'package:YaSe/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controls/header_with_tabs.dart';
import '../utils/tab_utils.dart';
import '../utils/textfield_utils.dart';
import './../yase/yase.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<_ProfileEditScreenState>();
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
      "nombre": getTextFieldContainer('Nombre', editorWidth),
      "apellido": getTextFieldContainer('Apellido', editorWidth),
      "fecha": getTextFieldContainer('Fecha de Nacimiento', editorWidth - 150,
          onTap: () => {_selectDate(context)})
    };

    textFieldsPassword = {
      "oldPassword": getTextFieldContainer('Old Password', editorWidth),
      "newPassword": getTextFieldContainer('New Password', editorWidth),
    };

    textFieldsCredito = {
      "creditos": getTextFieldContainer('Creditos', editorWidth),
    };

    textFieldsPago = {
      "tarjeta": getTextFieldContainer('Tarjeta', editorWidth),
      "expiracion": getTextFieldContainer('Expiracion', editorWidth),
      "secno": getTextFieldContainer('Seguridad', editorWidth),
    };

    _tabs = <Tab>[];
    _tabs.add(new Tab(
      text: 'Perfil',
    ));
    _tabs.add(new Tab(
      text: 'Password',
    ));
    _tabs.add(new Tab(
      text: 'Credito',
    ));
    _tabs.add(new Tab(
      text: 'Formas de Pago',
    ));

    _tabContent = <Widget>[];
    _tabContent.add(createForm(context, GlobalKey<_ProfileEditScreenState>(),
        textFieldsPerfil!.entries.map((e) => e.value).toList()));

    _tabContent.add(createForm(context, GlobalKey<_ProfileEditScreenState>(),
        textFieldsPassword!.entries.map((e) => e.value).toList()));

    _tabContent.add(createForm(context, GlobalKey<_ProfileEditScreenState>(),
        textFieldsCredito!.entries.map((e) => e.value).toList()));

    _tabContent.add(createForm(context, GlobalKey<_ProfileEditScreenState>(),
        textFieldsPago!.entries.map((e) => e.value).toList()));

    _tabController = TabController(length: _tabs.length, vsync: this);
    print("profile_edit, initstate");
    header = HeaderWithTabs(
        toolbarHeight: 100,
        title: "Perfil",
        items: <Widget>[],
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
