import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tabletop_gui/components/username_textfield.dart';
import 'package:tabletop_gui/screens/register/components/email_textfield.dart';
import 'package:tabletop_gui/components/password_textfield.dart';
import 'package:tabletop_gui/screens/register/components/register_button.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            UsernameTextfield(),
            EmailTextfield(),
            PasswordTextfield(),
            RegisterButton(),
            Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: RichText(
                  text: TextSpan(
                    text: "Already Have An Account? ",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login Here',
                        style: TextStyle(color: Color(0xff00B16A)),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "/login");
                          },
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
