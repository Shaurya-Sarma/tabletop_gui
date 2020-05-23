import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:tabletop_gui/screens/home/home.dart';
import 'package:tabletop_gui/screens/login/components/google_button.dart';
import 'package:tabletop_gui/screens/login/components/facebook_button.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _autoValidate = false;

  Future<void> userLogin() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();

      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
      } catch (e) {
        print(e.message);
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                autovalidate: _autoValidate,
                onSaved: (String input) => _email = input,
                validator: (String input) {
                  if (input.isEmpty) {
                    return "Please enter an email";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.visiblePassword,
                autovalidate: _autoValidate,
                onSaved: (String input) => _password = input,
                validator: (String input) {
                  if (input.isEmpty) {
                    return "Please enter a password";
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                )),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(bottom: 20.0),
            child: GestureDetector(
                onTap: () {
                  _formKey.currentState.save();
                  sendPasswordResetEmail(_email);
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.white70, fontSize: 16.0),
                )),
          ),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Color(0xff00B16A),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0),
                ),
                onPressed: () {
                  userLogin();
                },
              )),
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
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
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
