// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import './../../../utils/dlg_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  bool authorise(String email) {
    if (email.length > 0) {
      return true;
    }
    return false;
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
                      'Forgot Password',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                    height: 70,
                    padding: EdgeInsets.fromLTRB(10, 16, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: Text('Submit', style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        if (authorise(emailController.text)) {
                          Navigator.pushReplacementNamed(context, '/login');
                        } else {
                          if (emailController.text.length == 0) {
                            PromptUserBool(context, 'Forgot Password',
                                'Please enter a valid email adress', '', 'OK');
                          }
                        }
                      },
                    )),
              ],
            )));
  }
}
