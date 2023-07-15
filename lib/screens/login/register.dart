// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../utils/button_utils.dart';
import '../../utils/form_utils.dart';
import '../../utils/textfield_utils.dart';
import './../../../utils/dlg_utils.dart';
import './../../../utils/string_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Map<String, Container>? textFields;
  List<Widget>? formItems;

  bool? authorise(String username, String password) {
    if (username.length > 0 && password.length > 0) {
      return true;
    }
    ;
    return null;
  }

  void processSubmit() {
    if (!StringUtils.isEmpty([
      (textFields!['nombre']!.child as TextField).controller!.text,
      (textFields!['apellido']!.child as TextField).controller!.text,
      (textFields!['fecha']!.child as TextField).controller!.text,
      (textFields!['email']!.child as TextField).controller!.text,
      (textFields!['password']!.child as TextField).controller!.text,
    ])) {
      PromptUserBool(context, 'Register', 'flow', 'OK', '');
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      PromptUserBool(
          context, 'Register', 'Please enter valid values', '', 'OK');
    }
  }

  @override
  void initState() {}

  List<Widget>? getRegisterFormItems(double editorWidth) {
    textFields = {
      "nombre": getTextFieldContainer('Nombre', editorWidth, readOnly: true),
      "apellido":
          getTextFieldContainer('Apellido', editorWidth, readOnly: true),
      "fecha": getTextFieldContainer('Fecha de Nacimiento', editorWidth - 150,
          readOnly: true),
      "email": getTextFieldContainer('Email', editorWidth, readOnly: true),
      "password":
          getTextFieldContainer('Password', editorWidth, readOnly: true),
    };
    formItems = textFields!.entries.map((e) => e.value).toList();
    formItems!.add(getElevatedButton(context, processSubmit, label: 'Submit'));
    return formItems;
  }

  @override
  Widget build(BuildContext context) {
    double editorWidth = MediaQuery.of(context).size.width - 10;
    formItems = getRegisterFormItems(editorWidth);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Ya Se!'),
        centerTitle: true,
      ),
      body: createForm(context, GlobalKey<_RegisterScreenState>(), formItems!),
    );
  }
}
