// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:YaSe/yase/yase.dart';
import './../../../utils/dlg_utils.dart';
import './../../../utils/style_utils.dart';

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
    print(
        "primary color: ${YaSeApp.of(context)!.widget.AppTheme.primaryColor}");
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Ya Se!',
              style: YaSeApp.of(context)!.widget.AppTheme.textTheme.headlineSmall),
          centerTitle: true,
          backgroundColor: YaSeApp.of(context)!.widget.AppTheme.primaryColor,
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
                      style: YaSeApp.of(context)!
                          .widget
                          .AppTheme
                          .textTheme
                          .titleMedium,
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
                    style: YaSeApp.of(context)!
                        .widget
                        .AppTheme
                        .textTheme
                        .titleMedium,
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
                  style: generateTextButtonStyle(
                      YaSeApp.of(context)!.widget.AppTheme),
                  child: Text('Forgot Password?'),
                  //style: YaSeApp.of(context)!.widget.AppTheme.textTheme.bodyText1),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: generateButtonStyle(
                          YaSeApp.of(context)!.widget.AppTheme),
                      child: Text(
                        'Submit',
                        style: YaSeApp.of(context)!
                            .widget
                            .AppTheme
                            .textTheme
                            .titleLarge,
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
                        style: YaSeApp.of(context)!
                            .widget
                            .AppTheme
                            .textTheme
                            .titleSmall),
                    TextButton(
                      style: generateTextButtonStyle(
                          YaSeApp.of(context)!.widget.AppTheme),
                      child: Text(
                        'Register',
                        //style: YaSeApp.of(context)!.widget.AppTheme.textTheme.subtitle1,
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
