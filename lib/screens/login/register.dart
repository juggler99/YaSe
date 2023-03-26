// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/utils/dlg_utils.dart';
import 'package:flutter_gen/utils/string_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool? authorise(String username, String password) {
    if (username.length > 0 && password.length > 0) {
      return true;
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Ya Se!'),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                    height: 70,
                    padding: EdgeInsets.fromLTRB(10, 12, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: Text('Submit', style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        if (!StringUtils.isEmpty([
                          nameController.text,
                          emailController.text,
                          passwordController.text
                        ])) {
                          PromptUserBool(context, 'Register', 'flow', 'OK', '');
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/login');
                        } else {
                          PromptUserBool(context, 'Register',
                              'Please enter valid values', '', 'OK');
                        }
                      },
                    )),
              ],
            )));
  }
}
