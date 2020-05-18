import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tabletop_gui/components/username_textfield.dart';
import 'package:tabletop_gui/components/password_textfield.dart';
import 'package:tabletop_gui/screens/login/components/google_button.dart';
import 'package:tabletop_gui/screens/login/components/facebook_button.dart';
import 'package:tabletop_gui/screens/login/components/login_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          UsernameTextfield(),
          PasswordTextfield(),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.white70, fontSize: 16.0),
            ),
          ),
          LoginButton(),
          Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
            child: Text(
              "Or Connect With",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[GoogleAuthButton(), FacebookAuthButton()],
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RichText(
                text: TextSpan(
                  text: "Don't Have An Account? ",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Register Here',
                      style: TextStyle(color: Colors.red),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "/register");
                        },
                    ),
                  ],
                ),
              )),
        ]));
  }
}
