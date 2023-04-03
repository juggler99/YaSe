// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import './../../../utils/dlg_utils.dart';
import './../../../utils/style_utils.dart';
import 'dart:developer';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool authorise(String username, String password) {
    if (username.length > 0 && password.length > 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Ya Se!', style: Theme.of(context).textTheme.headline5),
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
                      'Sign in',
                      style: Theme.of(context).textTheme.subtitle1,
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
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    style: Theme.of(context).textTheme.subtitle1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgotPassword');
                  },
                  style: generateTextButtonStyle(Theme.of(context)),
                  child: Text('Forgot Password?'),
                  //style: Theme.of(context).textTheme.bodyText1),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: generateButtonStyle(Theme.of(context)),
                      child: Text(
                        'Submit',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      onPressed: () {
                        bool isAuthorised = authorise(
                            nameController.text, passwordController.text);
                        if (isAuthorised) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          PromptUserBool(
                              context,
                              'Login',
                              'Invalid login details, please try again',
                              '',
                              'OK');
                        }
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('No account?',
                        style: Theme.of(context).textTheme.subtitle2),
                    TextButton(
                      style: generateTextButtonStyle(Theme.of(context)),
                      child: Text(
                        'Register',
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
